module tbbnnseq;

  localparam N = 16;
  localparam M = 40;
  localparam B = 4;
  localparam C = 10;

  
  wire [B*N-1:0] data;
  reg rst;
  reg clk;
  
  assign data =  64'h2e28c690130a5fff;
  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 bnnseq #(.N(N), .B(B), .M(M), .C(C)) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .klass(klass)
  );
  
  always #10 clk <= ~clk;

  // Write output numbers to file
  initial begin
    rst <= 1;
    clk <= 0;
    #5
    rst <= 0;
    #5
    # 2000
    $display("huh");
    $display("klass %d",klass);
    $finish;
  end

endmodule

