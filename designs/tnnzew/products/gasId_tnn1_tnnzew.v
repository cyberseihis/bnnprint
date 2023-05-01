












module gasId_tnn1_tnnzew #(

parameter FEAT_CNT = 128,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000




  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] data,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  seq_tnnzew #(
      .FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),
  .SPARSE_VALS(5120'b00000000000000010000000000000000000001010000011100000000000000100000000000000001000000000000000000000100000000000001110100000001000000000000000000010000000100000000000000000000000100000001100100000001001000000000000000000000000100000000100000011001000000000000000000000001000000000000000000000110000101100000000000000000000000000000010000010000000000001000011000000110000100000000000000000000000000000000111000001110000100000000000010000000000000100001100000000000000111010000010000001110001001000000000000000000000100000001110100000000000000000000000000001000000100110001111100110000000010100000000000000010000100000001000000011111000010110001101000011010000110000001100010011000000010100001111100011111001110000001100000001000000010000001100000011000100000000001100110100010000000000000110000000001100111100000001000000000100111000000000001100110101000010011010000110001010000000001000010001000000000000000000000010111000101110000000000000000000000000000000000000000000000000001000100000011000011000000100100010001000100000000000000000001000000000000000100000100000000000000000000000010000000010000000000000001000000000000010100000000000111010001000000000000000000000000000000000000010000000001000000000000000000000000000000010010000000000001000000001000000000000000000000000000000001000000010100000100000001000100000000000000000000110000000000000000000000000000000000001100101001000001000101000000000000000000101000010000000100100001010000011000001000000000000000000000001010000001000000001000000001000000101000001010000000000000000000011010000110000001110000011110000110000000000000001110000000100001100000011000000011000000110000011000000110000000000000000000000000000000000000000111000001110001000000000000010000000000001000000000000000000000010100000100000001000000000000001100000110000001111000011010001110000001100000000010000011100001111100000100000010000000110000001000000010000001001000000010000000000000000000000001000000010000000000000000000000000000000000010001000111110000000000000000000100000000000000000000000000000001111100011011000111100001111100011000001110000001100000011111000111110001111100011000000011000010000000001000000110101000000000101111000111110000000100000001001000010010000000000000000101110000000100010000000000000000010000000000000000010000010100001010000111010000001100001000000110101001000000010000000000100000100000001000000000000000110000001000000010000000100000000110000000100000000000000000000000100001000000000000000000100001010000000000000000000010001100010000010000000000010000000100000000000000000000001101000110000001100001010000000111000001110100000000000000000001111100011101000110000001000000001100000011000001000000010000000000000001111100000000100000000000001101000100000001000100000000000000000000000000000000000001001100010001000000001011110010110001111110010000000110100001111000010000000100000000101100011111000100010001010000000000000010100001000000000000000110100000101000010000000100110000100000000000000100100001001000010000000000100000000001000000000110000000100000011100000000000000111000001110000000000000000001000000010000000010100010000000000001011000100000100000100000010010000000000111001000000000001000000000000010000010000000010000000000010000000100000001001000010100000100010001000000000001000100000000000000010000000000000000000000000000000100011111000000000000101000011010000100000011000000001010000111110000000000000000000000000000100000010000000000000000111000001111000100010000000000000000000010110001000000110000000000000001001100010001000111010000000000000000000000000000000000000000000010000001111100010111000000000000000000000000000000000001000000000100010000000100001000000000000000000000010000000100000001000000010000001000001000000001100000000000000111000001110000000000000000000001111100011111000000100001101000001111000111110001000000000000000000001000101000010100000101000000100000001100000000000000010000011111000111110000001000000000000000100000110000010000000100000000111100011101000010100001101001000000000000000000001000011111000000000000000000000000000000000010000000000000000011100000111000010001000000000110000000000000000100011011001000001100001000000000000000000000010001000011000000000000000100000000100000001100100110010001010000100001110100011000000110001001001101000010101001010010101000001000010000000001011100101011010010100001101000001000000001000100000110001001000000011000000011100001000000001000000011100000001000001000000010000000110000001100000000000000000001000000000000000000000000010101000000000000000000000010000001110000000000000000000000000000000000000000000000000000011000001011000100010000000000011000000010110001000000010000000000100001101100010001000100001000000000001000000010000000100100010110000111100001000000000010100000000000000011000001100000010000010000001111001111110100000010000101000001100000100100111001011101110010011101010010000000000001101000011110000100000001100000001000000010100000111000000000000010000001100000001000000010000000101000001100000000000000000001010000000100000000110100011100100000000000000000011111000111110000000000000000000001000000110000100000010100000000111100011111),
  .MASK(5120'b00011000000110010001111000011110000011010000011100011001000010100000100000010001000010000000110000011100000110000001110100000011000010000000000000010000000100000000000000000000000100000001100100000001001000000000110000000100000101100000100001011001000000000000000000000001000011010000110100000110010101100001101100011101000000000000010000010100000010101001011000010110000100100001100100010000000010010011111000011110010100000000011110010001000111110001100000000000000111010000010000001110101011000001110100000011000100000001110100000011000001110000000000001000000100110001111100110000000010100001110000010110000101110001011100011111000010110001101100011011000110010001100110011111000011100011111100011111001110000001100101001001000110010001110100011111100101010001100110110011000001110001110000000001100111100100001011000001100111100010000001100110101000110011010000110001010100000001100010101100000111110001111100111111000111110000100000001110000111110001111100011000000111000001100100001111000111000001100100010001000100010001101000011011000110000001110100001100000010000001110100000010000010010000100000001001000010000001111100001000000111010001000011100010000000000001111110011100011100010101101011000010001100110111010001111011101011100101000100001000011111011100000000100001000001000101010101111100001101100111010100001010100000110011110011101110010100000001000010111101101011001001100101011111100101100000101000010001000100100001010000011000001000000000000100011101001010000001000000001000000001000000101000001010000111010000010100011011000110010101110000011111000111010000011100001110000000100001100000011001000011000000110000011100000110010001111100000000000111110001101100110111000101110001101000011111010101110001111100000000000010000000110100001100000101100000101100001101000110110011111000011010001111110001111100000010000011100001111100000110000010000000110000001100000110000001001000000010000111110001000000001011000000010000111000001000000010000000100000010111000111110000100000001000000111000000110000000110000000000001111100011011000111100001111100011111001111110001100100011111000111110001111100011001000011000010110100001001000111101000011000111111010111110000101100011001001111110010101000011000000101110000111110010010000110000001010000001100000011010001010101011010000111011000111100001001000110101001000000010001000000100000100000001000000110110000110100001001000010000000101000000110000100100001111100010001000010100001000000010001000100100001010000001001000100010010001100010000010000100000110000001101000111110001111101001101000110000001100101010001000111000001110100000111000101110001111100011101000110000001000000001100010011000001011100010111000100000001111110011111100011100100101101001100100101101100100000011011001011000000101000001001101110010011100001011011110010110001111110110000000110100001111000011100000111000000101101011111000111110001011010000000001010100001010100000100000110101000101000011100000110110000100000000001000100100001001000010000000000110001000101011101000110000100100000011100000000010001111000001110000011110000000111000100010000000010100110000000000001111011110000101001100000010011001000101111011000000000011100010000000010110010000000010110000110110001001100011111001111110101100110011001100011100001000100011010000110010000110000001100000110100000000100011111000000000000101000011010000111000011110000011010000111110100001100101111000000000000101000010101000001010001111000011111000111010000000000001000000010110101111000111110000000000001001100011011000111010000100000000000000011000000010100000100000011000011111100010111000110000000100100010000000100000001000000000100010110010101111100000000000000000000110000001110000101000001110000011011001101110001100100000010001111000001110000000111000111110001111100011111000000100001101100001111000111110001011000001111000111011000101000011100000101000001101100011110000010000000011000011111000111110000001000000000000110100000110000011111000111110000111100011101000010100001101001001111000011110000001000011111000111110001111100000000001000000010110100001101000111100001111000011111000110100110110000010100001111011011011100011101001001010000011000100110010001000011100000001100000111010000101000001100100110110001010000110101110101011000010110001011001101000010101001110010101000001100110011010011011110101011011011110001101100011010000001000110000110001001000100011000000011100001000100011100000011110011011100001001000010010000110000001100000000000000100001011111000000010000000000010101000011110000111000000010000001110000111000001011000100000000000000011100000011000001011000001011000100010000000000011000000010110001000000010010000100100001101100010001001100101000000000001000000011000000110100010110001111100001110000011010100010000001000011001001110011110001110010001111011111110110001010010101000011110000110100111101011101110010111111011110000110000001101000011110000101010001100100001001000010100000111000000011000010000001100000101001000010000000101000001100000111110001000001010000000100000000110100011100100001100000111000011111001111110000000000001100000101000000110000101111010101110000111100111111),
  .NONZERO_CNT(320'h2914262d2d3e323926393d1f2f372e2544352328333d33242a33302b25393236333d282228422734),
  .WIDTHS(320'h0908080908080909090a0a090909090809080808080809090809080809080909080a080809090909),
  .SPARSE_VALS2(58'b1000100000101101101100001111000000101101100010010010010110),  // Bits of not-zeroes
  .COL_INDICES(464'h2419161514110d06040327241816150c0805041d110c2322201d1c1a19110c090600251f1c1513100d0b0a0908002722201f1d1a16130e0a0802), // Column of non-zeros
  .ROW_PTRS(56'h3a302724180c00) // Column of non-zeros // Start indices per row
      ) tnn (
    .clk(clk),
    .rst(rst),
    .features(data),
    .prediction(prediction)
  );

endmodule
