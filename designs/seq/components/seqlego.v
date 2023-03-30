module seqlego #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 4,
  parameter C = 4,
  parameter Weights0 = 0,
  parameter Weights1 = 0
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [$clog2(M+1)*C-1:0] out
  );
  
  localparam SumL = $clog2(M+1);
  wire [M-1:0] midd;
  wire nxt;

  seqq #(.N(N),.B(B),.M(M),.Weights(Weights0)) layer1 (
    .clk(clk),
    .rst(rst),
    .data(data),
    .out(midd),
    .done(nxt)
  );

 xnorseqq #(.HIDDEN_CNT(M),.CLASS_CNT(C),.Weights(Weights1)) layer2 (
    .clk(clk),
    .rst(rst),
    .enable(nxt),
    .features(midd),
    .sums(out)
 );
  
endmodule
