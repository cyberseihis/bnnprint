











module winered_tnn1_tnnseq #(

parameter FEAT_CNT = 11,
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

  seq_tnn #(
      .FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),
  .SPARSE_VALS(440'b00000011010010100100110100111010100000000000101000000000010100100000010000100001000000010100010010000100001000000000101011000000100100010001110101000000100000001100011000100000010001101110000100101010100010010000011110101100011000000010000101010000001010010100000000000001000110000101000110000110001000000100001100000000000000010101010110000110011000111011000101000000001100000000000011010011001100000101110101101100110000100010001000000000),
  .MASK(440'b10000111110011110110111100111011100110101000111011110101011110101011010101110101110011010100011110101101101000000011101011011001110101010001110101011100101100011100111001111010110011101110110111101011100110010100011110101111011110101011111101110010001011011110011001000001100111010101101110000111101000010100001101000011100011110111110110010111011111111011000101110001101101101100000111111111011101010101111101101100111110100010001110100011),
  .NONZERO_CNT(640'h070702060806070805080605050a0608080607040707070704070806060506080704080805040609),
  .SPARSE_VALS2(71'b11111010010011110001001011010000111010010110011001101111011010010001010),  // Bits of not-zeroes
  .COL_INDICES(568'h2523211e190e0d0c08060400252421201f1d1916140f0e0c0b070302010027222120170c06012321190e0d0c0908040100231d1c0d0b0a0905271e1d1c1a171612110c04030200), // Column of non-zeros
  .ROW_PTRS(56'h473b2921160e00) // Column of non-zeros // Start indices per row
      ) tnn (
    .clk(clk),
    .rst(rst),
    .features(data),
    .prediction(prediction)
  );

endmodule