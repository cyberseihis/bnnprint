






module winered_bnn1_bnnparpnw #(

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
wire unsigned [FEAT_BITS-1:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire [HIDDEN_CNT-1:0] hidden_n;
wire [CLASS_CNT*SUM_BITS-1:0] scores; 
assign hidden_n = ~hidden;

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[i] = features[i*FEAT_BITS+:FEAT_BITS];
endgenerate



    wire unsigned [5:0] pos_0;
    wire unsigned [5:0] neg_0;
    assign pos_0 = + feature_array[3] + feature_array[4] + feature_array[7] + feature_array[8];
    assign neg_0 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[5] + feature_array[6] + feature_array[9] + feature_array[10];
    assign hidden[0] = pos_0 >= neg_0;

    wire unsigned [4:0] pos_1;
    wire unsigned [6:0] neg_1;
    assign pos_1 = + feature_array[6] + feature_array[7] + feature_array[8];
    assign neg_1 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[9] + feature_array[10];
    assign hidden[1] = pos_1 >= neg_1;

    wire unsigned [5:0] pos_2;
    wire unsigned [6:0] neg_2;
    assign pos_2 = + feature_array[3] + feature_array[6] + feature_array[7];
    assign neg_2 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[4] + feature_array[5] + feature_array[8] + feature_array[9] + feature_array[10];
    assign hidden[2] = pos_2 >= neg_2;

    wire unsigned [5:0] pos_3;
    wire unsigned [5:0] neg_3;
    assign pos_3 = + feature_array[0] + feature_array[2] + feature_array[8] + feature_array[10];
    assign neg_3 = + feature_array[1] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[9];
    assign hidden[3] = pos_3 >= neg_3;

    wire unsigned [5:0] pos_4;
    wire unsigned [5:0] neg_4;
    assign pos_4 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[8];
    assign neg_4 = + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[9] + feature_array[10];
    assign hidden[4] = pos_4 >= neg_4;

    wire unsigned [5:0] pos_5;
    wire unsigned [5:0] neg_5;
    assign pos_5 = + feature_array[0] + feature_array[1] + feature_array[3] + feature_array[4] + feature_array[6] + feature_array[8] + feature_array[10];
    assign neg_5 = + feature_array[2] + feature_array[5] + feature_array[7] + feature_array[9];
    assign hidden[5] = pos_5 >= neg_5;

    wire unsigned [5:0] pos_6;
    wire unsigned [5:0] neg_6;
    assign pos_6 = + feature_array[0] + feature_array[3] + feature_array[4] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_6 = + feature_array[1] + feature_array[2] + feature_array[5] + feature_array[6] + feature_array[7];
    assign hidden[6] = pos_6 >= neg_6;

    wire unsigned [5:0] pos_7;
    wire unsigned [5:0] neg_7;
    assign pos_7 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[5] + feature_array[8] + feature_array[10];
    assign neg_7 = + feature_array[0] + feature_array[4] + feature_array[6] + feature_array[7] + feature_array[9];
    assign hidden[7] = pos_7 >= neg_7;

    wire unsigned [5:0] pos_8;
    wire unsigned [5:0] neg_8;
    assign pos_8 = + feature_array[4] + feature_array[5] + feature_array[7] + feature_array[8];
    assign neg_8 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[6] + feature_array[9] + feature_array[10];
    assign hidden[8] = pos_8 >= neg_8;

    wire unsigned [6:0] pos_9;
    wire unsigned [4:0] neg_9;
    assign pos_9 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[4] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_9 = + feature_array[3] + feature_array[5];
    assign hidden[9] = pos_9 >= neg_9;

    wire unsigned [4:0] pos_10;
    wire unsigned [6:0] neg_10;
    assign pos_10 = + feature_array[1] + feature_array[2] + feature_array[10];
    assign neg_10 = + feature_array[0] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9];
    assign hidden[10] = pos_10 >= neg_10;

    wire unsigned [5:0] pos_11;
    wire unsigned [5:0] neg_11;
    assign pos_11 = + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[9] + feature_array[10];
    assign neg_11 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[8];
    assign hidden[11] = pos_11 >= neg_11;

    wire unsigned [6:0] pos_12;
    wire unsigned [5:0] neg_12;
    assign pos_12 = + feature_array[0] + feature_array[2] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_12 = + feature_array[1] + feature_array[3] + feature_array[4] + feature_array[5];
    assign hidden[12] = pos_12 >= neg_12;

    wire unsigned [5:0] pos_13;
    wire unsigned [5:0] neg_13;
    assign pos_13 = + feature_array[0] + feature_array[2] + feature_array[3] + feature_array[7] + feature_array[8] + feature_array[9];
    assign neg_13 = + feature_array[1] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[10];
    assign hidden[13] = pos_13 >= neg_13;

    wire unsigned [5:0] pos_14;
    wire unsigned [5:0] neg_14;
    assign pos_14 = + feature_array[0] + feature_array[1] + feature_array[4] + feature_array[6] + feature_array[8];
    assign neg_14 = + feature_array[2] + feature_array[3] + feature_array[5] + feature_array[7] + feature_array[9] + feature_array[10];
    assign hidden[14] = pos_14 >= neg_14;

    wire unsigned [6:0] pos_15;
    wire unsigned [4:0] neg_15;
    assign pos_15 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_15 = + feature_array[3] + feature_array[7];
    assign hidden[15] = pos_15 >= neg_15;

    wire unsigned [5:0] pos_16;
    wire unsigned [5:0] neg_16;
    assign pos_16 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[7] + feature_array[9];
    assign neg_16 = + feature_array[0] + feature_array[5] + feature_array[6] + feature_array[8] + feature_array[10];
    assign hidden[16] = pos_16 >= neg_16;

    wire unsigned [5:0] pos_17;
    wire unsigned [5:0] neg_17;
    assign pos_17 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[6] + feature_array[8] + feature_array[10];
    assign neg_17 = + feature_array[0] + feature_array[4] + feature_array[5] + feature_array[7] + feature_array[9];
    assign hidden[17] = pos_17 >= neg_17;

    wire unsigned [5:0] pos_18;
    wire unsigned [5:0] neg_18;
    assign pos_18 = + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_18 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4];
    assign hidden[18] = pos_18 >= neg_18;

    wire unsigned [5:0] pos_19;
    wire unsigned [5:0] neg_19;
    assign pos_19 = + feature_array[2] + feature_array[3] + feature_array[5] + feature_array[7];
    assign neg_19 = + feature_array[0] + feature_array[1] + feature_array[4] + feature_array[6] + feature_array[8] + feature_array[9] + feature_array[10];
    assign hidden[19] = pos_19 >= neg_19;

    wire unsigned [5:0] pos_20;
    wire unsigned [5:0] neg_20;
    assign pos_20 = + feature_array[0] + feature_array[1] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[7];
    assign neg_20 = + feature_array[2] + feature_array[6] + feature_array[8] + feature_array[9] + feature_array[10];
    assign hidden[20] = pos_20 >= neg_20;

    wire unsigned [6:0] pos_21;
    wire unsigned [3:0] neg_21;
    assign pos_21 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_21 = + feature_array[7];
    assign hidden[21] = pos_21 >= neg_21;

    wire unsigned [5:0] pos_22;
    wire unsigned [5:0] neg_22;
    assign pos_22 = + feature_array[0] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[6] + feature_array[8] + feature_array[9];
    assign neg_22 = + feature_array[1] + feature_array[5] + feature_array[7] + feature_array[10];
    assign hidden[22] = pos_22 >= neg_22;

    wire unsigned [5:0] pos_23;
    wire unsigned [5:0] neg_23;
    assign pos_23 = + feature_array[0] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_23 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7];
    assign hidden[23] = pos_23 >= neg_23;

    wire unsigned [5:0] pos_24;
    wire unsigned [5:0] neg_24;
    assign pos_24 = + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[8] + feature_array[9];
    assign neg_24 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[6] + feature_array[7] + feature_array[10];
    assign hidden[24] = pos_24 >= neg_24;

    wire unsigned [5:0] pos_25;
    wire unsigned [5:0] neg_25;
    assign pos_25 = + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5];
    assign neg_25 = + feature_array[0] + feature_array[1] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10];
    assign hidden[25] = pos_25 >= neg_25;

    wire unsigned [5:0] pos_26;
    wire unsigned [5:0] neg_26;
    assign pos_26 = + feature_array[2] + feature_array[3] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[10];
    assign neg_26 = + feature_array[0] + feature_array[1] + feature_array[4] + feature_array[5] + feature_array[9];
    assign hidden[26] = pos_26 >= neg_26;

    wire unsigned [5:0] pos_27;
    wire unsigned [5:0] neg_27;
    assign pos_27 = + feature_array[0] + feature_array[5] + feature_array[7] + feature_array[9] + feature_array[10];
    assign neg_27 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[6] + feature_array[8];
    assign hidden[27] = pos_27 >= neg_27;

    wire unsigned [5:0] pos_28;
    wire unsigned [5:0] neg_28;
    assign pos_28 = + feature_array[3] + feature_array[5] + feature_array[7] + feature_array[8];
    assign neg_28 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[4] + feature_array[6] + feature_array[9] + feature_array[10];
    assign hidden[28] = pos_28 >= neg_28;

    wire unsigned [5:0] pos_29;
    wire unsigned [5:0] neg_29;
    assign pos_29 = + feature_array[0] + feature_array[1] + feature_array[4] + feature_array[6] + feature_array[7] + feature_array[8];
    assign neg_29 = + feature_array[2] + feature_array[3] + feature_array[5] + feature_array[9] + feature_array[10];
    assign hidden[29] = pos_29 >= neg_29;

    wire unsigned [5:0] pos_30;
    wire unsigned [5:0] neg_30;
    assign pos_30 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[4] + feature_array[5] + feature_array[10];
    assign neg_30 = + feature_array[0] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9];
    assign hidden[30] = pos_30 >= neg_30;

    wire unsigned [5:0] pos_31;
    wire unsigned [5:0] neg_31;
    assign pos_31 = + feature_array[2] + feature_array[4] + feature_array[6] + feature_array[9];
    assign neg_31 = + feature_array[0] + feature_array[1] + feature_array[3] + feature_array[5] + feature_array[7] + feature_array[8] + feature_array[10];
    assign hidden[31] = pos_31 >= neg_31;

    wire unsigned [5:0] pos_32;
    wire unsigned [5:0] neg_32;
    assign pos_32 = + feature_array[0] + feature_array[4] + feature_array[5] + feature_array[6];
    assign neg_32 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10];
    assign hidden[32] = pos_32 >= neg_32;

    wire unsigned [5:0] pos_33;
    wire unsigned [5:0] neg_33;
    assign pos_33 = + feature_array[0] + feature_array[1] + feature_array[4] + feature_array[8] + feature_array[9];
    assign neg_33 = + feature_array[2] + feature_array[3] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[10];
    assign hidden[33] = pos_33 >= neg_33;

    wire unsigned [5:0] pos_34;
    wire unsigned [5:0] neg_34;
    assign pos_34 = + feature_array[0] + feature_array[4] + feature_array[5] + feature_array[7] + feature_array[8] + feature_array[10];
    assign neg_34 = + feature_array[1] + feature_array[2] + feature_array[3] + feature_array[6] + feature_array[9];
    assign hidden[34] = pos_34 >= neg_34;

    wire unsigned [6:0] pos_35;
    wire unsigned [4:0] neg_35;
    assign pos_35 = + feature_array[1] + feature_array[2] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_35 = + feature_array[0] + feature_array[3];
    assign hidden[35] = pos_35 >= neg_35;

    wire unsigned [6:0] pos_36;
    wire unsigned [4:0] neg_36;
    assign pos_36 = + feature_array[1] + feature_array[2] + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[9] + feature_array[10];
    assign neg_36 = + feature_array[0] + feature_array[3] + feature_array[8];
    assign hidden[36] = pos_36 >= neg_36;

    wire unsigned [5:0] pos_37;
    wire unsigned [5:0] neg_37;
    assign pos_37 = + feature_array[2] + feature_array[5] + feature_array[6] + feature_array[9] + feature_array[10];
    assign neg_37 = + feature_array[0] + feature_array[1] + feature_array[3] + feature_array[4] + feature_array[7] + feature_array[8];
    assign hidden[37] = pos_37 >= neg_37;

    wire unsigned [5:0] pos_38;
    wire unsigned [5:0] neg_38;
    assign pos_38 = + feature_array[1] + feature_array[4] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_38 = + feature_array[0] + feature_array[2] + feature_array[3] + feature_array[5] + feature_array[6];
    assign hidden[38] = pos_38 >= neg_38;

    wire unsigned [5:0] pos_39;
    wire unsigned [5:0] neg_39;
    assign pos_39 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[5] + feature_array[6] + feature_array[8] + feature_array[9] + feature_array[10];
    assign neg_39 = + feature_array[3] + feature_array[4] + feature_array[7];
    assign hidden[39] = pos_39 >= neg_39;
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
