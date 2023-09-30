












module cardio_bnn1_bnnrospine #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 3,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000


  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  localparam Weights0 = 57'b011101100001000101110111101111101011101100001001111011101 ;
  localparam Weights1 = 9'b001100110 ;

  rospine_seq #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
