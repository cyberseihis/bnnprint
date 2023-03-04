module tbseq;

  parameter N = 4;
  parameter B = 4;
  parameter M = 4;
  
  wire [N*B-1:0] data;
  wire [M-1:0]out;
  reg rst;
  reg clk;
  
  assign data =  16'h1238;

  // Instantiate module under test
  seqq #(.N(N), .B(B), .M(M)) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .out(out)
  );
  
  // Write output numbers to file
  initial begin
    rst <= 1;
    clk <= 0;
    # 10
    rst <= 0;
    clk <= ~clk;
    # 10
    clk <= ~clk;
    # 10
    clk <= ~clk;
    # 10
    clk <= ~clk;
    # 10
    clk <= ~clk;
    /* # 10 */
    /* clk <= ~clk; */
    /* # 10 */
    /* clk <= ~clk; */
    # 10
    $display("huh");
    $displayb(out);
    $finish;
  end
  
endmodule

