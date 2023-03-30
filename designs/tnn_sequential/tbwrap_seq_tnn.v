`timescale 1us/1ns

`ifndef DUTNAME
`define DUTNAME wrap_seq_tnn
`define TBNAME tbwrap_seq_tnn
`endif
module `TBNAME #(
`ifdef PARAMS
`include `PARAMS
`else
`include "packup.par"
`endif
)();
  reg [FEAT_BITS*FEAT_CNT-1:0] data;
  wire [FEAT_BITS*FEAT_CNT-1:0] testcases [TEST_CNT-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;

`ifdef TESTCASES
`include `TESTCASES
`endif
  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 `DUTNAME #(
 ) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .prediction(prediction)
  );
  
  always #halfT clk <= ~clk;

  integer i;
  initial begin
    $write("["); //" 
    for(i=0;i<TEST_CNT;i=i+1)
        runtestcase(i);
    $display("]");
    $finish;
  end

  task runtestcase(input integer i); begin
    data <= testcases[i];
    rst <= 1;
    clk <= 0;
    #period
    rst <= 0;
    #period
    #((FEAT_CNT+HIDDEN_CNT-1)*period)
    $write("%d,",prediction);
  end
  endtask

endmodule
