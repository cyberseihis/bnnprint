














module Har_bnn1_bnnparser #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);
localparam Weights0 = 480'b010011011001001100101101110001110010101011110010111001110001101001101010010011110101100110000101000100000111110100000001101110101101000110000001100100000001110000111111100111001110011001111010101000111100000011110011111011101000100111100110001101001001000110110111001011101011010111110100111000111100000011000000000100101111000110010101011010001100110101000100110101010101111011111000111000010110111000110001001110000010001100000101000000100100011000001101111001100001101000111001 ;
localparam Weights1 = 240'b111001111101100000101111100101100010100011010110111111001010010101011010011101001110011111011110001101011100001000101010010101000110011010101101110010110100110101111111011000000011000110001111110000010111001001000101000010011100001111000100 ;
localparam WIDTH = 320'h06060607070607070707070808070707070707070707070707080707070707070707080708070707;
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
