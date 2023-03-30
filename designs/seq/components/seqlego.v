module seqlego #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter CLASS_CNT = 4,
  parameter Weights0 = 0,
  parameter Weights1 = 0
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] data,
  output [$clog2(HIDDEN_CNT+1)*CLASS_CNT-1:0] out
  );
  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [HIDDEN_CNT-1:0] hidden;
  wire next_layer;

  seqq #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.Weights(Weights0)) layer1 (
    .clk(clk),
    .rst(rst),
    .features(data),
    .hidden(hidden),
    .done(next_layer)
  );

 xnorseqq #(.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights(Weights1)) layer2 (
    .clk(clk),
    .rst(rst),
    .enable(next_layer),
    .features(hidden),
    .scores(out)
 );
  
endmodule
