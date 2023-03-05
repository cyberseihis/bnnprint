module tbxnseq;

  localparam N = 4;
  localparam M = 4;
  
  wire [N-1:0] data;
  reg rst;
  reg clk;
  reg enable;
  
  assign data =  4'b0000;
  localparam SumL = $clog2(N+1);
  wire [M*SumL-1:0] sums;

  // Instantiate module under test
 xnorseqq #(.N(N), .M(M)) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .sums(sums)
  );
  
  always #10 clk <= ~clk;

  // Write output numbers to file
  initial begin
    rst <= 1;
    clk <= 0;
    enable <= 0;
    #5
    rst <= 0;
    #5
    # 190
    enable <= 1;
    # 80
    $display("huh");
    $display("sums %b",sums);
    $finish;
  end

endmodule

