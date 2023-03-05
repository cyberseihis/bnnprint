module argmax #(
    parameter N = 9,
    parameter K = 4,
    parameter I = 4
) (
    input [N*K-1:0] inx,
    output [I-1:0] outimax
);

wire [N*I-1:0] startindz;

genvar j;
generate
for (j = 0; j < N; j = j + 1) begin : whatss
    assign startindz[j*I+:I] = (N-1)-j;
end
endgenerate

maxwrap #(.N(N),.K(K),.I(I)) mxw (
    .in(inx),
    .iin(startindz),
    .outimax(outimax)
);

endmodule
