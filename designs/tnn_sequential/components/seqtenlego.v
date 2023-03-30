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
  parameter [((C+1)*8)-1:0] WrowX = 40'h0403020100, // Column of non-zeros // Start indices per row
  parameter [7:0] WnnzX = WrowX[C*8+:8],
  parameter [WnnzX-1:0] WvalsX = 0,  // Bits of not-zeroes
  parameter [(8*WnnzX)-1:0] WcolX = 0 // Column of non-zeros
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [$clog2(C)-1:0] klass
  );

  
  localparam [(C*8)-1:0] Delta = WrowX[8+:C*8] - WrowX[0+:C*8];
  localparam [7:0] maxlen = maxz(Delta);
  localparam SumL = $clog2(maxlen+1)+2;

function [7:0] maxz(input [C*8-1:0] vec);
   reg [7:0] max_val;
   reg [7:0] pval;
   integer i;
   begin
      max_val = vec[7:0];
      for(i = 1; i < C; i = i + 1) begin
        pval = vec[i*8+:8];
        max_val = pval>max_val?pval:max_val;
      end
      maxz=max_val;
   end
endfunction

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
    .Wvals(WvalsX),
    .Wcol(WcolX),
    .Wrow(WrowX),
    .Delta(Delta),
    .maxlen(maxlen),
    .SumL(SumL-2)
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
