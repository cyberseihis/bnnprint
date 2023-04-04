











module winequality_white_ts #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 5




  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] data,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  seq_tnn #(
      .FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),
  .SPARSE_VALS(440'b00010001000000000100111010000100000100000000001110011010101111111000000011011110011000101001111010100011100000001001001001001010001000101010000001010010101000001100001001010100100000010001001010100000000110000010100011001001000001110110000101000110111100011011000110010000000101011100001001001000101001010000001111000000001000000001010000000111000000000001000001101000000000101000000000010010000110000110100001000000100010110100010100000001),
  .MASK(440'b10011001110000000100111010000101000100011001101110011010111111111100011111111110011001101001111010110011101101001011101001001110011000111011011011110110101101001111101101010110110110010101001010110101001110011011110011011011100001110110110101110111111100111011101110010000001111011111011101101011111011011100011111011001101000001101010101100111000001000001000111101010100110101001010000010110000111000110100101011110101011111110110100000011),
  .NONZERO_CNT(640'h06070806070407070707040806050804090607070707080808050305010906050503060906060307),
  .SPARSE_VALS2(79'b0100000010110010011000100000110000101111111100111011000110111010101011011001010),  // Bits of not-zeroes
  .COL_INDICES(632'h2625232221201e1b1817141211100d0c0605040201211f17100d0b211c1615100c0825211f1817100f0125242119181412092625221f1e1c1817161413100b0a07261c171412100f0b0a0907060401), // Column of non-zeros
  .ROW_PTRS(64'h4f3a342d251d0e00) // Column of non-zeros // Start indices per row
      ) tnn (
    .clk(clk),
    .rst(rst),
    .features(data),
    .prediction(prediction)
  );

endmodule