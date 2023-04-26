






module Har_tnn1_tnnparw #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
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
wire [HIDDEN_CNT-1:0] hidden_n;
wire [SUM_BITS-1:0] popcount [CLASS_CNT-1:0]; 
wire [(SUM_BITS+1)-1:0] scores [CLASS_CNT-1:0]; 
wire [CLASS_CNT*(SUM_BITS+1)-1:0] score_vec; 
assign hidden_n = ~hidden;

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[i] = features[i*FEAT_BITS+:FEAT_BITS];
endgenerate
generate
    for(i=0;i<CLASS_CNT;i=i+1)
        assign score_vec[i*SCORE_BITS+:SCORE_BITS] = scores[i];
endgenerate



    wire signed [5:0] intra_0;
    assign intra_0 = - feature_array[0] + feature_array[1]  - feature_array[3] - feature_array[4]  + feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] + feature_array[10] + feature_array[11];
    assign hidden[0] = intra_0 >= 0;

    wire signed [6:0] intra_1;
    assign intra_1 =  + feature_array[1] - feature_array[2] + feature_array[3]  + feature_array[5]  - feature_array[7] + feature_array[8] + feature_array[9]  ;
    assign hidden[1] = intra_1 >= 0;

    wire signed [5:0] intra_2;
    assign intra_2 =     - feature_array[4]       - feature_array[11];
    assign hidden[2] = intra_2 >= 0;

    wire signed [6:0] intra_3;
    assign intra_3 = - feature_array[0]  + feature_array[2] + feature_array[3] - feature_array[4] - feature_array[5]    - feature_array[9]  - feature_array[11];
    assign hidden[3] = intra_3 >= 0;

    wire signed [6:0] intra_4;
    assign intra_4 =    + feature_array[3]   + feature_array[6] + feature_array[7] + feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11];
    assign hidden[4] = intra_4 >= 0;

    wire signed [7:0] intra_5;
    assign intra_5 = + feature_array[0]  + feature_array[2]   + feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9]  ;
    assign hidden[5] = intra_5 >= 0;

    wire signed [5:0] intra_6;
    assign intra_6 =  - feature_array[1] + feature_array[2] + feature_array[3]     - feature_array[8] + feature_array[9]  + feature_array[11];
    assign hidden[6] = intra_6 >= 0;

    wire signed [6:0] intra_7;
    assign intra_7 = - feature_array[0] + feature_array[1] + feature_array[2] - feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9]  + feature_array[11];
    assign hidden[7] = intra_7 >= 0;

    wire signed [6:0] intra_8;
    assign intra_8 =  - feature_array[1] - feature_array[2] - feature_array[3]  + feature_array[5]     - feature_array[10] ;
    assign hidden[8] = intra_8 >= 0;

    wire signed [5:0] intra_9;
    assign intra_9 = + feature_array[0] + feature_array[1] - feature_array[2] - feature_array[3]  + feature_array[5] - feature_array[6] - feature_array[7]  + feature_array[9] - feature_array[10] + feature_array[11];
    assign hidden[9] = intra_9 >= 0;

    wire signed [6:0] intra_10;
    assign intra_10 =  - feature_array[1] - feature_array[2] + feature_array[3] - feature_array[4] - feature_array[5]   + feature_array[8] + feature_array[9]  ;
    assign hidden[10] = intra_10 >= 0;

    wire signed [5:0] intra_11;
    assign intra_11 =   + feature_array[2] + feature_array[3]    + feature_array[7]   - feature_array[10] - feature_array[11];
    assign hidden[11] = intra_11 >= 0;

    wire signed [6:0] intra_12;
    assign intra_12 = - feature_array[0]    + feature_array[4] + feature_array[5] + feature_array[6] + feature_array[7]  + feature_array[9]  + feature_array[11];
    assign hidden[12] = intra_12 >= 0;

    wire signed [5:0] intra_13;
    assign intra_13 = + feature_array[0] + feature_array[1]  - feature_array[3]  - feature_array[5]  + feature_array[7]  - feature_array[9] + feature_array[10] - feature_array[11];
    assign hidden[13] = intra_13 >= 0;

    wire signed [6:0] intra_14;
    assign intra_14 = + feature_array[0]  + feature_array[2] - feature_array[3]   + feature_array[6] + feature_array[7]   + feature_array[10] ;
    assign hidden[14] = intra_14 >= 0;

    wire signed [5:0] intra_15;
    assign intra_15 = - feature_array[0] + feature_array[1]  + feature_array[3]  - feature_array[5]     - feature_array[10] - feature_array[11];
    assign hidden[15] = intra_15 >= 0;

    wire signed [5:0] intra_16;
    assign intra_16 = + feature_array[0]   + feature_array[3]     + feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11];
    assign hidden[16] = intra_16 >= 0;

    wire signed [5:0] intra_17;
    assign intra_17 = + feature_array[0] - feature_array[1]     - feature_array[6]  + feature_array[8] - feature_array[9]  - feature_array[11];
    assign hidden[17] = intra_17 >= 0;

    wire signed [5:0] intra_18;
    assign intra_18 = - feature_array[0]   + feature_array[3]  + feature_array[5]   - feature_array[8] + feature_array[9]  + feature_array[11];
    assign hidden[18] = intra_18 >= 0;

    wire signed [6:0] intra_19;
    assign intra_19 = + feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3]  + feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8]  + feature_array[10] + feature_array[11];
    assign hidden[19] = intra_19 >= 0;

    wire signed [6:0] intra_20;
    assign intra_20 =  - feature_array[1]   + feature_array[4]    + feature_array[8] + feature_array[9] - feature_array[10] + feature_array[11];
    assign hidden[20] = intra_20 >= 0;

    wire signed [5:0] intra_21;
    assign intra_21 =    - feature_array[3]   + feature_array[6] + feature_array[7]  - feature_array[9]  ;
    assign hidden[21] = intra_21 >= 0;

    wire signed [5:0] intra_22;
    assign intra_22 =     - feature_array[4] + feature_array[5]  - feature_array[7] - feature_array[8] - feature_array[9] + feature_array[10] ;
    assign hidden[22] = intra_22 >= 0;

    wire signed [5:0] intra_23;
    assign intra_23 = - feature_array[0]  + feature_array[2]  - feature_array[4]   + feature_array[7]  - feature_array[9] + feature_array[10] + feature_array[11];
    assign hidden[23] = intra_23 >= 0;

    wire signed [6:0] intra_24;
    assign intra_24 =  - feature_array[1]  + feature_array[3]   + feature_array[6] + feature_array[7] - feature_array[8] + feature_array[9]  + feature_array[11];
    assign hidden[24] = intra_24 >= 0;

    wire signed [5:0] intra_25;
    assign intra_25 = - feature_array[0] + feature_array[1] - feature_array[2] + feature_array[3] + feature_array[4]  + feature_array[6] - feature_array[7]  + feature_array[9]  - feature_array[11];
    assign hidden[25] = intra_25 >= 0;

    wire signed [6:0] intra_26;
    assign intra_26 =  - feature_array[1] + feature_array[2] - feature_array[3] - feature_array[4]  + feature_array[6] - feature_array[7]   + feature_array[10] ;
    assign hidden[26] = intra_26 >= 0;

    wire signed [5:0] intra_27;
    assign intra_27 =  + feature_array[1]  + feature_array[3] - feature_array[4]  - feature_array[6]   + feature_array[9]  ;
    assign hidden[27] = intra_27 >= 0;

    wire signed [6:0] intra_28;
    assign intra_28 = - feature_array[0]     + feature_array[5]  + feature_array[7] - feature_array[8] - feature_array[9]  - feature_array[11];
    assign hidden[28] = intra_28 >= 0;

    wire signed [5:0] intra_29;
    assign intra_29 = + feature_array[0] - feature_array[1] - feature_array[2] + feature_array[3] + feature_array[4]  + feature_array[6] - feature_array[7]    - feature_array[11];
    assign hidden[29] = intra_29 >= 0;

    wire signed [5:0] intra_30;
    assign intra_30 = + feature_array[0] - feature_array[1] - feature_array[2] + feature_array[3]     + feature_array[8] - feature_array[9]  ;
    assign hidden[30] = intra_30 >= 0;

    wire signed [5:0] intra_31;
    assign intra_31 = + feature_array[0] + feature_array[1]  + feature_array[3] - feature_array[4] - feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8]   ;
    assign hidden[31] = intra_31 >= 0;

    wire signed [6:0] intra_32;
    assign intra_32 =  + feature_array[1] + feature_array[2] - feature_array[3] - feature_array[4] - feature_array[5]    - feature_array[9] - feature_array[10] - feature_array[11];
    assign hidden[32] = intra_32 >= 0;

    wire signed [5:0] intra_33;
    assign intra_33 = - feature_array[0] + feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7]    - feature_array[11];
    assign hidden[33] = intra_33 >= 0;

    wire signed [6:0] intra_34;
    assign intra_34 = - feature_array[0] + feature_array[1]  - feature_array[3] + feature_array[4]  - feature_array[6] + feature_array[7]   + feature_array[10] + feature_array[11];
    assign hidden[34] = intra_34 >= 0;

    wire signed [5:0] intra_35;
    assign intra_35 = - feature_array[0] + feature_array[1]   + feature_array[4]  - feature_array[6]  - feature_array[8] + feature_array[9] + feature_array[10] - feature_array[11];
    assign hidden[35] = intra_35 >= 0;

    wire signed [5:0] intra_36;
    assign intra_36 = - feature_array[0] + feature_array[1]  + feature_array[3] - feature_array[4] - feature_array[5]     - feature_array[10] ;
    assign hidden[36] = intra_36 >= 0;

    wire signed [5:0] intra_37;
    assign intra_37 = - feature_array[0]  - feature_array[2]   - feature_array[5] + feature_array[6] + feature_array[7]  - feature_array[9]  ;
    assign hidden[37] = intra_37 >= 0;

    wire signed [5:0] intra_38;
    assign intra_38 = - feature_array[0]    + feature_array[4]    + feature_array[8]   - feature_array[11];
    assign hidden[38] = intra_38 >= 0;

    wire signed [5:0] intra_39;
    assign intra_39 = + feature_array[0]   + feature_array[3] - feature_array[4]   + feature_array[7] - feature_array[8] - feature_array[9] + feature_array[10] - feature_array[11];
    assign hidden[39] = intra_39 >= 0;
