`timescale 1us/1ns





module tbwinequality_white_ts #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 5




)();
  reg [FEAT_BITS*FEAT_CNT-1:0] data;
  wire [FEAT_BITS*FEAT_CNT-1:0] testcases [TEST_CNT-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;


assign testcases[0] = 44'h53352264442;
assign testcases[1] = 44'h43302152854;
assign testcases[2] = 44'h73422232845;
assign testcases[3] = 44'h52322373735;
assign testcases[4] = 44'h52322373735;


  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 winequality_white_ts #(
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
