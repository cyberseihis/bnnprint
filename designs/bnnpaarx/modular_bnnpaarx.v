`ifndef DUTNAME
`define DUTNAME modular_bnnpar
parameter FEAT_CNT = 4;
parameter FEAT_BITS = 4;
parameter HIDDEN_CNT = 4;
parameter CLASS_CNT = 4;
`define PAAR0 0
`define YMAP 0
`define PAAR1 0
`define YMAP1 0
`else
    `include `BSTRINGS
`endif
module `DUTNAME #(
`ifdef PARAMS
`include `PARAMS
`endif
)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = `PAAR0 ;
localparam YMAP = `YMAP;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam PAAR1 = `PAAR1 ;
localparam YMAP1 = `YMAP1;
localparam ADDCNT1 = $bits(PAAR1) / 32;
localparam FULLCNT1 = ADDCNT1 + (HIDDEN_CNT * 2);
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
localparam INDEX_BITS = $clog2(FEAT_CNT+1)+FEAT_BITS;
wire signed [FEAT_BITS:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire [HIDDEN_CNT-1:0] hidden_n;
wire [CLASS_CNT*SUM_BITS-1:0] scores; 
assign hidden_n = ~hidden;

wire signed [INDEX_BITS:0] node [FULLCNT-1:0];

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[i] = {1'b0,features[i*FEAT_BITS+:FEAT_BITS]};
    for(i=0;i<FEAT_CNT;i=i+1)
        assign node[i] = feature_array[i];
    for(i=0;i<FEAT_CNT;i=i+1)
        assign node[FEAT_CNT+i] = -feature_array[i];
endgenerate

integer j;
generate
for(i=0;i<ADDCNT;i=i+1) begin
    localparam op1 = PAAR0[i*32+:16];
    localparam op2 = PAAR0[i*32+16+:16];
    localparam nodeloc = (2 * FEAT_CNT) + i;
    assign node[nodeloc] = node[op1] + node[op2];
end
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    assign hidden[i] = node[YMAP[i*16+:16]] >= 0;
end
endgenerate

/* initial begin */
/*     #10 */
/*     for(j=0;j<FULLCNT;j=j+1) */
/*         $display("%d | %d", j, node[j]); */
/* end */

wire unsigned [SUM_BITS-1:0] xnode [FULLCNT1-1:0];

generate
    for(i=0;i<HIDDEN_CNT;i=i+1)
        assign xnode[i] = hidden[i];
    for(i=0;i<HIDDEN_CNT;i=i+1)
        assign xnode[HIDDEN_CNT+i] = hidden_n[i];
for(i=0;i<ADDCNT1;i=i+1) begin
    localparam op1 = PAAR1[i*32+:16];
    localparam op2 = PAAR1[i*32+16+:16];
    localparam nodeloc = (2 * HIDDEN_CNT) + i;
    assign xnode[nodeloc] = xnode[op1] + xnode[op2];
end
for(i=0;i<CLASS_CNT;i=i+1) begin
    assign scores[i*SUM_BITS+:SUM_BITS] = xnode[YMAP1[i*16+:16]];
end
endgenerate

argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
