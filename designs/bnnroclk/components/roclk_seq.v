module roclk_seq #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter CLASS_CNT = 4,
  parameter Weights0 = 0,
  parameter Weights1 = 0
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );
  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [HIDDEN_CNT-1:0] hidden;
  reg next_layer;
  // Implicit assumption that there are more
  // hidden neurons than classes
  reg [$clog2(HIDDEN_CNT)-1:0] cnt;

  first_layer_roclk #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.Weights(Weights0)) layer1 (
    .clk(clk),
    .rst(rst),
    .features(features),
    .hidden(hidden),
    .cnt(cnt),
    .enable(!next_layer)
  );

 xnor_roclk #(.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights(Weights1)) layer2 (
    .clk(clk),
    .rst(rst),
    .enable(next_layer),
    .features(hidden),
    .cnt(cnt),
    .winner(prediction)
 );
  
  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
          next_layer <= 0;
      end
      else if(cnt<HIDDEN_CNT-1) begin
          cnt <= cnt + 1;
      end else begin
          cnt <= 0;
          next_layer <= 1;
      end
  end
  
endmodule
