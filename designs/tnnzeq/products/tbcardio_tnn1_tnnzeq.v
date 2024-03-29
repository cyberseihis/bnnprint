`timescale 1us/1ns





module tbcardio_tnn1_tnnzeq #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000




)();
  reg [FEAT_BITS*FEAT_CNT-1:0] data;
  reg [FEAT_BITS*FEAT_CNT-1:0] testcases [0:TEST_CNT-1];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/1000;
  localparam halfT=period/2;


initial $readmemh("cardio.memh",testcases);

  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 cardio_tnn1_tnnzeq #(
 ) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .prediction(prediction)
  );
  
  always #halfT clk <= ~clk;

  integer i;
  initial begin
    /* $write("["); //"  */
    for(i=0;i<TEST_CNT;i=i+1)
        runtestcase(i);
    /* $display("]"); */
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
    /* $display("%b",dut.tnn.hidden); */
    /* $display("%h",data); */
  end
  endtask

endmodule
