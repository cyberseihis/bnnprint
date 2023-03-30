`timescale 1us/1ns





module tbcardio_ts #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 5




)();
  reg [FEAT_BITS*FEAT_CNT-1:0] data;
  wire [FEAT_BITS*FEAT_CNT-1:0] testcases [TEST_CNT-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;


assign testcases[0] = 76'h4000d18100621208964;
assign testcases[1] = 76'h8203140320b3a52a991;
assign testcases[2] = 76'h8103140420b3a42a991;
assign testcases[3] = 76'h8104150720a07a0a991;
assign testcases[4] = 76'h8203150600a0780a991;


  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  wire [$clog2(CLASS_CNT)-1:0] prediction;

  // Instantiate module under test
 cardio_ts #(
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
