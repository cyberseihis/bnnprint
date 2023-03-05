module tblego;

  localparam N = 4;
  localparam M = 4;
  localparam B = 4;
  localparam C = 4;

  
  wire [B*N-1:0] data;
  reg rst;
  reg clk;
  
  assign data =  16'h1234;
  localparam SumL = $clog2(M+1);
  wire [C*SumL-1:0] sums;

  // Instantiate module under test
 seqlego #(.N(N), .M(M)) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .out(sums)
  );
  
  always #10 clk <= ~clk;

  // Write output numbers to file
  initial begin
    rst <= 1;
    clk <= 0;
    #5
    rst <= 0;
    #5
    # 800
    $display("huh");
    $display("sums %b",sums);
    $finish;
  end

endmodule

