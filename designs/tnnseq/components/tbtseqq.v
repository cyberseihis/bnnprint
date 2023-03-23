module tbtseqq ();

parameter N = 4;
parameter B = 4;
parameter M = 4;
  
  wire [B*N-1:0] data;
  wire [M-1:0] bitz;
  wire done;
  reg rst;
  reg clk;

  assign data = 16'h1234;
  

  // Instantiate module under test
 tseqq #(
  .Wvals(16'b1100110011111111),
  .Wzero(16'b1111100111101000),
  .Wnnz(32'h04020202)
 ) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .done(done),
    .out(bitz)
  );
  
  always #5 clk <= ~clk;

  integer i;
  initial begin
    /* $monitor("sums %h %0t",dut.sums,$time); */
    /* $monitor("1done %h %0t",dut.layers.layer1.done,$time); */
    runtestcase();
    $finish;
  end

  task runtestcase(); begin
    rst <= 1;
    clk <= 0;
    #10
    rst <= 0;
    #10
    #((N-1)*10)
    $display("DONE");
  end
  endtask

endmodule
