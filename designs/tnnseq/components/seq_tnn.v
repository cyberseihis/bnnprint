module seq_tnn #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter CLASS_CNT = 4,
  // First layer weights
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] SPARSE_VALS = 0,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] MASK = 0,
  parameter [8*HIDDEN_CNT-1:0] NONZERO_CNT = 0,
  // CSR of weight martix
  parameter [((CLASS_CNT+1)*8)-1:0] ROW_PTRS = 40'h0403020100, // Column of non-zeros // Start indices per row
  parameter [7:0] NONZERO_TOTAL = ROW_PTRS[CLASS_CNT*8+:8],
  parameter [NONZERO_TOTAL-1:0] SPARSE_VALS2 = 0,  // Bits of not-zeroes
  parameter [(8*NONZERO_TOTAL)-1:0] COL_INDICES = 0 // Column of non-zeros
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [$clog2(CLASS_CNT)-1:0] prediction
  );

  
  localparam [(CLASS_CNT*8)-1:0] ROW_DELTA = ROW_PTRS[8+:CLASS_CNT*8] - ROW_PTRS[0+:CLASS_CNT*8];
  localparam [7:0] MAXLEN = maximum(ROW_DELTA);
  localparam SCORE_BITS = $clog2(MAXLEN+1)+2;

/* initial $display("score %d",SCORE_BITS); */

function [7:0] maximum(input [CLASS_CNT*8-1:0] vec);
   reg [7:0] max_val;
   reg [7:0] pval;
   integer i;
   begin
      max_val = vec[7:0];
      for(i = 1; i < CLASS_CNT; i = i + 1) begin
        pval = vec[i*8+:8];
        max_val = pval>max_val?pval:max_val;
      end
      maximum=max_val;
   end
endfunction

  wire [HIDDEN_CNT-1:0] hidden;
  wire next_layer;
  wire [SCORE_BITS*CLASS_CNT-1:0] scores;

  genvar i;

  first_layer_tnn #(.FEAT_CNT(FEAT_CNT),.FEAT_BITS(FEAT_BITS),.HIDDEN_CNT(HIDDEN_CNT),
    .SPARSE_VALS(SPARSE_VALS),
    .MASK(MASK),
    .NONZERO_CNT(NONZERO_CNT)
  ) layer1 (
    .clk(clk),
    .rst(rst),
    .features(features),
    .out(hidden),
    .done(next_layer)
  );

 xnor_layer_tnn #(.HIDDEN_CNT(HIDDEN_CNT),.CLASS_CNT(CLASS_CNT),
    .SPARSE_VALS(SPARSE_VALS2),
    .COL_INDICES(COL_INDICES),
    .ROW_PTRS(ROW_PTRS),
    .ROW_DELTA(ROW_DELTA),
    .MAXLEN(MAXLEN),
    .SUM_BITS(SCORE_BITS-2)
 ) layer2 (
    .clk(clk),
    .rst(rst),
    .enable(next_layer),
    .features(hidden),
    .scores(scores)
 );
  
  argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SCORE_BITS)) result (
     .inx(scores),
     .outimax(prediction)
  );

endmodule
