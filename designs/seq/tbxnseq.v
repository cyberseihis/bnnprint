`timescale 1ns/1ns

module tbxnseq;

  localparam N = 4;
  localparam M = 4;
  
  wire [N-1:0] data;
  reg put;
  reg in;
  reg rst;
  reg clk;
  
  assign data =  4'b0000;
  localparam SumL = $clog2(N+1);
  wire [M*SumL-1:0] sums;

  // Instantiate module under test
 xnorseqq #(.N(N), .M(M)) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .sums(sums)
  );
  
  always #10 clk <= ~clk;

  // Write output numbers to file
  initial begin
    rst <= 1;
    clk <= 0;
    # 10
    rst <= 0;
    # 80
    $display("huh");
    $display("sums %b",sums);
    $finish;
  end

endmodule

