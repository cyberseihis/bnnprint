`ifndef DUTNAME
`define DUTNAME bnnseq
parameter FEAT_CNT = 4;
parameter FEAT_BITS = 4;
parameter HIDDEN_CNT = 4;
parameter CLASS_CNT = 4;
`define WEIGHTS0 0
`define WEIGHTS1 0
`else
    `include `BSTRINGS
`endif
module `DUTNAME #(
`ifdef PARAMS
`include `PARAMS
`endif
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] data,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  localparam Weights0 = `WEIGHTS0 ;
  localparam Weights1 = `WEIGHTS1 ;

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
