`ifndef DUTNAME
`define DUTNAME modular_bnnpar
parameter FEAT_CNT = 4;
parameter FEAT_BITS = 4;
parameter HIDDEN_CNT = 4;
parameter CLASS_CNT = 4;
`define WEIGHTS0 0
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
localparam Weights0 = `WEIGHTS0 ;
localparam Weights1 = `WEIGHTS1 ;
localparam WIDTH = `WIDTHS;
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
localparam INDEX_BITS = $clog2(FEAT_CNT+1)+FEAT_BITS;
wire signed [FEAT_BITS:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire [HIDDEN_CNT-1:0] hidden_n;
wire [CLASS_CNT*SUM_BITS-1:0] scores; 
assign hidden_n = ~hidden;

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[i] = {1'b0,features[i*FEAT_BITS+:FEAT_BITS]};
endgenerate

integer j;
generate
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    localparam Wneur = Weights0[i*FEAT_CNT+:FEAT_CNT];
    reg signed [WIDTH[8*i+:8]-1:0] intra;
    always @ (*) begin
        intra = 0;
        for(j=0;j<FEAT_CNT;j=j+1) begin
        if(Wneur[j])
            intra = intra + feature_array[j];
        else 
            intra = intra - feature_array[j];
        end
    end
    assign hidden[i] = intra >= 0;
end
endgenerate

argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
