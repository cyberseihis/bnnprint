module argmax #(
    parameter SIZE = 9,
    parameter BITS = 4,
    parameter INDEX_BITS = 4
) (
    input [SIZE*BITS-1:0] inx,
    output [INDEX_BITS-1:0] outimax
);

wire [INDEX_BITS-1:0] interm_argmax [SIZE-1:0];
wire [BITS-1:0] interm_max [SIZE-1:0];

assign interm_max[0] = inx[0+:BITS];
assign interm_argmax[0] = 0;

genvar j;
generate
for (j = 1; j < SIZE; j = j + 1) begin : whatss
	wire huge; //Flag that tracks if current sample is largest so far
	assign huge = inx[j*BITS+:BITS] > interm_max[j-1];
	assign interm_max[j] = huge ? inx[j*BITS+:BITS]:interm_max[j-1]; 
	assign interm_argmax[j] = huge ? j:interm_argmax[j-1];
end
endgenerate

assign outimax = interm_argmax[SIZE-1];

endmodule
