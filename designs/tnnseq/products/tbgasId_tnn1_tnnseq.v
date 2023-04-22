`timescale 1us/1ns





module tbgasId_tnn1_tnnseq #(

parameter FEAT_CNT = 128,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000




)();
  reg [FEAT_BITS*FEAT_CNT-1:0] data;
  reg [FEAT_BITS*FEAT_CNT-1:0] testcases [0:TEST_CNT-1];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;


initial $readmemh("gasId.memh",testcases);

  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 gasId_tnn1_tnnseq #(
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
    $write("%d, ",prediction);
  end
  endtask

endmodule
