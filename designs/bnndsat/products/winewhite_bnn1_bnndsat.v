














module winewhite_bnn1_bnndsat #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 1000


  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  localparam Weights0 = 440'b00010101000000000100110001011111111100001000110010111000111101011010011001100010111100110011000010111110111001101101111011100100100101010010111001101100110001100100000010000100011001111001000101010111000101001100101000101100000110011111011111100011100111101111111000100110011101011110000110100011110011010110001110100100000101101110011001000000111010100011101011100100010011100101000101010011100110000100101000111101100110011111111111010110 ;
  localparam Weights1 = 280'b1100111000000011001100101100101011000111100011011110001100111111010011101101011100011011111010110001111101001110110101110000110111101010000011000100001011010011000011011110101100001111010011101101011100001101100010110001111111101110111001110000000011001010100110110101111011010110 ;
  localparam Widths = 320'h01060606060505060601050606060101050506050601060106060605060606060606050505060601 ;

  dsat_bnn #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),.Weights0(Weights0),.Weights1(Weights1),
    .WIDTHS(Widths)) bnn (
    .clk(clk),
    .rst(rst),
    .features(features),
    .prediction(prediction)
  );

endmodule
