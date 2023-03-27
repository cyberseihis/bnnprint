module tbxnt ();

parameter N = 40;
parameter M = 7;
  
  wire [N-1:0] data;
  wire [8*M-1:0] sums;
  reg rst;
  reg clk;

  assign data = 40'b0100101111001001111101010111111001010010;
  
  parameter Wvals = 79'b0100000010110010011000100000110000101111111100111011000110111010101011011001010;
  parameter Wcol = 632'h2625232221201e1b1817141211100d0c0605040201211f17100d0b211c1615100c0825211f1817100f0125242119181412092625221f1e1c1817161413100b0a07261c171412100f0b0a0907060401;
 parameter Wrow = 56'h3a342d251d0e00;
 parameter Wnnz = 8'h4f;

  // Instantiate module under test
 xnortseqq #(
  .N(N),
  .M(M),
  .Wnnz(Wnnz),
  .Wvals(Wvals),  // Bits of not-zeroes
  .Wcol(Wcol), // Column of non-zeros
  .Wrow(Wrow) // Column of non-zeros // Start indices per row
 ) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .enable(1'b1),
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
    $display("Soum %h",dut.soums);
  end
  endtask

endmodule
