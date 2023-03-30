`timescale 1us/1ns





module tbgasId_ts #(

parameter FEAT_CNT = 128,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 5




)();
  reg [FEAT_BITS*FEAT_CNT-1:0] data;
  wire [FEAT_BITS*FEAT_CNT-1:0] testcases [TEST_CNT-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;


assign testcases[0] = 512'h10000fef10000fff41000fff50000fff20000fff30000fff30000fef30000fef10000fff10000fff21000fff21000fff21000fff21100fff21000fef21000fef;
assign testcases[1] = 512'h10100fef10100fff41000fff50000fff20000fff30000fff30000fef40000fef10100fff10110fff21100fef21000fef22100fff22100fff21000fef21000fef;
assign testcases[2] = 512'h10110fef20100fff51000fff50000fff30000fff40000eff40100fef40100fef10110fff10111fef31110fef32100fef32100eff32100eff22100fef22100fef;
assign testcases[3] = 512'h10111fef20110fff51100fff50000fff30000fff40000eff40100fef40100fef10111fff10111fef31110fef32110fef32200eff32200eff22110fef22100fef;
assign testcases[4] = 512'h20110fef20110eff52100fff51000fff30000fff40000eff40100fef40100fef20111eef20111eef32110fef32110fef33200eff43200dff22110fef32100fef;


  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 gasId_ts #(
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
