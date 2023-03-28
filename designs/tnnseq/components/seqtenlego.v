module seqtenlego #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 4,
  parameter C = 4,
  // First layer weights
  parameter [M*N-1:0] Wvals = 0,
  parameter [M*N-1:0] Wzero = 0,
  parameter [8*M-1:0] Wnnz = 0,
  // CSR of weight martix
  parameter [7:0] WnnzX = 4, // Number of not-zeroes of weight matrix
  parameter [WnnzX-1:0] WvalsX = 0,  // Bits of not-zeroes
  parameter [(8*WnnzX)-1:0] WcolX = 0, // Column of non-zeros
  parameter [(C*8)-1:0] WrowX = 32'h03020100 // Column of non-zeros // Start indices per row
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [$clog2(C)-1:0] klass
  );
  
  /* localparam SumL = $clog2(M+1); */
  localparam SumL = 8;
  //
  wire [M-1:0] midd;
  wire [M-1:0] revmidd;
  wire nxt;
  wire [SumL*C-1:0] out;

  genvar i;
  for(i=0;i<M;i=i+1)
      assign revmidd[i] = midd[M-1-i];

  tseqq #(.N(N),.B(B),.M(M),
    .Wvals(Wvals),
    .Wzero(Wzero),
    .Wnnz(Wnnz)
  ) layer1 (
    .clk(clk),
    .rst(rst),
    .data(data),
    .out(midd),
    .done(nxt)
  );

 xnortseqq #(.N(M),.M(C),
    .Wnnz(WnnzX),
    .Wvals(WvalsX),
    .Wcol(WcolX),
    .Wrow(WrowX)
 ) layer2 (
    .clk(clk),
    .rst(rst),
    .enable(nxt),
    .data(revmidd),
    .soums(out)
 );
  
  argmax #(.N(C),.I($clog2(C)),.K(SumL)) result (
     .inx(out),
     .outimax(klass)
  );

endmodule
