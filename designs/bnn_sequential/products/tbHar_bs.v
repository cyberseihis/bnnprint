`timescale 1us/1ns









module tbHar_bs #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 5


)();

  
  reg [FEAT_BITS*FEAT_CNT-1:0] sample;
  wire [FEAT_BITS*FEAT_CNT-1:0] testcases [TEST_CNT-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfPeriod=period/2;


assign testcases[0] = 48'hb9811498a121;
assign testcases[1] = 48'hb9700187a110;
assign testcases[2] = 48'hb9700088a000;
assign testcases[3] = 48'hb9700088a000;
assign testcases[4] = 48'hb97000889000;


  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 Har_bs #() dut (
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
    #((FEAT_CNT+HIDDEN_CNT-1)*period)
    $write("%d, ",(maxclass-prediction));
  end
  endtask

endmodule