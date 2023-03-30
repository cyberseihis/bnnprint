`ifndef DUTNAME
`define DUTNAME tndemo
parameter FEAT_CNT = 4;
parameter FEAT_BITS = 4;
parameter HIDDEN_CNT = 4;
parameter CLASS_CNT = 4;
`endif
module `DUTNAME #(
`ifdef PARAMS
`include `PARAMS
`endif
)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
localparam SCORE_BITS = SUM_BITS+1;
localparam INDEX_BITS = $clog2(FEAT_CNT+1)+FEAT_BITS;
wire unsigned [FEAT_BITS-1:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire unsigned [INDEX_BITS-1:0] positives [HIDDEN_CNT-1:0];
wire unsigned [INDEX_BITS-1:0] negatives [HIDDEN_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden_n;
wire [SUM_BITS-1:0] popcount [CLASS_CNT-1:0]; 
wire [(SUM_BITS+1)-1:0] scores [CLASS_CNT-1:0]; 
wire [CLASS_CNT*(SUM_BITS+1)-1:0] score_vec; 
assign hidden_n = ~hidden;

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[FEAT_CNT-1-i] = features[i*FEAT_BITS+:FEAT_BITS];
endgenerate
generate
    for(i=0;i<CLASS_CNT;i=i+1)
        assign score_vec[i*SCORE_BITS+:SCORE_BITS] = scores[i];
endgenerate

`ifdef HRDCD
`include `HRDCD
`endif

argmax #(.SIZE(CLASS_CNT),.I($clog2(CLASS_CNT)),.K(SUM_BITS+1)) result (
    .inx(score_vec),
    .outimax(prediction)
);
endmodule
