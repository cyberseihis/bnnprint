












module Har_bs #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 5


  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] data,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  localparam Weights0 = 480'b111010100100110001110010001111111101001100000101000001000110101011100001001011000011100101111101101010010110010111000010101000001001010101010101111001000010001110000011110010011010001110100000010111011101001010000101111011111010010001111110010000001110001011011110110000000111110100000100100110101110111001001100110010010000110001101100101110000101111110000010111011111001000101010101100001000011101001100011111100011000010010100010010101011100001111100001000011010111011010111100 ;
  localparam Weights1 = 240'b001000111100001110010000101000100100111010000011111100011000110000000110111111101011001011010011101101010110011000101010010101000100001110101100011110111110011100101110010110101010010100111111011010110001010001101001111101000001101111100111 ;

  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [SUM_BITS*CLASS_CNT-1:0] sums;

  seqlego #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) layers (
    .clk(clk),
    .rst(rst),
    .data(data),
    .out(sums)
  );

  argmax #(.SIZE(CLASS_CNT),.I($clog2(CLASS_CNT)),.K(SUM_BITS)) result (
     .inx(sums),
     .outimax(prediction)
  );

endmodule
