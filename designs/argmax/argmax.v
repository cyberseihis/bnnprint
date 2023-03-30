module argmax #(
    parameter SIZE = 9,
    parameter K = 4,
    parameter I = 4
) (
    input [SIZE*K-1:0] inx,
    output [I-1:0] outimax
);

wire [SIZE*I-1:0] startindz;

genvar j;
generate
for (j = 0; j < SIZE; j = j + 1) begin : whatss
    assign startindz[j*I+:I] = j;
end
endgenerate

maxwrap #(.N(SIZE),.K(K),.I(I)) mxw (
    .in(inx),
    .iin(startindz),
    .outimax(outimax)
);

endmodule
