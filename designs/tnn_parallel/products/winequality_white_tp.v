






module winequality_white_tp #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 1000


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


assign positives[0] = + feature_array[4] + feature_array[7];
assign negatives[0] = + feature_array[0] + feature_array[1] + feature_array[8] + feature_array[9];
assign hidden[0] = positives[0] >= negatives[0];
assign hidden[1] = 1;
assign positives[2] = + feature_array[2] + feature_array[8] + feature_array[9] + feature_array[10];
assign negatives[2] = + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7];
assign hidden[2] = positives[2] >= negatives[2];
assign positives[3] = + feature_array[0] + feature_array[5];
assign negatives[3] = + feature_array[1] + feature_array[4] + feature_array[6] + feature_array[7];
assign hidden[3] = positives[3] >= negatives[3];
assign positives[4] = + feature_array[3] + feature_array[5] + feature_array[9] + feature_array[10];
assign negatives[4] = + feature_array[0] + feature_array[1] + feature_array[4];
assign hidden[4] = positives[4] >= negatives[4];
assign positives[5] = + feature_array[6];
assign negatives[5] = + feature_array[2] + feature_array[3] + feature_array[7];
assign hidden[5] = positives[5] >= negatives[5];
assign positives[6] = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[6] + feature_array[7];
assign negatives[6] = + feature_array[9];
assign hidden[6] = positives[6] >= negatives[6];
assign positives[7] = + feature_array[0] + feature_array[1];
assign negatives[7] = + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[10];
assign hidden[7] = positives[7] >= negatives[7];
assign positives[8] = + feature_array[1] + feature_array[2] + feature_array[6];
assign negatives[8] = + feature_array[0] + feature_array[5] + feature_array[8] + feature_array[9];
assign hidden[8] = positives[8] >= negatives[8];
assign positives[9] = + feature_array[4] + feature_array[6] + feature_array[7] + feature_array[10];
assign negatives[9] = + feature_array[0] + feature_array[3] + feature_array[8];
assign hidden[9] = positives[9] >= negatives[9];
assign positives[10] = + feature_array[3] + feature_array[5] + feature_array[6];
assign negatives[10] = + feature_array[7];
assign hidden[10] = positives[10] >= negatives[10];
assign positives[11] = + feature_array[1] + feature_array[2] + feature_array[4] + feature_array[6] + feature_array[8];
assign negatives[11] = + feature_array[5] + feature_array[9] + feature_array[10];
assign hidden[11] = positives[11] >= negatives[11];
assign positives[12] = + feature_array[1] + feature_array[2] + feature_array[5] + feature_array[7];
assign negatives[12] = + feature_array[9] + feature_array[10];
assign hidden[12] = positives[12] >= negatives[12];
assign positives[13] = + feature_array[2] + feature_array[4] + feature_array[8];
assign negatives[13] = + feature_array[5] + feature_array[10];
assign hidden[13] = positives[13] >= negatives[13];
assign positives[14] = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[9];
assign negatives[14] = + feature_array[4] + feature_array[6] + feature_array[7] + feature_array[10];
assign hidden[14] = positives[14] >= negatives[14];
assign positives[15] = + feature_array[6];
assign negatives[15] = + feature_array[3] + feature_array[7] + feature_array[8];
assign hidden[15] = positives[15] >= negatives[15];
assign hidden[16] = 1;
assign positives[17] = + feature_array[0] + feature_array[5];
assign negatives[17] = + feature_array[1] + feature_array[4] + feature_array[7] + feature_array[8];
assign hidden[17] = positives[17] >= negatives[17];
assign positives[18] = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[6] + feature_array[7];
assign negatives[18] = + feature_array[8] + feature_array[10];
assign hidden[18] = positives[18] >= negatives[18];
assign positives[19] = + feature_array[1] + feature_array[6];
assign negatives[19] = + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[9];
assign hidden[19] = positives[19] >= negatives[19];
assign positives[20] = + feature_array[0] + feature_array[1] + feature_array[5] + feature_array[10];
assign negatives[20] = + feature_array[4] + feature_array[6] + feature_array[7];
assign hidden[20] = positives[20] >= negatives[20];
assign positives[21] = + feature_array[0] + feature_array[1] + feature_array[7] + feature_array[8];
assign negatives[21] = + feature_array[3] + feature_array[9] + feature_array[10];
assign hidden[21] = positives[21] >= negatives[21];
assign positives[22] = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[8] + feature_array[10];
assign negatives[22] = + feature_array[3] + feature_array[5] + feature_array[6];
assign hidden[22] = positives[22] >= negatives[22];
assign hidden[23] = 1;
assign positives[24] = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[6];
assign negatives[24] = + feature_array[3] + feature_array[5] + feature_array[7] + feature_array[10];
assign hidden[24] = positives[24] >= negatives[24];
assign positives[25] = + feature_array[3] + feature_array[10];
assign negatives[25] = + feature_array[1] + feature_array[4] + feature_array[7];
assign hidden[25] = positives[25] >= negatives[25];
assign hidden[26] = 0;
assign positives[27] = + feature_array[3] + feature_array[4] + feature_array[6] + feature_array[9];
assign negatives[27] = + feature_array[2];
assign hidden[27] = positives[27] >= negatives[27];
assign hidden[28] = 0;
assign positives[29] = + feature_array[0] + feature_array[5] + feature_array[10];
assign negatives[29] = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[7] + feature_array[8] + feature_array[9];
assign hidden[29] = positives[29] >= negatives[29];
assign positives[30] = + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[7] + feature_array[9];
assign negatives[30] = + feature_array[1];
assign hidden[30] = positives[30] >= negatives[30];
assign positives[31] = + feature_array[5] + feature_array[7] + feature_array[10];
assign negatives[31] = + feature_array[0] + feature_array[1];
assign hidden[31] = positives[31] >= negatives[31];
assign hidden[32] = 1;
assign hidden[33] = 1;
assign positives[34] = + feature_array[3] + feature_array[4] + feature_array[5];
assign negatives[34] = + feature_array[1] + feature_array[2] + feature_array[6];
assign hidden[34] = positives[34] >= negatives[34];
assign positives[35] = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[6] + feature_array[8] + feature_array[9];
assign negatives[35] = + feature_array[3] + feature_array[4] + feature_array[7];
assign hidden[35] = positives[35] >= negatives[35];
assign positives[36] = + feature_array[1] + feature_array[9];
assign negatives[36] = + feature_array[2] + feature_array[5] + feature_array[6] + feature_array[7];
assign hidden[36] = positives[36] >= negatives[36];
assign positives[37] = + feature_array[1] + feature_array[6];
assign negatives[37] = + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[9];
assign hidden[37] = positives[37] >= negatives[37];
assign positives[38] = + feature_array[1] + feature_array[2];
assign negatives[38] = + feature_array[10];
assign hidden[38] = positives[38] >= negatives[38];
assign positives[39] = + feature_array[5] + feature_array[6] + feature_array[10];
assign negatives[39] = + feature_array[0] + feature_array[4] + feature_array[7] + feature_array[8];
assign hidden[39] = positives[39] >= negatives[39];
assign popcount[0] = + hidden_n[1] + hidden[4] + hidden_n[6] + hidden[7] + hidden_n[9] + hidden_n[10] + hidden[11] + hidden[15] + hidden_n[16] + hidden[18] + hidden[20] + hidden_n[23] + hidden[28] + hidden_n[38];assign scores[0] = 2*popcount[0] + 7;
assign popcount[1] = + hidden[7] + hidden_n[10] + hidden[11] + hidden_n[16] + hidden[19] + hidden[20] + hidden[22] + hidden_n[23] + hidden[24] + hidden[28] + hidden_n[30] + hidden_n[31] + hidden_n[34] + hidden[37] + hidden[38];assign scores[1] = 2*popcount[1] + 6;
assign popcount[2] = + hidden_n[9] + hidden[18] + hidden[20] + hidden[24] + hidden_n[25] + hidden_n[33] + hidden[36] + hidden[37];assign scores[2] = 2*popcount[2] + 13;
assign popcount[3] = + hidden[1] + hidden[15] + hidden[16] + hidden[23] + hidden[24] + hidden[31] + hidden_n[33] + hidden[37];assign scores[3] = 2*popcount[3] + 13;
assign popcount[4] = + hidden_n[8] + hidden_n[12] + hidden_n[16] + hidden_n[21] + hidden[22] + hidden[28] + hidden_n[33];assign scores[4] = 2*popcount[4] + 14;
assign popcount[5] = + hidden_n[11] + hidden_n[13] + hidden_n[16] + hidden_n[23] + hidden[31] + hidden_n[33];assign scores[5] = 2*popcount[5] + 15;
assign popcount[6] = + hidden_n[1] + hidden_n[2] + hidden[4] + hidden[5] + hidden_n[6] + hidden_n[12] + hidden[13] + hidden_n[16] + hidden_n[17] + hidden[18] + hidden[20] + hidden_n[23] + hidden[24] + hidden_n[27] + hidden_n[30] + hidden_n[32] + hidden_n[33] + hidden_n[34] + hidden_n[35] + hidden[37] + hidden_n[38];assign scores[6] = 2*popcount[6] + 0;


argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS+1)) result (
    .inx(score_vec),
    .outimax(prediction)
);
endmodule
