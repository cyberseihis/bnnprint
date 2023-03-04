`timescale 1ns/1ns

module tbacc;

  parameter N = 4;
  parameter B = 4;
  
  wire [N*B-1:0] data;
  wire [N-1:0] weis;
  wire out;
  reg [B-1:0] in;
  reg as;
  reg rst;
  reg clk;
  
  assign data =  16'h12ef;
  assign weis = 4'b0110;

  // Instantiate module under test
  accum #(.N(N), .B(B)) dut (
    .data_in(in),
    .clk(clk),
    .rst(rst),
    .add_sub(as),
    .out(out)
  );
  
  // Write output numbers to file
  initial begin
    rst <= 1;
    clk <= 0;
    # 10
    rst <= 0;
    clk <= 1;
    in <= data[0*B+:B];
    as <= weis[0];
    # 10
    clk <= 0;
    # 10
    rst <= 0;
    clk <= 1;
    in <= data[1*B+:B];
    as <= weis[1];
    # 10
    clk <= 0;
    # 10
    rst <= 0;
    clk <= 1;
    in <= data[2*B+:B];
    as <= weis[2];
    # 10
    clk <= 0;
    # 10
    rst <= 0;
    clk <= 1;
    in <= data[3*B+:B];
    as <= weis[3];
    # 10
    rst <= 1;
    clk <= 0;
    # 10
    rst <= 0;
    clk <= 1;
    # 10
    $displayh(out);
    $finish;
  end
  
endmodule

