












module winered_bnn1_bnnromex #(

parameter FEAT_CNT = 11,
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

  localparam Weights0 = 440'b11101100111111100100101100110010011011110110111111101101011011000101100010011000011100010100101010010000111110001110100110011010100011010100001101110011000000011110001100111000111000000010110101110111101111111000101110110001010110011111100000101010011100101001111011101110111001010100110111000110111111000101110111100001000000011011111010111001101100001010010111011100011001101010110110010000011110100000101000110010000011100000000110011000 ;
  localparam Weights1 = 240'b101011110101010111101111010101000101111001101110110011111110010011110100100011101000101011111101111001010101001011000101101011100011011000100010000100100000001111000110100000011011100000011101001111010010001011110000001101110000010000111001 ;

  romex_seq #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
