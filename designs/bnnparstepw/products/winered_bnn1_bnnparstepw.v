






module winered_bnn1_bnnparstepw #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
localparam INDEX_BITS = $clog2(FEAT_CNT+1)+FEAT_BITS;
wire signed [FEAT_BITS:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire unsigned [INDEX_BITS-1:0] positives [HIDDEN_CNT-1:0];
wire unsigned [INDEX_BITS-1:0] negatives [HIDDEN_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden_n;
wire [CLASS_CNT*SUM_BITS-1:0] scores; 
assign hidden_n = ~hidden;

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[i] = {1'b0,features[i*FEAT_BITS+:FEAT_BITS]};
endgenerate



    wire signed [5:0] intra_0_0;
    assign intra_0_0 = - feature_array[0] - feature_array[1] - feature_array[2] + feature_array[3] + feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] - feature_array[9];

    wire signed [6:0] intra_0_1;
    assign intra_0_1 = - feature_array[10] + intra_0_0;
    assign hidden[0] = intra_0_1 >= 0;

    wire signed [5:0] intra_1_0;
    assign intra_1_0 = - feature_array[0] - feature_array[1];

    wire signed [6:0] intra_1_1;
    assign intra_1_1 = - feature_array[2] - feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] - feature_array[9] - feature_array[10] + intra_1_0;
    assign hidden[1] = intra_1_1 >= 0;

    wire signed [5:0] intra_2_0;
    assign intra_2_0 = - feature_array[0] - feature_array[1] - feature_array[2] + feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] - feature_array[8];

    wire signed [6:0] intra_2_1;
    assign intra_2_1 = - feature_array[9] - feature_array[10] + intra_2_0;
    assign hidden[2] = intra_2_1 >= 0;

    wire signed [4:0] intra_3_0;
    assign intra_3_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_3_1;
    assign intra_3_1 = + feature_array[2] - feature_array[3] - feature_array[4] - feature_array[5] + intra_3_0;

    wire signed [6:0] intra_3_2;
    assign intra_3_2 = - feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] + feature_array[10] + intra_3_1;
    assign hidden[3] = intra_3_2 >= 0;

    wire signed [5:0] intra_4_0;
    assign intra_4_0 = + feature_array[0] + feature_array[1] + feature_array[2] - feature_array[3] - feature_array[4] - feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8];

    wire signed [6:0] intra_4_1;
    assign intra_4_1 = - feature_array[9] - feature_array[10] + intra_4_0;
    assign hidden[4] = intra_4_1 >= 0;

    wire signed [5:0] intra_5_0;
    assign intra_5_0 = + feature_array[0] + feature_array[1] - feature_array[2] + feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] + feature_array[10];
    assign hidden[5] = intra_5_0 >= 0;

    wire signed [4:0] intra_6_0;
    assign intra_6_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_6_1;
    assign intra_6_1 = - feature_array[2] + feature_array[3] + feature_array[4] - feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_6_0;
    assign hidden[6] = intra_6_1 >= 0;

    wire signed [4:0] intra_7_0;
    assign intra_7_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_7_1;
    assign intra_7_1 = + feature_array[2] + feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] + intra_7_0;

    wire signed [6:0] intra_7_2;
    assign intra_7_2 = + feature_array[10] + intra_7_1;
    assign hidden[7] = intra_7_2 >= 0;

    wire signed [5:0] intra_8_0;
    assign intra_8_0 = - feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] - feature_array[9];

    wire signed [6:0] intra_8_1;
    assign intra_8_1 = - feature_array[10] + intra_8_0;
    assign hidden[8] = intra_8_1 >= 0;

    wire signed [5:0] intra_9_0;
    assign intra_9_0 = + feature_array[0] + feature_array[1] + feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5];

    wire signed [6:0] intra_9_1;
    assign intra_9_1 = + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_9_0;
    assign hidden[9] = intra_9_1 >= 0;

    wire signed [4:0] intra_10_0;
    assign intra_10_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_10_1;
    assign intra_10_1 = + feature_array[2] - feature_array[3] - feature_array[4] - feature_array[5] + intra_10_0;

    wire signed [6:0] intra_10_2;
    assign intra_10_2 = - feature_array[6] - feature_array[7] - feature_array[8] - feature_array[9] + feature_array[10] + intra_10_1;
    assign hidden[10] = intra_10_2 >= 0;

    wire signed [5:0] intra_11_0;
    assign intra_11_0 = - feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] - feature_array[8] + feature_array[9] + feature_array[10];
    assign hidden[11] = intra_11_0 >= 0;

    wire signed [4:0] intra_12_0;
    assign intra_12_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_12_1;
    assign intra_12_1 = + feature_array[2] - feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] + intra_12_0;

    wire signed [6:0] intra_12_2;
    assign intra_12_2 = + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_12_1;
    assign hidden[12] = intra_12_2 >= 0;

    wire signed [4:0] intra_13_0;
    assign intra_13_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_13_1;
    assign intra_13_1 = + feature_array[2] + feature_array[3] - feature_array[4] - feature_array[5] - feature_array[6] + intra_13_0;

    wire signed [6:0] intra_13_2;
    assign intra_13_2 = + feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] + intra_13_1;
    assign hidden[13] = intra_13_2 >= 0;

    wire signed [5:0] intra_14_0;
    assign intra_14_0 = + feature_array[0] + feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] - feature_array[10];
    assign hidden[14] = intra_14_0 >= 0;

    wire signed [5:0] intra_15_0;
    assign intra_15_0 = + feature_array[0] + feature_array[1] + feature_array[2] - feature_array[3];

    wire signed [6:0] intra_15_1;
    assign intra_15_1 = + feature_array[4] + feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_15_0;
    assign hidden[15] = intra_15_1 >= 0;

    wire signed [4:0] intra_16_0;
    assign intra_16_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_16_1;
    assign intra_16_1 = + feature_array[2] + feature_array[3] + feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] - feature_array[8] + intra_16_0;

    wire signed [6:0] intra_16_2;
    assign intra_16_2 = + feature_array[9] - feature_array[10] + intra_16_1;
    assign hidden[16] = intra_16_2 >= 0;

    wire signed [4:0] intra_17_0;
    assign intra_17_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_17_1;
    assign intra_17_1 = + feature_array[2] + feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] + intra_17_0;

    wire signed [6:0] intra_17_2;
    assign intra_17_2 = + feature_array[10] + intra_17_1;
    assign hidden[17] = intra_17_2 >= 0;

    wire signed [5:0] intra_18_0;
    assign intra_18_0 = - feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3] - feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9];

    wire signed [6:0] intra_18_1;
    assign intra_18_1 = + feature_array[10] + intra_18_0;
    assign hidden[18] = intra_18_1 >= 0;

    wire signed [5:0] intra_19_0;
    assign intra_19_0 = - feature_array[0] - feature_array[1] + feature_array[2] + feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] - feature_array[8] - feature_array[9];

    wire signed [6:0] intra_19_1;
    assign intra_19_1 = - feature_array[10] + intra_19_0;
    assign hidden[19] = intra_19_1 >= 0;

    wire signed [5:0] intra_20_0;
    assign intra_20_0 = + feature_array[0] + feature_array[1] - feature_array[2] + feature_array[3] + feature_array[4];

    wire signed [6:0] intra_20_1;
    assign intra_20_1 = + feature_array[5] - feature_array[6] + feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] + intra_20_0;
    assign hidden[20] = intra_20_1 >= 0;

    wire signed [5:0] intra_21_0;
    assign intra_21_0 = + feature_array[0] + feature_array[1];

    wire signed [6:0] intra_21_1;
    assign intra_21_1 = + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_21_0;
    assign hidden[21] = intra_21_1 >= 0;

    wire signed [4:0] intra_22_0;
    assign intra_22_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_22_1;
    assign intra_22_1 = + feature_array[2] + feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] + intra_22_0;

    wire signed [6:0] intra_22_2;
    assign intra_22_2 = + feature_array[9] - feature_array[10] + intra_22_1;
    assign hidden[22] = intra_22_2 >= 0;

    wire signed [4:0] intra_23_0;
    assign intra_23_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_23_1;
    assign intra_23_1 = - feature_array[2] - feature_array[3] - feature_array[4] + intra_23_0;

    wire signed [6:0] intra_23_2;
    assign intra_23_2 = - feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_23_1;
    assign hidden[23] = intra_23_2 >= 0;

    wire signed [5:0] intra_24_0;
    assign intra_24_0 = - feature_array[0] - feature_array[1] - feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6];

    wire signed [6:0] intra_24_1;
    assign intra_24_1 = - feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] + intra_24_0;
    assign hidden[24] = intra_24_1 >= 0;

    wire signed [5:0] intra_25_0;
    assign intra_25_0 = - feature_array[0] - feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7];

    wire signed [6:0] intra_25_1;
    assign intra_25_1 = - feature_array[8] - feature_array[9] - feature_array[10] + intra_25_0;
    assign hidden[25] = intra_25_1 >= 0;

    wire signed [5:0] intra_26_0;
    assign intra_26_0 = - feature_array[0] - feature_array[1] + feature_array[2] + feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7];

    wire signed [6:0] intra_26_1;
    assign intra_26_1 = + feature_array[8] - feature_array[9] + feature_array[10] + intra_26_0;
    assign hidden[26] = intra_26_1 >= 0;

    wire signed [4:0] intra_27_0;
    assign intra_27_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_27_1;
    assign intra_27_1 = - feature_array[2] - feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] - feature_array[8] + feature_array[9] + feature_array[10] + intra_27_0;
    assign hidden[27] = intra_27_1 >= 0;

    wire signed [5:0] intra_28_0;
    assign intra_28_0 = - feature_array[0] - feature_array[1] - feature_array[2] + feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8];

    wire signed [6:0] intra_28_1;
    assign intra_28_1 = - feature_array[9] - feature_array[10] + intra_28_0;
    assign hidden[28] = intra_28_1 >= 0;

    wire signed [5:0] intra_29_0;
    assign intra_29_0 = + feature_array[0] + feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] - feature_array[9] - feature_array[10];
    assign hidden[29] = intra_29_0 >= 0;

    wire signed [4:0] intra_30_0;
    assign intra_30_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_30_1;
    assign intra_30_1 = + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] - feature_array[8] - feature_array[9] + feature_array[10] + intra_30_0;
    assign hidden[30] = intra_30_1 >= 0;

    wire signed [5:0] intra_31_0;
    assign intra_31_0 = - feature_array[0] - feature_array[1] + feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6];

    wire signed [6:0] intra_31_1;
    assign intra_31_1 = - feature_array[7] - feature_array[8] + feature_array[9] - feature_array[10] + intra_31_0;
    assign hidden[31] = intra_31_1 >= 0;

    wire signed [4:0] intra_32_0;
    assign intra_32_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_32_1;
    assign intra_32_1 = - feature_array[2] - feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] - feature_array[7] - feature_array[8] + intra_32_0;

    wire signed [6:0] intra_32_2;
    assign intra_32_2 = - feature_array[9] - feature_array[10] + intra_32_1;
    assign hidden[32] = intra_32_2 >= 0;

    wire signed [5:0] intra_33_0;
    assign intra_33_0 = + feature_array[0] + feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5];

    wire signed [6:0] intra_33_1;
    assign intra_33_1 = - feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] + intra_33_0;
    assign hidden[33] = intra_33_1 >= 0;

    wire signed [4:0] intra_34_0;
    assign intra_34_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_34_1;
    assign intra_34_1 = - feature_array[2] - feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] - feature_array[9] + feature_array[10] + intra_34_0;
    assign hidden[34] = intra_34_1 >= 0;

    wire signed [4:0] intra_35_0;
    assign intra_35_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_35_1;
    assign intra_35_1 = + feature_array[2] - feature_array[3] + feature_array[4] + feature_array[5] + intra_35_0;

    wire signed [6:0] intra_35_2;
    assign intra_35_2 = + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_35_1;
    assign hidden[35] = intra_35_2 >= 0;

    wire signed [4:0] intra_36_0;
    assign intra_36_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_36_1;
    assign intra_36_1 = + feature_array[2] - feature_array[3] + feature_array[4] + feature_array[5] + intra_36_0;

    wire signed [6:0] intra_36_2;
    assign intra_36_2 = + feature_array[6] + feature_array[7] - feature_array[8] + feature_array[9] + feature_array[10] + intra_36_1;
    assign hidden[36] = intra_36_2 >= 0;

    wire signed [5:0] intra_37_0;
    assign intra_37_0 = - feature_array[0] - feature_array[1] + feature_array[2] - feature_array[3] - feature_array[4] + feature_array[5] + feature_array[6];

    wire signed [6:0] intra_37_1;
    assign intra_37_1 = - feature_array[7] - feature_array[8] + feature_array[9] + feature_array[10] + intra_37_0;
    assign hidden[37] = intra_37_1 >= 0;

    wire signed [4:0] intra_38_0;
    assign intra_38_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_38_1;
    assign intra_38_1 = - feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5] + intra_38_0;

    wire signed [6:0] intra_38_2;
    assign intra_38_2 = - feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + intra_38_1;
    assign hidden[38] = intra_38_2 >= 0;

    wire signed [5:0] intra_39_0;
    assign intra_39_0 = + feature_array[0] + feature_array[1] + feature_array[2] - feature_array[3] - feature_array[4] + feature_array[5] + feature_array[6] - feature_array[7];

    wire signed [6:0] intra_39_1;
    assign intra_39_1 = + feature_array[8] + feature_array[9] + feature_array[10] + intra_39_0;
    assign hidden[39] = intra_39_1 >= 0;
