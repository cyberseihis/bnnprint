`ifndef DUTNAME
`define DUTNAME modular_ts
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
  input [FEAT_CNT*FEAT_BITS-1:0] data,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  seq_tnnzew #(
      .FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),
  .SPARSE_VALS(`WVALS),
  .MASK(`WZERO),
  .NONZERO_CNT(`WNNZ),
  .WIDTHS(`WIDTHS),
  .SPARSE_VALS2(`WVALSX),  // Bits of not-zeroes
  .COL_INDICES(`WCOLX), // Column of non-zeros
  .ROW_PTRS(`WROWX) // Column of non-zeros // Start indices per row
      ) tnn (
    .clk(clk),
    .rst(rst),
    .features(data),
    .prediction(prediction)
  );

endmodule
