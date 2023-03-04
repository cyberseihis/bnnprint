module tbseq;

  parameter N = 16;
  parameter B = 4;
  parameter M = 40;
  
  wire [N*B-1:0] data;
  wire [M-1:0]out;
  reg rst;
  reg clk;
  
  assign data =  64'h8f4d96400498fe6f;

  // Instantiate module under test
  seqq #(.N(N), .B(B), .M(M)) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .out(out)
  );
 
  always #10 clk <= ~clk;

  // Write output numbers to file
  initial begin
    rst <= 1;
    clk <= 0;
    # 10
    rst <= 0;
    # 300
    $display("huh");
    $displayb(out);
    $finish;
  end
  
endmodule

