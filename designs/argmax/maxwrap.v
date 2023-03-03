module maxwrap #(
  parameter N = 8,
  parameter K = 4,
  parameter I = 2
) (
  input [N*K-1:0] in,
  input [N*I-1:0] iin,
  output [I-1:0] outimax
);

if (N!=1) begin: xdg

wire [(N+1)/2*K-1:0] out;
wire [(N+1)/2*I-1:0] iout;

maxreducer #(.N(N), .K(K), .I(I)) mxr (
    .in(in),
    .iin(iin),
    .out(out),
    .iout(iout)
);


maxwrap #(.N((N+1)/2), .K(K), .I(I)) mwp (
    .in(out),
    .iin(iout),
    .outimax(outimax)
);
end
else 
    assign outimax = iin;




endmodule
