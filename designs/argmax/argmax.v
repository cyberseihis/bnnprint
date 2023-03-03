module argmax #(
    parameter N = 9,
    parameter K = 4,
    parameter I = 4
) (
    input [N*K-1:0] inx,
    output [I-1:0] outimax
);

localparam G = $clog2(N); // numoflayers
// Generate multiple instances of the f module

wire [N*I-1:0] startindz;

genvar j;
generate
for (j = 0; j < N; j = j + 1) begin : whatss
    assign startindz[j*I+:I] = j;
end
endgenerate


wire [N*K-1:0] valz [G:0];
wire [N*I-1:0] indz [G:0];

assign valz[0] = inx;
assign indz[0] = startindz;

genvar i,n;
for (i = 1; i <= G; i = i + 1) begin : f_instances
    maxreducer #(.N(i), .K(K), .I(I)) mxr (
        .in(valz[i-1]),
        .iin(indz[i-1]),
        .out(valz[i]),
        .iout(indz[i])
    );
    assign n = (n+1)/2;
end

assign outimax = indz[G];

endmodule
