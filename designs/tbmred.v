`timescale 1ns/1ns

module tbmred;

  parameter N = 8;
  parameter K = 4;
  parameter I = 4;
  
  wire [N*K-1:0] in;
  wire [N*I-1:0] iin;
  wire [(N+1)/2*K-1:0] out;
  wire [(N+1)/2*I-1:0] iout;
  
  assign in =  32'h120923d3;
  assign iin = 32'h01234567;

  // Instantiate module under test
  maxreducer #(.N(N), .K(K), .I(I)) dut (
    .in(in),
    .iin(iin),
    .out(out),
    .iout(iout)
  );
  
  // Write output numbers to file
  initial begin
    # 10
    $displayh(out);
    $displayh(iout);
    $finish;
  end
  
endmodule

