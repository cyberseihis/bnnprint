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
I expected this one to do worse than bnnparw and it did.
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

Truncating subexpressions impeded datapath extraction and so the results
were negative for most datasets, althougth Har and winewhite improved a
bit. I interpreted this a sign that a similar method could work if I
used an order of operations in which arithmetic operations that are
common between neurons are shared. I first tried to get the arithmetic
operations that are used after optimization by Design Compiler from the
analysis of datapath extraction report it provides. Then I decided I 
would rather not have to synthesize twice and searched for an algorithm
to do a similar arithmetic optimization beforehand.

# BNNPARSIGN -> BNNPAAR

# BNNPAAR -> BNNPAARX

# BNNPAAR -> BNNPAARTER

# BNNSEQ

# BNNSEQ -> BNNDIRECT

# BNNDIRECT -> BNNDW

# BNNDW -> BNNDSAT

# BNNSEQ -> BNNROLIN

# BNNROLIN -> BNNROMEM

# BNNROMEM -> BNNROMESH

# BNNROMESH -> BNNROMESX

# BNNROMESH -> BNNROPERM

# BNNROMESH -> BNNROSPINE

# BNNROSPINE -> BNNROSPINOR

# BNNROSPINE -> BNNROBUS

# BNNPAR -> TNNPAR
TNNPARSIGN
TNNPARW
TNNPAAR
TNNPAARTER

# BNNSEQ -> TNNSEQ

# TNNSEQ -> TNNZEQ

# TNNZEQ -> TNNZEW

