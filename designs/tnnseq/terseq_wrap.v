`ifndef DUTNAME
`define DUTNAME terseq_wrap
    `include "backup.bstr"
`else
    `include `BSTRINGS
`endif
module `DUTNAME #(
`ifdef PARAMS
`include `PARAMS
`else
`include "packup.par"
`endif
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [$clog2(C)-1:0] klass
  );

  seqtenlego #(
      .N(N),.B(B),.M(M),.C(C),
  .Wvals(`WVALS),
  .Wzero(`WZERO),
  .Wnnz(`WNNZ),
  .WnnzX(`WNNZX), // Number of not-zeroes of weight matrix
  .WvalsX(`WVALSX),  // Bits of not-zeroes
  .WcolX(`WCOLX), // Column of non-zeros
  .WrowX(`WROWX) // Column of non-zeros // Start indices per row
      ) tnn (
    .clk(clk),
    .rst(rst),
    .data(data),
    .klass(klass)
  );

endmodule
