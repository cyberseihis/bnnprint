












module pendigits_bnn1_bnnroclk0 #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 1000


  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  localparam Weights0 = 640'b0101101001100011101101101101100110110001000001111010010111001000110110101111010101010001111100000110101111111000111000001101101000000011010100101110100101011010010010111010010010010101010110001011110100100011010011100001101100010110101111011010111110110001101100101111010110110101000010011110111110000101010111111100000110010010001111011111101111010000010100000101100101001010000110110100001111101100101100000010101110100100001101111011101011100101011010100101001111001010000111010000011100001011000000000010111100000101001110001010010100011110010010100110001001001011111110000001011011101101010100011111000001001101000110100010101101000010 ;
  localparam Weights1 = 400'b0000100000101111101101100001011000110000011110110111101011101100111100000000000001011101010001011000011110000100011101100111000000001111010000000110111100001000010010110010110110100000011111111101000010001000011011000111010110000010000010110101011011010111100111100010101011111110110001011100011000001010100011000011111010001111111000101011111010000101001111000111000011011001011111000001101001000001 ;

  roclk0_seq #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
