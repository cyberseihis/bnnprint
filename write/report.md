# GENERAL INFO
All bnns follow a similar architecture that consists
of an input layer with 4 bit features, a hidden layer
with 40 neurons and an output layer followed by argmax.
The inputs of first layer of the model are not binarized,
as that does not leave enough representational ability to
enable classification. The outputs of the last layer are also
not binarized as they are compared to determine the most propable class.

Designs and models labeled "bnn" are fully connected.
Weights and hidden neuron activations are either 1 or -1.
Designs and models labeled "tnn" have weights in {-1, 0, 1}.
Hidden activations are left as binary, so they are ternary weight
networks and not full ternary networks.
Instead of using arithmetic with ternary weights they are implemented
as sparse bnns, where weights with a value of 0 mean a missing connection.

The first layer is implemented as additions and subtractions of the
input features. The second layer is implemented as the sum of the
binarized activations xnored by the weights.

Models have been trained with binary and ternary weights for six small
datasets with sensor features. For each of the following designs the
model of each dataset has been implemented and has been tested to make
sure the verilog design picks the same class as the model in python for
the first 1000 samples of the dataset.
They have been synthesized and the resuting area and power are given for
each. If a design is based on a previous design the metrics for both are
shown for comparison.

Since bnns are easier to try things with some designs for bnns have no
tnn equivelant yet.

When a design is derived from an earlier design it will be annotated as
**EARLIER DESIGN -> NEW DESIGN**.

Due to a self-imposed deadline only the descriptions for bnn designs
are completed. The descriptions for tnn designs will follow soon.

# BNNPAR
In bnnpar the arithmetic operations for each neuron are written out in
verilog. For first layer neurons the features that correspond to
positive weights are split from those that correspond to negative weights,
the sum of each is calculated seperately and the two sums are compared to
get the sign of the total sum, which is the output of the neuron. Here is an example:
```
assign positives[0] = + feature_array[1] + feature_array[2] + ... + feature_array[10];
assign negatives[0] = + feature_array[0] + feature_array[3] + feature_array[5];
assign hidden[0] = positives[0] >= negatives[0];
```
For second layer neurons the hidden features that correspond to positive
weights are summed as is and those that correspond to negative weights the
inverse is added to the sum. This is equivelant to adding the result of
the xnor of the activation with the weight. Example("hidden_n" the inverse
of the array of hidden features, which is "hidden"):
```
assign scores[0*SUM_BITS+:SUM_BITS] = + hidden_n[0] + hidden[1] + hidden[2] + ... + hidden_n[39];
```
# BNNPAR -> BNNPARSIGN
The difference from bnnpar is all the input features are added together
in the first layer instead of split in positives and negatives. Features
that correspond to weights of the neuron that are 1 are added and those
of weights that are -1 are subtracted. Example:
```
wire signed [8:0] intra_0;
assign intra_0 = - feature_array[0] + feature_array[1] + ... + feature_array[10];
assign hidden[0] = intra_0 >= 0;
```
It results to a significant improvement compared to spliting the features.
I expected the oposite to happen, thinking that only using additions would
lead to more partial results being same between neurons and thus 
increasing sharing hardware. I assume the reason it is better is  that having all variables in the same expression per neuron allows for more 
posibilities in rearanging them to share subexpressions.

# BNNPARSIGN -> BNNPARW
Bnnparw differs with bnnparsign only in the number of bits that are
used for the result of the operations of the hidden neurons.
In bnnparsign all total sums have the maximum width a series of sums and
subtractions of as many 5-bit integers as the inputs could take. In bnnparw each neuron gets assigned the minimum bitwidth needed to fit all the
results it encounters in evaluating all the samples of the dataset. The
bitwidth used for the operations is thus reduced. Unfortunately this
truncation can block datapath extraction, leading the results to be
worse for pendigits.
Bnnparpnw is the equivelant for bnnpar, where the minimum bitwidth for the
positive and negative components of the neuron sum is used.

# BNNPARW -> BNNPARCE
For each hidden neuron the average of the maximum and minimum value it's
total sum can take is subtracted from the sum in order to make the range
of values centered on zero and thus reduce the bitwidth needed for it.
Example: if the highest value the total of the neuron takes is 300 and
the lowest is -100, we need a 10 bit signed integer to fit all values.
If we subtract their average(100) the values will be in the range -200
to 200, so they fit in a 9 bit signed integer.
RESULTS
Subtracting the closest power of two that gets the range of values to
a reduced bitwidth may do better.

# BNNPARW -> BNNSTEPW
For each hidden neuron we add/subtract the features in order for each
sample of the dataset. For each step of the process we find what the
minimum bitwidth to hold each of the values is.
For example we will need 5 bits for the just the first feature, 6 for
feature 1 + feature 2, 7 bits for feature 1 + feature 2 - feature 3 and
so on.

