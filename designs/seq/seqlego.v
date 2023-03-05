module seqlego #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 4,
  parameter C = 4
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [SumL*C-1:0] out
  );
  
  localparam SumL = $clog2(M+1);
  wire [M-1:0] midd;
  wire nxt;

  seqq #(.N(N),.B(B),.M(M)) layer1 (
    .clk(clk),
    .rst(rst),
    .data(data),
    .out(midd),
    .done(nxt)
  );

 xnorseqq #(.N(M),.M(C)) layer2 (
    .clk(clk),
    .rst(rst),
    .enable(nxt),
    .data(midd),
    .sums(out)
 );
  
endmodule
