`ifndef DUTNAME
`define DUTNAME bbbbb
parameter FEAT_CNT = 4;
parameter FEAT_BITS = 4;
parameter HIDDEN_CNT = 4;
parameter CLASS_CNT = 4;
`define PAAR0 0
`define YMAP 0
`define WEIGHTS1 0
`define WIDTHS 0
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
localparam ADDCNT = $bits(PAAR0) / 48;
localparam FULLCNT = ADDCNT + FEAT_CNT;
localparam Weights1 = `WEIGHTS1 ;
localparam WIDTH = `WIDTHS;
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
endgenerate

integer j;
generate
for(i=0;i<ADDCNT;i=i+1) begin
    localparam adsub = PAAR0[i*48];
    localparam op1 = PAAR0[i*48+16+:16];
    localparam op2 = PAAR0[i*48+32+:16];
    localparam nodeloc = FEAT_CNT + i;
    if(adsub)
        assign node[nodeloc] = node[op1] - node[op2];
    else
        assign node[nodeloc] = node[op1] + node[op2];
end
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    localparam ymap = YMAP[i*32+:16];
    localparam signy = YMAP[i*32+16];
    if(signy)
        assign hidden[i] = node[ymap] >= 0;
    else
        assign hidden[i] = node[ymap] <= 0;
end
endgenerate

/* initial begin */
/*     #10 */
/*     for(j=0;j<FULLCNT;j=j+1) begin */
/*         $display("%d | %d | %b, %d, %d", j, node[j], PAAR0[(j- FEAT_CNT )*48],  PAAR0[(j-FEAT_CNT)*48+16+:16], PAAR0[(j-FEAT_CNT)*48+32+:16]); */
/*     end */
/* end */

generate
for(i=0;i<CLASS_CNT;i=i+1) begin
    localparam Wneur = Weights1[i*HIDDEN_CNT+:HIDDEN_CNT];
    reg unsigned [SUM_BITS-1:0] tmpscore;
    always @ (*) begin
        tmpscore = 0;
        for(j=0;j<HIDDEN_CNT;j=j+1) begin
        if(Wneur[j])
            tmpscore = tmpscore + hidden[j];
        else 
            tmpscore = tmpscore + hidden_n[j];
        end
    end
    assign scores[i*SUM_BITS+:SUM_BITS] = tmpscore;
end
endgenerate

argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