Sometimes due to the order of additions and subtractions the width needed
at a later step is less than the one of an earlier step. This is because
every sample for which there would be an overflow in the earlier step
with the smaller width would at some following feature underflow back in
the range it supports. This has been taken into account.

I expected this one to do worse than bnnparw and it did.
Truncating subexpressions impeded datapath extraction and so the results
were negative for most datasets, althougth Har and winewhite improved a
bit.

# BNNPARSIGN -> BNNPAAR, BNNPAARX, BNNPAARTER
Since bnnstepw didn't work I thought finding the order of operations
Design Compiler uses after optimization and truncating widths there
may fare better. I first tried to get the arithmetic
operations that are used after optimization from the
analysis of datapath extraction report it provides. It turned out to
be harder than expected and having to synthesize twice is suboptimal
so I searched for an algorithm to do a similar arithmetic optimization
beforehand.

Paar's algorithm, found in [1] is used. It is explained well
in that paper so I won't repeat the explanation here. Paar's algorithm
considers the case where elements are only added, so to make it work
for our case where there are also subtractions the negatives of input
features are treated as seperate additional elements, so the operations
for all neurons can be written with additions only.

By running it on the weight matrix of the first layer we get a series
of additions between pairs of input features and/or intermediate results
that calculate the total sum of each neuron. The additions are
implemented in the same order in the design with an array to hold the
intermediate results. Bitwidths for intermediate and final results
were left at the default width from bnnparsign, custom widths were
not implemented.
Designs that have only the first layer implementing the operations
found from the algorithm are called bnnpaar and those that have
both layers are bnnpaarx.

Paar's algorithm was also expanded to work with subtractions.
The implementation will be described seperately. Since it also uses
subtraction it gives shorter series of operations. Designs using
the ternary expansion in the first layer are called bnnpaarter.

I expected the results to be worse for all designs since Design
Compiler would use the best available heuristics, so the fact
hardcoding the order of operations with Paar's algorithm and the
ternary expansion had up to 30% area reduction for some designs,
even though it was worse for cardio and gasId, makes me suspect
I have somehow crippled the datapath extraction of bnnparsign,
though I don't see what could be a problem.

# BNNSEQ
This implements the layers sequentialy in regards to the inputs of the
layer, meaning each neuron has an accumulator and each cycle it is 
active it adds/subtracts the an input feature. All neurons update
on the the same feature on the same cycle.
Features get chosen to be the current sample in order.
In the first layer a counter and multiplexer is used to pick the current
sample. Features are picked in order. The column of binary weights that
corresponds to the feature also gets picked from the weight matrix.
Each accumulator receives as input the current feature and the weight bit
of it's neuron and feature and depending on the weight bit either adds or
subtracts the feature from it's running total.

Once the counter reaches the last feature a flag that signals the first
layer is done is set. This enables the second layer to start
accumulating and freezes the first layer.
Instead of choosing the weight bit that corresponds to each hidden
feature and neuron and adding their xnor the second layer hardcodes
the vector from which a neuron recieves it's inputs so it has the output
of the previous layer in the position of an activation if the
activation's weight with the neuron is 1 and it's inverse otherwise.

That way the accumulators of the second layer are simply counters with
an enable signal that is set to the bit they would have to add.
The results of the second layer are passed to an argmax module that
returns the predicted class.

A design where shift registers where used to hold the weights
instead of indexing a constant array with the counter was also attempted
but turned out to be far worse.

# BNNSEQ -> BNNDIRECT
The difference of bnndirect with bnnseq is it also uses a hardcoded
input vector for each neuron in the first layer instead of just the second.
For each 4-bit input feature and every neuron a 5-bit signed seqment of the
neuron's custom input vector is set to either the feature or the negative
of the feature.

It improves area and power except in the case of gasId, which has an order
of magnitude more input features than other datasets and thus scales
differently.

# BNNDIRECT -> BNNDW
Bnndw is bnndirect with first layer accumulators getting their bitwidth
set to the minimum needed similarly to bnnparw.
The gains are more pronounced than the parallel case since the registers
take up a significant portion of the resources and each bit shaved off
an accumulator's range removes a flip-flop.

# BNNDW -> BNNDSAT
In bnndsat saturation is used in combination with bnndw's truncation to
reduce the number of registers farther. Using the DW_addsub_dx module
from designware the result of adding a sample to the value of the
accumulator is set to the maximum value the accumulator can hold in the
case it would otherwise overflow and similarly to the minimum value it can
fit in case of underflow.

The bitwidth needed to have the final value after all samples are added
have the correct sign using saturation is shrunk for many neurons.
For neurons where saturation doesn't reduce the number of bits in the
accumulator simple truncation is used instead to avoid the overhead.

(Note: for some reason the simulation module of DW_addsub_dx slowed
simulation with iverilog by two orders of magnitude.)

