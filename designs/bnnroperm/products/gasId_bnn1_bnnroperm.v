













module gasId_bnn1_bnnroperm #(

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

  localparam Weights0 = 5120'b01011111011111010001110111011111010011110101110110010111001100000111110110101100101010000001111101001111000111110011001100010011100100100000000010100001010000110011001101100011010000001001101110100110100000001111000000110010101000011110101001011111111111100110011000100001000000001100000100000100000101101111110111111101000000001100001111110000111100111001011011000011010111111010010100100000000001001010110011001111011000001110000011001011110011101010001010100010010001000101011110110000000100001010110000101001100001100011111111111101000101110110011101011111101000011111000010110010100110111101101110011101001111111010111101100011100000001010011101010111110000000000001000010101001011111110001000100010111110111100110011110011010001000010101110100110010011000010000010000011111001100010000111000001100011010011011110100000101000001100001101000111001101100111001111001101100001110101111110011100110010110110110110100000111000001010011000001111001000011000010111000101000011111110001011100000000011110001111101010111110000010010000000100110001001100110111100010110100001000100001000100010101010011000101111110111101101110000111101100110000010001100000111000101000000000110111111101111110100000100000010101010111000100001011100100001100001111111010100110101010001010100100000000001101110001111100001011111100111110000111001111011000000000100000001001101011110111001101010101000011111111111111100000000001001100000001100000110011000101100110000011110111001101100000011100010000100111100101111110111110101000010111011010110001010001101110010100001001100010100001111100010100111111000000110000100001000101001101011000101110101001011011110001111000001101110000011000100111111000110110100011000110111001100001000001101011111111111110110010010010111010100101010101000000100101010001010100011010011111100101011011111011100000001110011001011011110111110010001000000000011100110100100111011011110000111111110100111101100010010001010110100100001010001101010101010101111110000011010111110101110111000000101111010011010101101111001000010111101010111100110010010000110010101101111111101000111010001100011100000101111111111111100011110001100101111110001001101001100001111010011011111001111110000000111100000110001010100000011100101001001011010011101111111100101001010011110000010001101110111000000100000010111111101111110011100011111000011110010011100110110000010000000101111111111111101010011001010111011000110111000011000101101001000110011011111000111011010111110011101100110000010100101101001101111111101110111011111110100011100110111001111100100001000000101110011100011010001111111011111001110001011000001101110111111111011111111111111000111000101001111110010000010101010101011011000001111111001110110011111110111110000100001011000100110110000111100011111101111110111111100111110001000101010101011111011110010101111111111011111001110100101101001011110001111100111111011101010111000100000000000111110111111101100100101001001100111101000111100100000101100100011111000011111111100100001100011011000110111101111101110000001011110000001101001101000110010110010101010111111101000000011111011010000001010110100001110000011101011111100111100000000001000000111110111001001110100001111001001001110110111111001000011000000010110010011101011011101010111111011100011001000000111111110010001011100101111000100111110101100001100111011010111000000010000100110000110100101100001110010000101001111001001110001000000110100111000110100010000110001011101110111010101110111010101110110000110011000100111000101111110011010111101001111100001101010110000101001111001011110100111110110110010011010100101001100000001100000110000001100000100000010001000111001110111010100001000000100000000100001011000101100011011010100101011101100111111111010011101001101101001101101110110001101110100101111110001001111111111111101001100111111101100001010110110101111000010111001100111110101111110100000101000011100011100000111010000100100010001100000001000000110001000000110000101011010010111101111101011111001000001100010001110000011001111010111100110111010100110100111001011111000101001000010111000100001001111010010110110101010000001110001000100010110000100100001000000010110001011000010001000011100000011110100011000011000000000010011111000111000011110010101110110111001001001100001011000001110101000101010011100010000000010101110110011111101111001000010010101100001011001101000010100001010111100111111001000010100010101100101010000011100000110000001111100000111000110100001000000110000000111110011010001011100110100011111101001101101010000100100010011010000110110000101001000001011111111011111111000110101011100001100010111011001000111100001111111011010110101111111110011111101000001110011011111101111111111000000001000000110100000111101000110100111101000001110100011101110001000010100011000001110000000011111010111010010000001100001101111110101111100011111001100111110111101001100001100011011000110011101110111110001011101100111101000001110000001010111110101110110000100111111110000010010000101110000101100100100111010001110011111010000010111010101101000001111111110011011111000010110000111011111000111110000011001101011000011111001111001010001111000000101111100111011 ;
  localparam Weights1 = 240'b010111001101111111111100000110010001010111101110000001111101110000100101101101110001111111011111110111000001000100010101110010101111101100000010111110110011110111001111101110110000111010011001000110101000100000101111111111100101010100010101 ;

  romesh_seq #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
