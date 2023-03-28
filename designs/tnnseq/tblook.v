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

assign testcases[0] = 44'h53352264442;
assign testcases[1] = 44'h43302152854;
assign testcases[2] = 44'h73422232845;
assign testcases[3] = 44'h52322373735;
assign testcases[4] = 44'h52322373735;

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
    for(i=0;i<Ts;i=i+1)
        runtestcase(i);
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
    $display("mid %b",dut.tnn.revmidd);
    $display("sums %h",dut.tnn.out);
    $display("klass %d %d",data,klass);
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
