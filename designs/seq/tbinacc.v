`timescale 1ns/1ns

module tbinacc;

  parameter DD = 12'he4;
  localparam N = DD[3:0];
  
  wire [N-1:0] data;
  wire [N-1:0] out;
  reg put;
  reg in;
  reg rst;
  reg clk;
  
  assign data =  4'b1001;

  // Instantiate module under test
  binaccum #(.N(N)) dut (
    .data_in(in),
    .clk(clk),
    .put(put),
    .rst(rst),
    .acc(out)
  );
  
  // Write output numbers to file
  initial begin
    put <= 0;
    rst <= 1;
    clk <= 0;
    # 10
    rst <= 0;
    clk <= 1;
    in <= data[0];
    # 10
    clk <= 0;
    # 10
    clk <= 1;
    in <= data[1];
    # 10
    clk <= 0;
    # 10
    clk <= 1;
    in <= data[2];
    # 10
    clk <= 0;
    # 10
    clk <= 1;
    in <= data[3];
    # 10
    put <= 1;
    clk <= 0;
    # 10
    clk <= 1;
    # 10
    clk <= 0;
    # 10
    clk <= 1;
    # 10
    $display("tbba %d",out);
    $finish;
  end
  
endmodule

