module max_module #(
  parameter K = 8
) (
  input [K-1:0] a,
  input [K-1:0] b,
  output [K-1:0] max_out
);

    assign max_out = (a >= b) ? a:b;

endmodule