assign scores[0*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden_n[1] + hidden_n[2] + hidden[3] + hidden[4] + hidden[5] + hidden_n[6] + hidden_n[7] + hidden_n[8] + hidden_n[9] + hidden[10] + hidden_n[11] + hidden_n[12] + hidden_n[13] + hidden_n[14] + hidden_n[15] + hidden[16] + hidden[17] + hidden[18] + hidden_n[19] + hidden[20] + hidden[21] + hidden_n[22] + hidden_n[23] + hidden_n[24] + hidden_n[25] + hidden_n[26] + hidden_n[27] + hidden[28] + hidden[29] + hidden[30] + hidden[31] + hidden_n[32] + hidden[33] + hidden_n[34] + hidden_n[35] + hidden_n[36] + hidden[37] + hidden_n[38] + hidden_n[39];
assign scores[1*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden_n[1] + hidden[2] + hidden[3] + hidden[4] + hidden[5] + hidden_n[6] + hidden_n[7] + hidden[8] + hidden_n[9] + hidden[10] + hidden[11] + hidden[12] + hidden_n[13] + hidden_n[14] + hidden_n[15] + hidden_n[16] + hidden_n[17] + hidden_n[18] + hidden[19] + hidden[20] + hidden[21] + hidden_n[22] + hidden[23] + hidden[24] + hidden_n[25] + hidden_n[26] + hidden_n[27] + hidden_n[28] + hidden_n[29] + hidden_n[30] + hidden[31] + hidden_n[32] + hidden[33] + hidden[34] + hidden_n[35] + hidden_n[36] + hidden_n[37] + hidden[38] + hidden[39];
assign scores[2*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden[1] + hidden_n[2] + hidden_n[3] + hidden_n[4] + hidden_n[5] + hidden_n[6] + hidden_n[7] + hidden_n[8] + hidden[9] + hidden_n[10] + hidden_n[11] + hidden[12] + hidden_n[13] + hidden_n[14] + hidden_n[15] + hidden_n[16] + hidden[17] + hidden_n[18] + hidden_n[19] + hidden_n[20] + hidden[21] + hidden_n[22] + hidden_n[23] + hidden_n[24] + hidden[25] + hidden[26] + hidden_n[27] + hidden[28] + hidden[29] + hidden_n[30] + hidden_n[31] + hidden_n[32] + hidden[33] + hidden[34] + hidden[35] + hidden_n[36] + hidden[37] + hidden_n[38] + hidden[39];
assign scores[3*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden_n[1] + hidden[2] + hidden_n[3] + hidden_n[4] + hidden_n[5] + hidden[6] + hidden[7] + hidden_n[8] + hidden[9] + hidden_n[10] + hidden_n[11] + hidden[12] + hidden_n[13] + hidden[14] + hidden_n[15] + hidden[16] + hidden_n[17] + hidden[18] + hidden_n[19] + hidden_n[20] + hidden[21] + hidden[22] + hidden[23] + hidden[24] + hidden_n[25] + hidden[26] + hidden[27] + hidden[28] + hidden[29] + hidden[30] + hidden[31] + hidden_n[32] + hidden[33] + hidden_n[34] + hidden[35] + hidden_n[36] + hidden_n[37] + hidden_n[38] + hidden[39];
assign scores[4*SUM_BITS+:SUM_BITS] = + hidden_n[0] + hidden[1] + hidden[2] + hidden[3] + hidden_n[4] + hidden_n[5] + hidden_n[6] + hidden[7] + hidden_n[8] + hidden_n[9] + hidden[10] + hidden_n[11] + hidden[12] + hidden[13] + hidden[14] + hidden[15] + hidden_n[16] + hidden_n[17] + hidden[18] + hidden_n[19] + hidden_n[20] + hidden[21] + hidden[22] + hidden[23] + hidden[24] + hidden[25] + hidden[26] + hidden[27] + hidden_n[28] + hidden_n[29] + hidden[30] + hidden[31] + hidden_n[32] + hidden[33] + hidden[34] + hidden[35] + hidden_n[36] + hidden[37] + hidden[38] + hidden_n[39];
assign scores[5*SUM_BITS+:SUM_BITS] = + hidden_n[0] + hidden[1] + hidden[2] + hidden[3] + hidden[4] + hidden_n[5] + hidden[6] + hidden_n[7] + hidden_n[8] + hidden_n[9] + hidden[10] + hidden_n[11] + hidden[12] + hidden_n[13] + hidden[14] + hidden_n[15] + hidden[16] + hidden[17] + hidden[18] + hidden[19] + hidden_n[20] + hidden[21] + hidden[22] + hidden[23] + hidden[24] + hidden_n[25] + hidden[26] + hidden_n[27] + hidden[28] + hidden_n[29] + hidden[30] + hidden_n[31] + hidden[32] + hidden[33] + hidden[34] + hidden[35] + hidden_n[36] + hidden[37] + hidden_n[38] + hidden[39];


argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
