module tbxnt ();

parameter N = 4;
parameter B = 4;
parameter M = 4;
  
  wire [N-1:0] data;
  wire [4*M-1:0] sums;
  reg rst;
  reg clk;

  assign data = 4'b1111;
  

  // Instantiate module under test
 xnortseqq #(
 ) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .enable(1),
    .sums(sums)
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
    #((N)*10)
    $display("Sum %h",sums);
  end
  endtask

endmodule
