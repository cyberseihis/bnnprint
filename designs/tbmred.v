`timescale 1ns/1ns

module tbmred;

  parameter N = 8;
  parameter K = 4;
  
  wire [N*K-1:0] in;
  wire [(N+1)/2*K-1:0] out;
  
  assign in = 32'h120923d3;

  // Instantiate module under test
  maxreducer dut (
    .in(in),
    .out(out)
  );
  
  // Write output numbers to file
  initial begin
    # 10
    $displayh(out);
    $finish;
  end
  
endmodule

