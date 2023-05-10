












module cardio_bnn1_bnnromesh #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000


  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  localparam Weights0 = 760'b0000011011111100100011101010010000101011000001110111011001000001001000110000111101101000110100100011001000110001010010010100000010100011010111011011101110101010101110011100110100000011000000001011000010110101111110000101100111100000111010111101011100000011110111010000010010010110100011110010111010100010011000001100011000110011100010000001000111001010111001010110100000001000000110000111000100001010011111100000111010111000011011010101001110100100001011101110010000010010101000111101011000101100000000011011101000010000000110011110101001111111001000110000000101001000011000101001101010101011101101011010101100110010001111011001000101101100110001101001000010001110101101101101101110101100101111000110001001010100100101000101011100100101010100111101000110101011 ;
  localparam Weights1 = 120'b101010000001111100000011001000100011100111001011000110110011011101101001101001110100101100111001001101110110000110110011 ;

  romesh_seq #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
