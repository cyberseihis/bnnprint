














module winewhite_bnn1_bnnparser #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);
localparam Weights0 = 440'b00010101000000000100110001011111111100001000110010111000111101011010011001100010111100110011000010111110111001101101111011100100100101010010111001101100110001100100000010000100011001111001000101010111000101001100101000101100000110011111011111100011100111101111111000100110011101011110000110100011110011010110001110100100000101101110011001000000111010100011101011100100010011100101000101010011100110000100101000111101100110011111111111010110 ;
localparam Weights1 = 280'b1100111000000011001100101100101011000111100011011110001100111111010011101101011100011011111010110001111101001110110101110000110111101010000011000100001011010011000011011110101100001111010011101101011100001101100010110001111111101110111001110000000011001010100110110101111011010110 ;
localparam WIDTH = 320'h07070606060706070707070606060707060706070708060706060606060706070706070607060707;
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
