`timescale 1us/1ns









module tbcardio_bnn1_bnnroperm #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000


)();

  
  reg [FEAT_BITS*FEAT_CNT-1:0] sample;
  reg [FEAT_BITS*FEAT_CNT-1:0] testcases [0:TEST_CNT-1];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/1000;
  localparam halfPeriod=period/2;


initial $readmemh("cardio.memh",testcases);

  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 cardio_bnn1_bnnroperm #() dut (
    .features(sample),
    .clk(clk),
    .rst(rst),
    .prediction(prediction)
  );
  
  always #halfPeriod clk <= ~clk;

  integer i;
  initial begin
    $write("["); //"
    for(i=0;i<TEST_CNT;i=i+1)
        runtestcase(i);
    $display("]");
    $finish;
  end

  localparam [$clog2(CLASS_CNT)-1:0] maxclass = CLASS_CNT-1;

  task runtestcase(input integer i); begin
    sample <= testcases[i];
    rst <= 1;
    clk <= 0;
    #period
    rst <= 0;
    #period
    #((HIDDEN_CNT+CLASS_CNT)*period)
    $write("%d, ",(prediction));
  end
  endtask

endmodule
