














module winered_bnn1_bnnparser #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);
localparam Weights0 = 440'b11101100111111100100101100110010011011110110111111101101011011000101100010011000011100010100101010010000111110001110100110011010100011010100001101110011000000011110001100111000111000000010110101110111101111111000101110110001010110011111100000101010011100101001111011101110111001010100110111000110111111000101110111100001000000011011111010111001101100001010010111011100011001101010110110010000011110100000101000110010000011100000000110011000 ;
localparam Weights1 = 240'b101011110101010111101111010101000101111001101110110011111110010011110100100011101000101011111101111001010101001011000101101011100011011000100010000100100000001111000110100000011011100000011101001111010010001011110000001101110000010000111001 ;
localparam WIDTH = 320'h07070707070607070706060706070707070707070707070707060707060707070706060707070707;
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
