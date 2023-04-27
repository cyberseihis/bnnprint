












module gasId_bnn1_bnndirect #(

parameter FEAT_CNT = 128,
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

  localparam Weights0 = 5120'b01111111110011111101000001110011011111101111111111000000001000000110100000111101000110100111101000001110100011101110001000010100010110010011101011011101010111111011100011001000000111111110010001011100101111000100111110101100001100111011010111000000010000100001111111011111001110001011000001101110111111111011111111111111000111000101001111110010000010101010101011011000001111111001110100111000001100111101011110011011101010011010011100101111100010100100001011100010000100111101001011011010101000000111000100010001011001100010000100000000110000010000010000010110111111011111110100000000110000111111000011110011100101101100001101011111101001011001100010011100010111111001101011110100111110000110101011000010100111100101111010011111011011001001101010010100110000000110000010010010000000001010000101000011001100110110001101000000100110111010011010000000111100000011001010100001111010100101111111111110001000010100010101100101010000011100000110000001111100000111000110100001000000110000000111110011010001011100110100011111101001101101101001101101110110001101110100101111110001001111111111111101001100111111101100001010110110101111000010111001100111110101111110100000101000011100011100000111010000100100010001100000001000000110001000000110000101011010010111101111101011111001000001100010011000001110000000011111010111010010000001100001101111110101111100011111001100111110111101001100001100011011000110011101110111110110000100100001000000010110001011000010001000011100000011110100011000011000000000010011111000111000011110010101110110111001001010011111110111110000100001011000100110110000111100011111101111110111111100111110001000101010101011111011110010101111111111011111100111000111110000111100100111001101100000100000001011111111111111010100110010101110110001101110000110001011010010001100110111110110000101100000111010100010101001110001000000001010111011001111110111100100001001010110000101100110100001010000101011110011111100111110000111111111001000011000110110001101111011111011100000010111100000011010011010001100101100101010101111111010000000111110000111011010111110011101100110000010100101101001101111111101110111011111110100011100110111001111100100001000000101110011100011011011010010000101000110101010101010111111000001101011111010111011100000010111101001101010110111100100001011110101011110011001001000100000001001100010011001101111000101101000010001000010001000101010100110001011111101111011011100001111011001100000100011000001001110100101101001011110001111100111111011101010111000100000000000111110111111101100100101001001100111101000111100100000101100101100101011011111011100000001110011001011011110111110010001000000000011100110100100111011011110000111111110100111101100010010001000000011000001100110001011001100000111101110011011000000111000100001001111001011111101111101010000101110110101100010100011011100110001010000000001101111111011111101000001000000101010101110001000010111001000011000011111110101001101010100010101001000000000011100000011000001000000100010001110011101110101000010000001000000001000010110001011000110110101001010111011001111111110100111010000000001111000001100010101000000111001010010010110100111011111111001010010100111100000100011011101110000001000000101111111011111110101000010010001001101000011011000010100100000101111111101111111100011010101110000110001011101100100011110000111111101101011010010000000000100101011001100111101100000111000001100101111001110101000101010001001000100010101111011000000010000101011000010100110100111010101111100000000000010000101010010111111100010001000101111101111001100111100110100010000101011101001100100110000100000101000010011000101000011111000101001111110000001100001000010001010011010110001011101010010110111100011110000011011100000110001000001011101100111101000001110000001010111110101110110000100111111110000010010000101110000101100100100111010001110011111010000010101011111011111010001110111011111010011110101110110010111001100000111110110101100101010000001111101001111000111110011001100010011110100000010101101000011100000111010111111001111000000000010000001111101110010011101000011110010010011101101111110010000110000001000001111100110001000011100000110001101001101111010000010100000110000110100011100110110011100111100110110000111010111111001110011111100011011010001100011011100110000100000110101111111111111011001001001011101010010101010100000010010101000101010001101001111011000011010010110000111001000010100111100100111000100000011010011100011010001000011000101110111011101010111011101010111011000010001100101011011111111010001110100011000111000001011111111111111000111100011001011111100010011010011000011110100110111110011111110000110001111111111110100010111011001110101111110100001111100001011001010011011110110111001110100111111101011110110001110000000110010110110110110100000111000001010011000001111001000011000010111000101000011111110001011100000000011110001111101010111110000011011100011111000010111111001111100001110011110110000000001000000010011010111101110011010101010000111111111111111000000000010011011010101101000001111111110011011111000010110000111011111000111110000011001101011000011111001111001010001111000000101111100111011 ;
  localparam Weights1 = 240'b001101100010110011101111111110000101100100111011101110001100100011010110111110010011010000101000111011101111100011011101110101110110000001111111010010111010101110110110000010000111110101011111100011100111010010101100110110001100101001011011 ;

  direct_bnn #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