assign popcount[0] = + hidden[6] + hidden[10] + hidden[13] + hidden_n[14] + hidden_n[16] + hidden[17] + hidden[20] + hidden_n[22] + hidden[24] + hidden[25] + hidden_n[26] + hidden_n[28] + hidden_n[30] + hidden_n[32] + hidden[34] + hidden_n[36];assign scores[0] = 2*popcount[0] + 1;
assign popcount[1] = + hidden_n[5] + hidden[6] + hidden[10] + hidden_n[11] + hidden[12] + hidden[14] + hidden_n[16] + hidden[18] + hidden[20] + hidden_n[22] + hidden[24] + hidden_n[29] + hidden_n[31] + hidden_n[33] + hidden[34] + hidden_n[35] + hidden_n[36];assign scores[1] = 2*popcount[1] + 0;
assign popcount[2] = + hidden_n[0] + hidden[1] + hidden[6] + hidden[10] + hidden_n[13] + hidden[17] + hidden[18] + hidden_n[21] + hidden_n[22] + hidden[24] + hidden[25] + hidden_n[26] + hidden[27] + hidden[32] + hidden_n[33];assign scores[2] = 2*popcount[2] + 2;
assign popcount[3] = + hidden[0] + hidden_n[1] + hidden[4] + hidden_n[11] + hidden[16] + hidden[17] + hidden_n[18] + hidden[21] + hidden[24] + hidden_n[29] + hidden[31] + hidden[32] + hidden[34] + hidden_n[38];assign scores[3] = 2*popcount[3] + 3;
assign popcount[4] = + hidden_n[4] + hidden[5] + hidden[8] + hidden[11] + hidden[12] + hidden[14] + hidden_n[18] + hidden_n[25] + hidden_n[29] + hidden_n[31] + hidden[32] + hidden_n[35] + hidden_n[38];assign scores[4] = 2*popcount[4] + 4;
assign popcount[5] = + hidden[0] + hidden[3] + hidden[11] + hidden[13] + hidden[17] + hidden_n[18] + hidden_n[23] + hidden[26] + hidden[27] + hidden_n[29] + hidden[32] + hidden_n[35] + hidden_n[38] + hidden[39];assign scores[5] = 2*popcount[5] + 3;


argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS+1)) result (
    .inx(score_vec),
    .outimax(prediction)
);
endmodule
