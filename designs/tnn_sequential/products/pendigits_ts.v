











module pendigits_ts #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 1000




  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] data,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  seq_tnn #(
      .FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),
  .SPARSE_VALS(640'b1101001000100000100000000000011001101000011011010011000000111100111011000000011100010101000100101100000010000010110000001010100001011000111110010100100000000111001010000110001001110011011100001000100000000100000010100100000100000010110000011010000011001010000000100010000110000000000100001000011001000110000000111010000000010000000011000000011100011001010001000101001010000001010000100011011010101000000100110000000000010100100000010000000000010001101000110000011000111101110000111110001001100000101000000001011000111000010101010010011010011100010110100000010010010000101110110100010100110101010001110101010100100110110110100101101010101000),
  .MASK(640'b1111101011101011100110110011111011101111011111010011101001111111111111110110111110111101011100101100010010111110110100101011100101011010111111110111111101000111001110001111001011110111111111111000111010100100111010100101000100101011110100111111011011001010100000100010011111000000000111011110011101111110011000111011011111010010001111101100011101111111111111010111011010111001111110111111111110101010100101110001101011010101111100011000000010110111111011111011111111111111111100111111001111111001111111110111111000111111111111111110111111111101110111101101111111110111111111111101110111110101011001111111111111111111110111111101111111111111),
  .NONZERO_CNT(640'h0c090d0f080b0a0a0b0c0d0a0d060e080d0d080d0a0c0b0d090c0e0d0c0d0e0c0c0b0908080a0d0b),
  .SPARSE_VALS2(208'b0111001101000010010001110110101010101100000001110111100101000001100011101000110111110011111010001010111010111000100010011010000011011010101010110100110011011100010101011001000111100100000000100010000010100101),  // Bits of not-zeroes
  .COL_INDICES(1664'h25201f1e191716151311100f0c070605040327252322201e1d1c1b1a191817151211100f0e0d0b080604241f1d1c1b191817150e0c0706040302002522201b191817161514131211100f0e0c0b0a080706050127231f1e1a1816110f0e0c0a0907020100272321201f1e1d1c1b1a1716151413110f0e0d0b0a0503021f1e1d1c171615130f0e0c0a090806050403020100271e1c191714130f0e0d0c0b0807060504030201002321201c1a17161312110f0e0c0a0908070605010027201d1b1817161312110e0c0b0a08070504030201), // Column of non-zeros
  .ROW_PTRS(88'hd0bea6957d6c543f2a1500) // Column of non-zeros // Start indices per row
      ) tnn (
    .clk(clk),
    .rst(rst),
    .features(data),
    .prediction(prediction)
  );

endmodule
