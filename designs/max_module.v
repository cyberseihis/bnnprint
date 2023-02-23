module max_module #(
  parameter K = 8,
  parameter I = 2
) (
  input [K-1:0] a,
  input [K-1:0] b,
  input [I-1:0] ia,
  input [I-1:0] ib,
  output [K-1:0] max_out,
  output [I-1:0] imax_out
);

    assign max_out = (a >= b) ? a:b;
    assign imax_out = (a >= b) ? ia:ib;

endmodule

