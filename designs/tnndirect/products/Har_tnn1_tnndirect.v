











module Har_tnn1_tnndirect #(

parameter FEAT_CNT = 12,
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

  seq_tnndirect #(
      .FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),
  .SPARSE_VALS(480'b010010001001000100010000000011000000000000001010011000010010110010010010000011010010000000000110000100001011000100001001000001011001000010100000001000001010010001000100001001011010101011001000110010000100010000100000000011000000101100010000110101100001101000101000000100000001000100001001000000001010010011000101010010000011101011110000000010001100001100001000101000100011000000100000100101000110101000001100001111100101000111001000000000001100000000000000001100101010110101000010),
  .MASK(480'b111110011001100100010001001011100101010000111011111101010011110011011011100011111111111000111110000111111011001100001111100011011111101110100001001001011010010011011110101011011111101111001010111010010101011110110000001011001000111100010010110111101111101100101001101101000011111100001001110000101011010011001101111010101011101011110001110010001100001100111110111011101111010000101110101111111111101100001110001111100101111111001000101000111101100000010000001110101110111111011011),
  .NONZERO_CNT(640'h08040606080809080806080605070907070604060a0606060606080705070a050b0607070702070a),
  .SPARSE_VALS2(89'b10010110011111001000011111001110110110101011011001101110001000101101101100100001101100111),  // Bits of not-zeroes
  .COL_INDICES(712'h272623201d1b1a1712110d0b03002623201f1d19120e0c0b0805042622201f1d18151211100b04010021201b1a1918161512110d0a060100242322211f1d18161412100e0c0b0a06052422201e1c1a1918161411100e0d0a06), // Column of non-zeros
  .ROW_PTRS(56'h594b3e30211000) // Column of non-zeros // Start indices per row
      ) tnn (
    .clk(clk),
    .rst(rst),
    .features(data),
    .prediction(prediction)
  );

endmodule
