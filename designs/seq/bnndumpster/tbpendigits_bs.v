`timescale 1us/1ns









module tbpendigits_bs #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 5


)();

  
  reg [FEAT_BITS*FEAT_CNT-1:0] sample;
  wire [FEAT_BITS*FEAT_CNT-1:0] testcases [TEST_CNT-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfPeriod=period/2;


assign testcases[0] = 64'h8f4d96400498fe6f;
assign testcases[1] = 64'h0e4f7c572260b0f1;
assign testcases[2] = 64'h095bceffcc884430;
assign testcases[3] = 64'h0f1f1b37e5f7c4b0;
assign testcases[4] = 64'h0b8dffddaa665380;


  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 pendigits_bs #() dut (
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
