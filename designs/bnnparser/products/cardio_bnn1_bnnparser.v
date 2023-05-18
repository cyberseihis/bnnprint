














module cardio_bnn1_bnnparser #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);
localparam Weights0 = 760'b0000011011111100100011101010010000101011000001110111011001000001001000110000111101101000110100100011001000110001010010010100000010100011010111011011101110101010101110011100110100000011000000001011000010110101111110000101100111100000111010111101011100000011110111010000010010010110100011110010111010100010011000001100011000110011100010000001000111001010111001010110100000001000000110000111000100001010011111100000111010111000011011010101001110100100001011101110010000010010101000111101011000101100000000011011101000010000000110011110101001111111001000110000000101001000011000101001101010101011101101011010101100110010001111011001000101101100110001101001000010001110101101101101101110101100101111000110001001010100100101000101011100100101010100111101000110101011 ;
localparam Weights1 = 120'b101010000001111100000011001000100011100111001011000110110011011101101001101001110100101100111001001101110110000110110011 ;
localparam WIDTH = 320'h08070708080808080708070707080707060807080707070707070808080807080707070707070708;
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
