module tblook ();

parameter N = 11;
parameter M = 40;
parameter B = 4;
parameter C = 7;
parameter Ts = 5;

  wire [B*N-1:0] data;
  wire [B*N-1:0] testcases [Ts-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;

assign data = 44'h53352264442;

  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 terseq_wrap #(
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
    for(i=0;i<1;i=i+1)
        runtestcase(i);
    $finish;
  end

  task runtestcase(input integer i); begin
    /* data <= testcases[i]; */
    rst <= 1;
    clk <= 0;
    #period
    rst <= 0;
    #period
    #((N+M-1)*period)
    /* thesums(); */
    $display("mid %b",dut.tnn.revmidd);
    $display("sums %h",dut.tnn.out);
    $display("klass %d",data,(C-1-klass));
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
