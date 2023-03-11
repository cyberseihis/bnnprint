module tbmred;

  parameter N = 8;
  parameter K = 4;
  parameter I = 4;
  
  wire [N*K-1:0] in;
  wire [I-1:0] outimax;
  
  assign in =  32'h12e9f3d3;

  // Instantiate module under test
  argmax #(.N(N), .K(K), .I(I)) dut (
    .inx(in),
    .outimax(outimax)
  );
  
  // Write output numbers to file
  initial begin
    # 10
    $display("tbmred %h",outimax);
    $finish;
  end
  
endmodule