# BNNROLIN
Also a sequential design, this time the outputs of the layer being
the dynamic dimension instead of the inputs as in bnnseq. This means
that each layer has a single adder tree that computes the output of a
single neuron of the layer per cycle.

In the first layer a custom input vector per neuron is used again like
bnndirect. The adder sums the entire vector of the neuron and the sign
of the result is stored to a register corresponding to the layers output.
Instead of having the negative of the input feature in positions of the
vector that have weight -1 the inverse of it's 5-bit expansion is used.
With the idea that the negative in 2's compliment is the inverse plus 1,
we add a correction term equal to the number of negative weights of the
neuron to the sum to get the correct result.
The correction terms are stored at an array of constants and are indexed
by the counter like the input vectors.
This was measured to be more efficient.

After the counter of the first layer reaches the last neuron the next
layer is activated in a similar fashion with previous sequential designs.
Unlike the first layer the second doesn't need to store the outputs of all
it's neurons. Since it is the last layer we can store only the largest value
seen thus far in a register and only overwrite it when the result of the
current neuron is larger. Along with this the value of the counter (which
corresponds to the index of the neuron) is also written into a register each
time the current result is larger than the previous best. This way the
argmax is calculated at the same time as the output neurons.

# BNNROLIN -> BNNROMEM
Instead of hardcoding a custom input vector for each neuron the row of
weights that correspond to each neuron are indexed from the weight 
matrix by the counter and the 5-bit expansion of each input feature is
xnored by it's weight bit.

# BNNROMEM -> BNNROMESH
Instead of a decoder from the counter to index the register bit
the current result of the first layer should be written to,
bnnromesh stores the value at the end of a shifting register.
At each cycle the register array shifts right once, so when the last
neuron's result is written at the left-most position the first neuron's
result reaches the right-most position and all the results are stored
in order.

# BNNROMESH -> BNNROMESX
This design was implemented mostly out of curiosity and not
because it would help much.

Since the counter is not used to index the position the result is
stored, the sequence of values it takes doesn't have to be 
linear(0, 1, 2..). Instead of a 6-bit counter we can use any FSM that
gives a sequence of 40 unique 6-bit values in it's place, given that
we replace the array of weights we indexed with the counter's values
with a lookup table with the new sequence's values as indexes.
The smallest such FSM is a linear-feedback shift register with a single
xor gate for the two most significant bits, so that is implemented.

The gain from removing a 6-bit add-1 circuit is negligable and I don't
think the lookup table was implemented as well as it could so the
results were negative.

# BNNROMESH -> BNNROPERM
This design was also implemented mostly out of curiosity.

I had a vague notion that the logic that implements the decoder from the counter to the weights would be simpler if weight rows with
"more similar" bits corresponded to counter values with "more similar"
bits. To try to test that I made a graph of the hamming distances of the 
neuron weights and got an aproximate solution to TSP on it to get a
sequence of neurons that minimises the number of bit changes between
neighbouring neurons. I then got a similar sequence for the values of
the counter (i.e. numbers 0-39) and permuted the rows of the weight
matrix so the i-th neuron in the sequence maps to the i-th value in the
counter sequence.
The columns of the second layer's weight matrix had the same permutation
applied to them so the second layer's results are not affected.

The area increased in half the datasets and decreased in the other
half, so it doesn't seem to be better than a random permutation.

# BNNROMESH -> BNNROSPINE
The shifting regiter that stores the 1st layer's outputs gets initialised
with a 1 in the left-most position and 0s in all other positions. A
circuit that outputs a one-hot vector where only the bit in the position
of the left-most nonzero bit in the shifting register is set to 1 is
added.
That implements a one-hot shifting register that encodes the index
of the currently calculated neuron without using additional memory
elements.

Using the bits of the one-hot vector as select signals for the weight
rows the counter and it's encoder can be removed, leading in efficiency
gains.

# BNNROSPINE -> BNNROSPINOR
Instead of the lookup table used for weights in bnnrospine,
the current weight that corresponds to a given input feature is
calculated by a NOR of the bits of the one-hot vector in positions
where the weight column of the feature would be -1.

Except for cardio, it is an improvement.

# BNNROSPINE -> BNNROBUS
Every input feature gets the current weight bit from an open bus to
which a tristate buffer for each entry in the feature's column in
the weight matrix is connected. Each buffer in a bus corresponds
to a neuron and is controled by that neuron's select signal from the
one-hot vector.

Decent improvements in power are achieved at the cost of significantly
larger areas. At least the power for pendigits got under 30 mW, which
I'm happy about.

# TODO: Descriptions for tnn designs

[1] Banik, S., Funabiki, Y., Isobe, T. (2019). More Results on Shortest Linear Programs. In: Attrapadung, N., Yagi, T. (eds) Advances in Information and Computer Security. IWSEC 2019. Lecture Notes in Computer Science(), vol 11689. Springer, Cham. https://doi.org/10.1007/978-3-030-26834-3_7
