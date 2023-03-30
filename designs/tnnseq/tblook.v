`timescale 1us/1ns

`ifndef DUTNAME
`define DUTNAME terseq_wrap
`define TBNAME tblook
`endif
module `TBNAME #(
`ifdef PARAMS
`include `PARAMS
`else
`include "packup.par"
`endif
)();
  reg [B*N-1:0] data;
  wire [B*N-1:0] testcases [Ts-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;

`ifdef TESTCASES
`include `TESTCASES
`endif
  
  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 `DUTNAME #(
 ) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .klass(klass)
  );
  
  always #halfT clk <= ~clk;

  integer i;
  initial begin
    /* $monitor("sums %h %0t",dut.sums,$time); */
    /* $monitor("1done %h %0t",dut.layers.layer1.done,$time); */
    $write("["); //" 
    for(i=0;i<Ts;i=i+1)
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
    #((N+M-1)*period)
    /* thesums(); */
    /* $display("mid %b",dut.tnn.revmidd); */
    /* $display("sums %h",dut.tnn.out); */
    $write("%d,",klass);
    /* $display("%h %d",data,(C-1-klass)); */
  end
  endtask

  task thesums(); begin
    $write("[");
    for(i=0;i<C;i=i+1)
        $write("%d, ",dut.tnn.out[i*SumL+:SumL]);
    $display("]");
  end
  endtask

endmodule
