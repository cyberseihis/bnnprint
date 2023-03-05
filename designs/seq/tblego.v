module tblego;

  localparam N = 16;
  localparam M = 40;
  localparam B = 4;
  localparam C = 10;

  
  wire [B*N-1:0] data;
  reg rst;
  reg clk;
  
  assign data =  64'h8f4d96400498fe6f;
  localparam SumL = $clog2(M+1);
  wire [C*SumL-1:0] sums;

  // Instantiate module under test
 seqlego #(.N(N), .B(B), .M(M), .C(C)) dut (
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
    # 2000
    $display("huh");
    $display("sums %d %d",0,sums[0*6+:6]);
    $display("sums %d %d",1,sums[1*6+:6]);
    $display("sums %d %d",2,sums[2*6+:6]);
    $display("sums %d %d",3,sums[3*6+:6]);
    $display("sums %d %d",4,sums[4*6+:6]);
    $display("sums %d %d",5,sums[5*6+:6]);
    $display("sums %d %d",6,sums[6*6+:6]);
    $display("sums %d %d",7,sums[7*6+:6]);
    $display("sums %d %d",8,sums[8*6+:6]);
    $display("sums %d %d",9,sums[9*6+:6]);
    $finish;
  end

endmodule

