












module Har_bnn1_bnnromesh #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  localparam Weights0 = 480'b010011011001001100101101110001110010101011110010111001110001101001101010010011110101100110000101000100000111110100000001101110101101000110000001100100000001110000111111100111001110011001111010101000111100000011110011111011101000100111100110001101001001000110110111001011101011010111110100111000111100000011000000000100101111000110010101011010001100110101000100110101010101111011111000111000010110111000110001001110000010001100000101000000100100011000001101111001100001101000111001 ;
  localparam Weights1 = 240'b111001111101100000101111100101100010100011010110111111001010010101011010011101001110011111011110001101011100001000101010010101000110011010101101110010110100110101111111011000000011000110001111110000010111001001000101000010011100001111000100 ;

  romesh_seq #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
