











module pendigits_tnn1_tnnseq #(

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
  .SPARSE_VALS(640'b0001010101011010010110110110010010101010111000101010110010100010110111010000100100100000010110100011100101100100101010100001110001101000000001010000011001000111110000111011110001100000110001011000100000000000100000010010100000000000110010000001010101101100010000101000000101001010001000101001100011100000001100000000100000000101110000000110001001100001000010000000000110000100010000000101001100000101100000110100000010000010010100000010000000010001000011101100111001000110000101001110000000010010100111110001101000010101000000110100000100000011010010001010100011100000001101110011110000001100101101100001011001100000000000010000010001001011),
  .MASK(640'b1111111111111011111110111111111111111111111001101010111110111011111111111110111111111011011110111011111111110111111111111111110001111110111111111001111111001111110011111111111111111101111101111110110100000001100011111010101101011000111010010101010111111111110111111001110101101110101111111111111011100011011111000100101111101101110001100111111011100111101110000000001111100100010000010101001101101111110010111101010010001010010101110010010101110001111111111110111101001111000111001110001011111110111111110101101010011101010010110111110100100011010011101011110111110110111111111111111001011100101111101111011101111100110110011101011101011111),
  .NONZERO_CNT(640'h0b0d0a0808090b0c0c0e0d0c0d0e0c090d0b0c0a0d080d0d080e060d0a0d0c0b0a0a0b080f0d090c),
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