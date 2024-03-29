






module gasId_bnn1_bnnparstepw #(

parameter FEAT_CNT = 128,
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



    wire signed [4:0] intra_0_0;
    assign intra_0_0 = + feature_array[0] + feature_array[1] - feature_array[2];

    wire signed [5:0] intra_0_1;
    assign intra_0_1 = + feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + intra_0_0;

    wire signed [6:0] intra_0_2;
    assign intra_0_2 = + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] - feature_array[16] - feature_array[17] - feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] + feature_array[22] + feature_array[23] + feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] - feature_array[29] + feature_array[30] - feature_array[31] - feature_array[32] + feature_array[33] + feature_array[34] + feature_array[35] + feature_array[36] - feature_array[37] - feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] + feature_array[42] + feature_array[43] - feature_array[44] + intra_0_1;

    wire signed [7:0] intra_0_3;
    assign intra_0_3 = - feature_array[45] - feature_array[46] - feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] - feature_array[52] + feature_array[53] + feature_array[54] - feature_array[55] - feature_array[56] + feature_array[57] + feature_array[58] - feature_array[59] - feature_array[60] - feature_array[61] - feature_array[62] + intra_0_2;

    wire signed [8:0] intra_0_4;
    assign intra_0_4 = - feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] - feature_array[69] - feature_array[70] - feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] - feature_array[77] + feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] - feature_array[87] + feature_array[88] - feature_array[89] - feature_array[90] - feature_array[91] - feature_array[92] + feature_array[93] + feature_array[94] + feature_array[95] + feature_array[96] + feature_array[97] - feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] + feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] + feature_array[109] + feature_array[110] + feature_array[111] - feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] + feature_array[119] + feature_array[120] - feature_array[121] + feature_array[122] - feature_array[123] + feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_0_3;
    assign hidden[0] = intra_0_4 >= 0;

    wire signed [4:0] intra_1_0;
    assign intra_1_0 = - feature_array[0] + feature_array[1] + feature_array[2] - feature_array[3];

    wire signed [5:0] intra_1_1;
    assign intra_1_1 = - feature_array[4] + feature_array[5] - feature_array[6] + intra_1_0;

    wire signed [6:0] intra_1_2;
    assign intra_1_2 = - feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] - feature_array[12] - feature_array[13] - feature_array[14] - feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] + feature_array[20] + feature_array[21] + feature_array[22] + feature_array[23] + feature_array[24] + feature_array[25] + feature_array[26] + intra_1_1;

    wire signed [7:0] intra_1_3;
    assign intra_1_3 = + feature_array[27] + feature_array[28] + feature_array[29] + feature_array[30] - feature_array[31] - feature_array[32] - feature_array[33] - feature_array[34] + feature_array[35] - feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] + feature_array[43] + feature_array[44] - feature_array[45] - feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] + feature_array[52] + feature_array[53] + feature_array[54] - feature_array[55] + feature_array[56] - feature_array[57] + feature_array[58] + feature_array[59] - feature_array[60] - feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] - feature_array[69] + feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] - feature_array[78] - feature_array[79] + feature_array[80] + feature_array[81] - feature_array[82] + feature_array[83] + feature_array[84] + feature_array[85] + feature_array[86] + intra_1_2;

    wire signed [8:0] intra_1_4;
    assign intra_1_4 = - feature_array[87] - feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] - feature_array[92] - feature_array[93] - feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] + feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] + feature_array[110] - feature_array[111] - feature_array[112] - feature_array[113] - feature_array[114] + feature_array[115] + feature_array[116] + feature_array[117] + feature_array[118] + feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] + feature_array[123] + feature_array[124] + feature_array[125] - feature_array[126] + feature_array[127] + intra_1_3;
    assign hidden[1] = intra_1_4 >= 0;

    wire signed [4:0] intra_2_0;
    assign intra_2_0 = + feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3];

    wire signed [5:0] intra_2_1;
    assign intra_2_1 = - feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] - feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] + intra_2_0;

    wire signed [6:0] intra_2_2;
    assign intra_2_2 = + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] + feature_array[20] - feature_array[21] - feature_array[22] - feature_array[23] + feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] - feature_array[29] - feature_array[30] - feature_array[31] - feature_array[32] - feature_array[33] - feature_array[34] - feature_array[35] - feature_array[36] + feature_array[37] + feature_array[38] + feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] - feature_array[43] - feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] + feature_array[50] + feature_array[51] - feature_array[52] - feature_array[53] - feature_array[54] - feature_array[55] + intra_2_1;

    wire signed [7:0] intra_2_3;
    assign intra_2_3 = + feature_array[56] - feature_array[57] + feature_array[58] - feature_array[59] - feature_array[60] - feature_array[61] + feature_array[62] + feature_array[63] + feature_array[64] - feature_array[65] + feature_array[66] - feature_array[67] - feature_array[68] - feature_array[69] - feature_array[70] + feature_array[71] + feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] - feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] - feature_array[87] - feature_array[88] + feature_array[89] + feature_array[90] - feature_array[91] - feature_array[92] + feature_array[93] - feature_array[94] + feature_array[95] - feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] + feature_array[101] + feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] + feature_array[109] - feature_array[110] + feature_array[111] + feature_array[112] - feature_array[113] + feature_array[114] + feature_array[115] - feature_array[116] + feature_array[117] + feature_array[118] - feature_array[119] + feature_array[120] + feature_array[121] - feature_array[122] + feature_array[123] - feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_2_2;
    assign hidden[2] = intra_2_3 >= 0;

    wire signed [4:0] intra_3_0;
    assign intra_3_0 = - feature_array[0] - feature_array[1];

    wire signed [5:0] intra_3_1;
    assign intra_3_1 = - feature_array[2] + intra_3_0;

    wire signed [6:0] intra_3_2;
    assign intra_3_2 = - feature_array[3] - feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] - feature_array[11] - feature_array[12] + feature_array[13] + feature_array[14] - feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] - feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] + feature_array[24] + feature_array[25] + intra_3_1;

    wire signed [7:0] intra_3_3;
    assign intra_3_3 = + feature_array[26] + feature_array[27] + feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] + feature_array[32] - feature_array[33] + feature_array[34] + feature_array[35] + feature_array[36] - feature_array[37] - feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] - feature_array[42] + intra_3_2;

    wire signed [8:0] intra_3_4;
    assign intra_3_4 = + feature_array[43] + feature_array[44] - feature_array[45] + feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] + feature_array[52] - feature_array[53] - feature_array[54] + feature_array[55] - feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] + feature_array[60] + feature_array[61] - feature_array[62] + feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + intra_3_3;

    wire signed [9:0] intra_3_5;
    assign intra_3_5 = + feature_array[71] + feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] + feature_array[84] - feature_array[85] + feature_array[86] - feature_array[87] + feature_array[88] + feature_array[89] + feature_array[90] - feature_array[91] - feature_array[92] + feature_array[93] + feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] - feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] - feature_array[103] + feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] + feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] + feature_array[121] + feature_array[122] - feature_array[123] - feature_array[124] - feature_array[125] - feature_array[126] + feature_array[127] + intra_3_4;
    assign hidden[3] = intra_3_5 >= 0;

    wire signed [5:0] intra_4_0;
    assign intra_4_0 = + feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [6:0] intra_4_1;
    assign intra_4_1 = + feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] + feature_array[15] - feature_array[16] - feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] + feature_array[21] + feature_array[22] + feature_array[23] - feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] + feature_array[32] - feature_array[33] + feature_array[34] + feature_array[35] - feature_array[36] - feature_array[37] + feature_array[38] - feature_array[39] - feature_array[40] - feature_array[41] + feature_array[42] + feature_array[43] + feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] + feature_array[52] + feature_array[53] - feature_array[54] - feature_array[55] - feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] - feature_array[63] + feature_array[64] + feature_array[65] + intra_4_0;

    wire signed [7:0] intra_4_2;
    assign intra_4_2 = + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] - feature_array[89] - feature_array[90] + feature_array[91] + feature_array[92] - feature_array[93] - feature_array[94] - feature_array[95] + feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] - feature_array[103] + feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] + feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] - feature_array[114] + feature_array[115] + feature_array[116] - feature_array[117] + feature_array[118] - feature_array[119] + feature_array[120] - feature_array[121] - feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] - feature_array[127] + intra_4_1;
    assign hidden[4] = intra_4_2 >= 0;

    wire signed [4:0] intra_5_0;
    assign intra_5_0 = + feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3];

    wire signed [5:0] intra_5_1;
    assign intra_5_1 = - feature_array[4] + feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] - feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] + intra_5_0;

    wire signed [6:0] intra_5_2;
    assign intra_5_2 = + feature_array[16] + feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] + feature_array[21] + feature_array[22] - feature_array[23] + feature_array[24] - feature_array[25] + feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] + feature_array[30] - feature_array[31] + feature_array[32] + feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] - feature_array[39] + feature_array[40] - feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] - feature_array[46] - feature_array[47] - feature_array[48] - feature_array[49] + feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] - feature_array[55] + feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] + feature_array[62] + feature_array[63] - feature_array[64] - feature_array[65] + feature_array[66] - feature_array[67] + feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] + feature_array[76] - feature_array[77] - feature_array[78] - feature_array[79] + intra_5_1;

    wire signed [7:0] intra_5_3;
    assign intra_5_3 = + feature_array[80] + feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] - feature_array[92] - feature_array[93] + feature_array[94] - feature_array[95] + feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] + feature_array[101] - feature_array[102] - feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] - feature_array[110] + feature_array[111] + feature_array[112] - feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] + feature_array[119] + feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] + feature_array[126] - feature_array[127] + intra_5_2;
    assign hidden[5] = intra_5_3 >= 0;

    wire signed [5:0] intra_6_0;
    assign intra_6_0 = + feature_array[0] + feature_array[1] + feature_array[2] + feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] - feature_array[11] - feature_array[12] + feature_array[13] - feature_array[14] + feature_array[15];

    wire signed [6:0] intra_6_1;
    assign intra_6_1 = - feature_array[16] + feature_array[17] - feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] - feature_array[29] + intra_6_0;

    wire signed [7:0] intra_6_2;
    assign intra_6_2 = - feature_array[30] - feature_array[31] - feature_array[32] - feature_array[33] - feature_array[34] + feature_array[35] - feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] + feature_array[43] - feature_array[44] - feature_array[45] + feature_array[46] - feature_array[47] + feature_array[48] - feature_array[49] + feature_array[50] + feature_array[51] + feature_array[52] - feature_array[53] + feature_array[54] - feature_array[55] - feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] + feature_array[63] + feature_array[64] - feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] + feature_array[78] - feature_array[79] + feature_array[80] - feature_array[81] + feature_array[82] + feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] - feature_array[87] - feature_array[88] + feature_array[89] - feature_array[90] - feature_array[91] - feature_array[92] - feature_array[93] + feature_array[94] + feature_array[95] - feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] + feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] - feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] + feature_array[114] + feature_array[115] - feature_array[116] + feature_array[117] + feature_array[118] - feature_array[119] - feature_array[120] - feature_array[121] + feature_array[122] + feature_array[123] + feature_array[124] + feature_array[125] + feature_array[126] + feature_array[127] + intra_6_1;
    assign hidden[6] = intra_6_2 >= 0;

    wire signed [4:0] intra_7_0;
    assign intra_7_0 = - feature_array[0] - feature_array[1] + feature_array[2] + feature_array[3];

    wire signed [5:0] intra_7_1;
    assign intra_7_1 = + feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] + intra_7_0;

    wire signed [6:0] intra_7_2;
    assign intra_7_2 = + feature_array[8] + feature_array[9] + feature_array[10] + intra_7_1;

    wire signed [7:0] intra_7_3;
    assign intra_7_3 = + feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] - feature_array[19] - feature_array[20] - feature_array[21] - feature_array[22] + feature_array[23] + feature_array[24] - feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] - feature_array[29] + feature_array[30] + feature_array[31] + feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] - feature_array[39] - feature_array[40] + feature_array[41] + feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] - feature_array[46] - feature_array[47] + feature_array[48] + feature_array[49] + feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] - feature_array[55] + feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] - feature_array[61] + feature_array[62] + feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] - feature_array[70] + feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] - feature_array[83] + feature_array[84] + feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] - feature_array[89] + feature_array[90] + feature_array[91] - feature_array[92] - feature_array[93] - feature_array[94] + feature_array[95] + feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] + feature_array[102] + feature_array[103] + feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] + feature_array[109] - feature_array[110] - feature_array[111] - feature_array[112] + feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] + feature_array[118] + feature_array[119] + feature_array[120] + feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] - feature_array[125] - feature_array[126] + feature_array[127] + intra_7_2;
    assign hidden[7] = intra_7_3 >= 0;

    wire signed [4:0] intra_8_0;
    assign intra_8_0 = - feature_array[0] - feature_array[1];

    wire signed [5:0] intra_8_1;
    assign intra_8_1 = - feature_array[2] + intra_8_0;

    wire signed [6:0] intra_8_2;
    assign intra_8_2 = - feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] + feature_array[12] - feature_array[13] - feature_array[14] + feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] + feature_array[20] - feature_array[21] + feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] - feature_array[29] + feature_array[30] - feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] + feature_array[39] - feature_array[40] - feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] - feature_array[45] + intra_8_1;

    wire signed [7:0] intra_8_3;
    assign intra_8_3 = + feature_array[46] + feature_array[47] + feature_array[48] - feature_array[49] - feature_array[50] + feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] + feature_array[55] + feature_array[56] - feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] + feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] - feature_array[78] - feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] - feature_array[84] - feature_array[85] + feature_array[86] + feature_array[87] + intra_8_2;

    wire signed [8:0] intra_8_4;
    assign intra_8_4 = + feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] - feature_array[92] + feature_array[93] - feature_array[94] + feature_array[95] + feature_array[96] + feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] - feature_array[102] + feature_array[103] + feature_array[104] + feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] + feature_array[110] - feature_array[111] + feature_array[112] + feature_array[113] - feature_array[114] + feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] + feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_8_3;
    assign hidden[8] = intra_8_4 >= 0;

    wire signed [4:0] intra_9_0;
    assign intra_9_0 = + feature_array[0] + feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4];

    wire signed [5:0] intra_9_1;
    assign intra_9_1 = - feature_array[5] + intra_9_0;

    wire signed [6:0] intra_9_2;
    assign intra_9_2 = - feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] - feature_array[11] + feature_array[12] + feature_array[13] + intra_9_1;

    wire signed [7:0] intra_9_3;
    assign intra_9_3 = - feature_array[14] - feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] + feature_array[20] - feature_array[21] - feature_array[22] - feature_array[23] + feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] - feature_array[29] + feature_array[30] - feature_array[31] + feature_array[32] + feature_array[33] + feature_array[34] + feature_array[35] + feature_array[36] - feature_array[37] - feature_array[38] - feature_array[39] - feature_array[40] - feature_array[41] - feature_array[42] + feature_array[43] - feature_array[44] + feature_array[45] - feature_array[46] + feature_array[47] - feature_array[48] - feature_array[49] + feature_array[50] + feature_array[51] - feature_array[52] + feature_array[53] - feature_array[54] + feature_array[55] + feature_array[56] - feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] + feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] + intra_9_2;

    wire signed [8:0] intra_9_4;
    assign intra_9_4 = - feature_array[66] - feature_array[67] + feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] - feature_array[75] + feature_array[76] - feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] + feature_array[82] + feature_array[83] + feature_array[84] - feature_array[85] + feature_array[86] - feature_array[87] + feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] - feature_array[92] - feature_array[93] + feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] + feature_array[102] + feature_array[103] + feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] - feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] + feature_array[117] + feature_array[118] - feature_array[119] + feature_array[120] + feature_array[121] + feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] + feature_array[126] - feature_array[127] + intra_9_3;
    assign hidden[9] = intra_9_4 >= 0;

    wire signed [4:0] intra_10_0;
    assign intra_10_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_10_1;
    assign intra_10_1 = + feature_array[2] - feature_array[3] - feature_array[4] + intra_10_0;

    wire signed [6:0] intra_10_2;
    assign intra_10_2 = - feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] + feature_array[13] + feature_array[14] - feature_array[15] - feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] - feature_array[20] + intra_10_1;

    wire signed [7:0] intra_10_3;
    assign intra_10_3 = - feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] - feature_array[29] + feature_array[30] - feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] - feature_array[40] - feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] + feature_array[46] - feature_array[47] + feature_array[48] - feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] + feature_array[53] - feature_array[54] - feature_array[55] + feature_array[56] - feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] - feature_array[61] + feature_array[62] + feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] + feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] + feature_array[78] - feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] - feature_array[83] + feature_array[84] - feature_array[85] + feature_array[86] + feature_array[87] + feature_array[88] + feature_array[89] + feature_array[90] - feature_array[91] + feature_array[92] - feature_array[93] + feature_array[94] - feature_array[95] - feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] + feature_array[101] + feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] + feature_array[109] - feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] + feature_array[118] - feature_array[119] + feature_array[120] + feature_array[121] + feature_array[122] - feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] + intra_10_2;

    wire signed [8:0] intra_10_4;
    assign intra_10_4 = - feature_array[127] + intra_10_3;
    assign hidden[10] = intra_10_4 >= 0;

    wire signed [4:0] intra_11_0;
    assign intra_11_0 = - feature_array[0] - feature_array[1] + feature_array[2] - feature_array[3];

    wire signed [5:0] intra_11_1;
    assign intra_11_1 = - feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] - feature_array[8] - feature_array[9] + intra_11_0;

    wire signed [6:0] intra_11_2;
    assign intra_11_2 = - feature_array[10] - feature_array[11] - feature_array[12] + feature_array[13] + feature_array[14] + feature_array[15] - feature_array[16] + feature_array[17] + feature_array[18] - feature_array[19] - feature_array[20] - feature_array[21] - feature_array[22] - feature_array[23] + feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] - feature_array[29] - feature_array[30] + feature_array[31] + feature_array[32] + feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] - feature_array[40] - feature_array[41] + feature_array[42] - feature_array[43] + feature_array[44] - feature_array[45] + feature_array[46] + intra_11_1;

    wire signed [7:0] intra_11_3;
    assign intra_11_3 = + feature_array[47] + feature_array[48] - feature_array[49] + feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] + feature_array[55] - feature_array[56] + feature_array[57] - feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] + feature_array[63] - feature_array[64] + feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] + feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] + feature_array[87] + feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] + feature_array[92] - feature_array[93] - feature_array[94] + feature_array[95] - feature_array[96] + feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] + feature_array[101] + feature_array[102] + feature_array[103] + feature_array[104] + feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] + feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] + feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] + feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] - feature_array[126] + feature_array[127] + intra_11_2;
    assign hidden[11] = intra_11_3 >= 0;

    wire signed [4:0] intra_12_0;
    assign intra_12_0 = - feature_array[0] - feature_array[1];

    wire signed [5:0] intra_12_1;
    assign intra_12_1 = - feature_array[2] - feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] - feature_array[8] - feature_array[9] + feature_array[10] + feature_array[11] - feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] - feature_array[16] + feature_array[17] + feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] + feature_array[24] + feature_array[25] - feature_array[26] + feature_array[27] - feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] - feature_array[32] - feature_array[33] + feature_array[34] - feature_array[35] - feature_array[36] - feature_array[37] + feature_array[38] - feature_array[39] + feature_array[40] + feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] - feature_array[48] - feature_array[49] + feature_array[50] + feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] + feature_array[55] + feature_array[56] + feature_array[57] - feature_array[58] + intra_12_0;

    wire signed [6:0] intra_12_2;
    assign intra_12_2 = + feature_array[59] + feature_array[60] + feature_array[61] + feature_array[62] + feature_array[63] - feature_array[64] + feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] + intra_12_1;

    wire signed [7:0] intra_12_3;
    assign intra_12_3 = - feature_array[72] + feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] + feature_array[78] + feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] - feature_array[84] + feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] - feature_array[89] + feature_array[90] - feature_array[91] + feature_array[92] - feature_array[93] - feature_array[94] - feature_array[95] - feature_array[96] + feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] - feature_array[102] - feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] - feature_array[115] + feature_array[116] - feature_array[117] + feature_array[118] - feature_array[119] + feature_array[120] + feature_array[121] + feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] - feature_array[126] + feature_array[127] + intra_12_2;
    assign hidden[12] = intra_12_3 >= 0;

    wire signed [4:0] intra_13_0;
    assign intra_13_0 = + feature_array[0] - feature_array[1] - feature_array[2] + feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6];

    wire signed [5:0] intra_13_1;
    assign intra_13_1 = - feature_array[7] - feature_array[8] - feature_array[9] + feature_array[10] + feature_array[11] - feature_array[12] + feature_array[13] - feature_array[14] + feature_array[15] - feature_array[16] - feature_array[17] + intra_13_0;

    wire signed [6:0] intra_13_2;
    assign intra_13_2 = - feature_array[18] - feature_array[19] + feature_array[20] - feature_array[21] + intra_13_1;

    wire signed [7:0] intra_13_3;
    assign intra_13_3 = - feature_array[22] - feature_array[23] - feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] - feature_array[30] + feature_array[31] + feature_array[32] + feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] - feature_array[37] + feature_array[38] - feature_array[39] - feature_array[40] - feature_array[41] + feature_array[42] - feature_array[43] + intra_13_2;

    wire signed [8:0] intra_13_4;
    assign intra_13_4 = - feature_array[44] - feature_array[45] + feature_array[46] - feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] + feature_array[53] - feature_array[54] + feature_array[55] - feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] - feature_array[62] + feature_array[63] - feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] - feature_array[68] - feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] - feature_array[74] + feature_array[75] - feature_array[76] - feature_array[77] + feature_array[78] + feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] - feature_array[89] - feature_array[90] - feature_array[91] - feature_array[92] + feature_array[93] + feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] + feature_array[99] - feature_array[100] - feature_array[101] + feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] - feature_array[108] + feature_array[109] - feature_array[110] + feature_array[111] - feature_array[112] - feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] - feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] + intra_13_3;

    wire signed [9:0] intra_13_5;
    assign intra_13_5 = - feature_array[126] - feature_array[127] + intra_13_4;
    assign hidden[13] = intra_13_5 >= 0;

    wire signed [4:0] intra_14_0;
    assign intra_14_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_14_1;
    assign intra_14_1 = + feature_array[2] + intra_14_0;

    wire signed [6:0] intra_14_2;
    assign intra_14_2 = + feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] + intra_14_1;

    wire signed [7:0] intra_14_3;
    assign intra_14_3 = + feature_array[8] - feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] + feature_array[13] + feature_array[14] + feature_array[15] + feature_array[16] - feature_array[17] - feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] + feature_array[22] + feature_array[23] + feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] - feature_array[29] - feature_array[30] + feature_array[31] + feature_array[32] - feature_array[33] + feature_array[34] + feature_array[35] + feature_array[36] - feature_array[37] + feature_array[38] - feature_array[39] - feature_array[40] - feature_array[41] + feature_array[42] + feature_array[43] - feature_array[44] - feature_array[45] - feature_array[46] - feature_array[47] + feature_array[48] + feature_array[49] + feature_array[50] - feature_array[51] + feature_array[52] - feature_array[53] + feature_array[54] - feature_array[55] + feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] + intra_14_2;

    wire signed [8:0] intra_14_4;
    assign intra_14_4 = + feature_array[62] + feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] - feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] - feature_array[89] + feature_array[90] - feature_array[91] - feature_array[92] - feature_array[93] - feature_array[94] + feature_array[95] + feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] - feature_array[100] - feature_array[101] - feature_array[102] - feature_array[103] + feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] - feature_array[108] - feature_array[109] + feature_array[110] - feature_array[111] - feature_array[112] - feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] - feature_array[121] + feature_array[122] - feature_array[123] + feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_14_3;
    assign hidden[14] = intra_14_4 >= 0;

    wire signed [5:0] intra_15_0;
    assign intra_15_0 = + feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [6:0] intra_15_1;
    assign intra_15_1 = + feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] - feature_array[16] - feature_array[17] - feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] - feature_array[22] - feature_array[23] + intra_15_0;

    wire signed [7:0] intra_15_2;
    assign intra_15_2 = - feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] + feature_array[30] - feature_array[31] + feature_array[32] + feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] - feature_array[38] - feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] - feature_array[43] - feature_array[44] - feature_array[45] - feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] + feature_array[50] - feature_array[51] - feature_array[52] + feature_array[53] - feature_array[54] + feature_array[55] - feature_array[56] - feature_array[57] + feature_array[58] - feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] + feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] - feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] - feature_array[89] + feature_array[90] - feature_array[91] - feature_array[92] + feature_array[93] + feature_array[94] + feature_array[95] - feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] + feature_array[102] - feature_array[103] + feature_array[104] - feature_array[105] + feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] + feature_array[110] + feature_array[111] - feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] + intra_15_1;

    wire signed [8:0] intra_15_3;
    assign intra_15_3 = + feature_array[117] + feature_array[118] + feature_array[119] + feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] - feature_array[125] - feature_array[126] - feature_array[127] + intra_15_2;
    assign hidden[15] = intra_15_3 >= 0;

    wire signed [4:0] intra_16_0;
    assign intra_16_0 = - feature_array[0] - feature_array[1] + feature_array[2] - feature_array[3] + feature_array[4];

    wire signed [5:0] intra_16_1;
    assign intra_16_1 = + feature_array[5] + feature_array[6] - feature_array[7] + intra_16_0;

    wire signed [6:0] intra_16_2;
    assign intra_16_2 = - feature_array[8] + feature_array[9] - feature_array[10] + feature_array[11] + feature_array[12] + feature_array[13] + intra_16_1;

    wire signed [7:0] intra_16_3;
    assign intra_16_3 = + feature_array[14] + feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] - feature_array[20] - feature_array[21] + feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] + feature_array[29] - feature_array[30] + feature_array[31] - feature_array[32] - feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] - feature_array[37] + feature_array[38] + feature_array[39] - feature_array[40] + feature_array[41] + feature_array[42] - feature_array[43] - feature_array[44] - feature_array[45] + feature_array[46] + feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] + feature_array[53] + feature_array[54] - feature_array[55] + feature_array[56] - feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] - feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] - feature_array[69] + feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] - feature_array[79] - feature_array[80] - feature_array[81] + feature_array[82] - feature_array[83] + feature_array[84] - feature_array[85] + feature_array[86] + feature_array[87] + feature_array[88] - feature_array[89] + feature_array[90] + feature_array[91] + feature_array[92] - feature_array[93] - feature_array[94] + feature_array[95] + feature_array[96] + feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] + feature_array[101] - feature_array[102] - feature_array[103] - feature_array[104] + feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] + intra_16_2;

    wire signed [8:0] intra_16_4;
    assign intra_16_4 = - feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] - feature_array[117] + feature_array[118] + feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_16_3;
    assign hidden[16] = intra_16_4 >= 0;

    wire signed [4:0] intra_17_0;
    assign intra_17_0 = + feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3];

    wire signed [5:0] intra_17_1;
    assign intra_17_1 = - feature_array[4] + intra_17_0;

    wire signed [6:0] intra_17_2;
    assign intra_17_2 = - feature_array[5] - feature_array[6] - feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] + feature_array[11] - feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] + feature_array[16] - feature_array[17] + feature_array[18] - feature_array[19] - feature_array[20] - feature_array[21] + feature_array[22] - feature_array[23] + feature_array[24] - feature_array[25] + feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] + feature_array[32] - feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] + feature_array[42] + intra_17_1;

    wire signed [7:0] intra_17_3;
    assign intra_17_3 = - feature_array[43] - feature_array[44] - feature_array[45] - feature_array[46] + feature_array[47] + feature_array[48] - feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] + feature_array[53] - feature_array[54] - feature_array[55] + feature_array[56] + feature_array[57] + feature_array[58] - feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] - feature_array[63] - feature_array[64] + feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] - feature_array[72] + feature_array[73] - feature_array[74] + feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] - feature_array[85] + feature_array[86] - feature_array[87] - feature_array[88] - feature_array[89] - feature_array[90] - feature_array[91] + feature_array[92] - feature_array[93] + feature_array[94] + feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] + feature_array[99] - feature_array[100] + feature_array[101] + feature_array[102] + feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] + feature_array[107] - feature_array[108] + feature_array[109] + feature_array[110] - feature_array[111] - feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] - feature_array[117] - feature_array[118] - feature_array[119] + feature_array[120] - feature_array[121] + feature_array[122] - feature_array[123] - feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_17_2;
    assign hidden[17] = intra_17_3 >= 0;

    wire signed [4:0] intra_18_0;
    assign intra_18_0 = - feature_array[0] - feature_array[1] + feature_array[2] + feature_array[3];

    wire signed [5:0] intra_18_1;
    assign intra_18_1 = + feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] + feature_array[11] - feature_array[12] + feature_array[13] - feature_array[14] - feature_array[15] - feature_array[16] + feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] - feature_array[21] + feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] + intra_18_0;

    wire signed [6:0] intra_18_2;
    assign intra_18_2 = - feature_array[32] - feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] - feature_array[37] + feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] + feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] + intra_18_1;

    wire signed [7:0] intra_18_3;
    assign intra_18_3 = + feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] + feature_array[55] + feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] - feature_array[63] - feature_array[64] + feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] + feature_array[78] + feature_array[79] - feature_array[80] + feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] + feature_array[92] - feature_array[93] - feature_array[94] - feature_array[95] - feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] - feature_array[100] - feature_array[101] + feature_array[102] + feature_array[103] - feature_array[104] + feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] + feature_array[109] + feature_array[110] - feature_array[111] - feature_array[112] + feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] - feature_array[117] - feature_array[118] - feature_array[119] + feature_array[120] + feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] - feature_array[125] - feature_array[126] - feature_array[127] + intra_18_2;
    assign hidden[18] = intra_18_3 >= 0;

    wire signed [4:0] intra_19_0;
    assign intra_19_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_19_1;
    assign intra_19_1 = - feature_array[2] + intra_19_0;

    wire signed [6:0] intra_19_2;
    assign intra_19_2 = - feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] + feature_array[12] + feature_array[13] - feature_array[14] + feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] + feature_array[24] + feature_array[25] + feature_array[26] + intra_19_1;

    wire signed [7:0] intra_19_3;
    assign intra_19_3 = + feature_array[27] + feature_array[28] + feature_array[29] + feature_array[30] - feature_array[31] - feature_array[32] - feature_array[33] - feature_array[34] + feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] - feature_array[39] + feature_array[40] + feature_array[41] - feature_array[42] + feature_array[43] + feature_array[44] + feature_array[45] - feature_array[46] - feature_array[47] + feature_array[48] - feature_array[49] - feature_array[50] + feature_array[51] - feature_array[52] + feature_array[53] + feature_array[54] - feature_array[55] - feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] - feature_array[60] - feature_array[61] - feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] - feature_array[69] + feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] + feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] + feature_array[78] + feature_array[79] + feature_array[80] + feature_array[81] - feature_array[82] + feature_array[83] + intra_19_2;

    wire signed [8:0] intra_19_4;
    assign intra_19_4 = + feature_array[84] + feature_array[85] + feature_array[86] - feature_array[87] + feature_array[88] + feature_array[89] - feature_array[90] + feature_array[91] - feature_array[92] - feature_array[93] + feature_array[94] + feature_array[95] - feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] - feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] + feature_array[108] + feature_array[109] + feature_array[110] - feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] - feature_array[117] + feature_array[118] + feature_array[119] - feature_array[120] + feature_array[121] - feature_array[122] + feature_array[123] - feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_19_3;
    assign hidden[19] = intra_19_4 >= 0;

    wire signed [4:0] intra_20_0;
    assign intra_20_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_20_1;
    assign intra_20_1 = - feature_array[2] + intra_20_0;

    wire signed [6:0] intra_20_2;
    assign intra_20_2 = - feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] - feature_array[8] - feature_array[9] + intra_20_1;

    wire signed [7:0] intra_20_3;
    assign intra_20_3 = - feature_array[10] - feature_array[11] - feature_array[12] + feature_array[13] - feature_array[14] - feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] - feature_array[20] - feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] + feature_array[28] - feature_array[29] - feature_array[30] + feature_array[31] + feature_array[32] - feature_array[33] - feature_array[34] + feature_array[35] - feature_array[36] - feature_array[37] + feature_array[38] - feature_array[39] + feature_array[40] - feature_array[41] - feature_array[42] + feature_array[43] - feature_array[44] - feature_array[45] + feature_array[46] + feature_array[47] - feature_array[48] + feature_array[49] + feature_array[50] + feature_array[51] + feature_array[52] + feature_array[53] + feature_array[54] + feature_array[55] - feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] + feature_array[61] - feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] - feature_array[69] - feature_array[70] + intra_20_2;

    wire signed [8:0] intra_20_4;
    assign intra_20_4 = - feature_array[71] - feature_array[72] + feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] + feature_array[78] + feature_array[79] - feature_array[80] + feature_array[81] - feature_array[82] + feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] + feature_array[92] + feature_array[93] + feature_array[94] - feature_array[95] - feature_array[96] + feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] + feature_array[101] - feature_array[102] - feature_array[103] - feature_array[104] + feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] + feature_array[110] - feature_array[111] - feature_array[112] + feature_array[113] - feature_array[114] + feature_array[115] + feature_array[116] - feature_array[117] + feature_array[118] - feature_array[119] - feature_array[120] + feature_array[121] - feature_array[122] + feature_array[123] + feature_array[124] + feature_array[125] - feature_array[126] - feature_array[127] + intra_20_3;
    assign hidden[20] = intra_20_4 >= 0;

    wire signed [4:0] intra_21_0;
    assign intra_21_0 = + feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3];

    wire signed [5:0] intra_21_1;
    assign intra_21_1 = - feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] + intra_21_0;

    wire signed [6:0] intra_21_2;
    assign intra_21_2 = - feature_array[8] - feature_array[9] - feature_array[10] + feature_array[11] - feature_array[12] - feature_array[13] - feature_array[14] - feature_array[15] - feature_array[16] + feature_array[17] + feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] + feature_array[22] - feature_array[23] + feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] - feature_array[29] - feature_array[30] - feature_array[31] + feature_array[32] + feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] + feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] - feature_array[52] - feature_array[53] - feature_array[54] + feature_array[55] + feature_array[56] - feature_array[57] - feature_array[58] + feature_array[59] - feature_array[60] + feature_array[61] - feature_array[62] + feature_array[63] - feature_array[64] + feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] + intra_21_1;

    wire signed [7:0] intra_21_3;
    assign intra_21_3 = - feature_array[72] + feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] + feature_array[78] - feature_array[79] - feature_array[80] - feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] + feature_array[87] - feature_array[88] + feature_array[89] + feature_array[90] - feature_array[91] + feature_array[92] - feature_array[93] - feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] + feature_array[99] - feature_array[100] + feature_array[101] + feature_array[102] + intra_21_2;

    wire signed [8:0] intra_21_4;
    assign intra_21_4 = - feature_array[103] - feature_array[104] + feature_array[105] + feature_array[106] - feature_array[107] - feature_array[108] + feature_array[109] - feature_array[110] - feature_array[111] - feature_array[112] + feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] - feature_array[126] - feature_array[127] + intra_21_3;
    assign hidden[21] = intra_21_4 >= 0;

    wire signed [4:0] intra_22_0;
    assign intra_22_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_22_1;
    assign intra_22_1 = - feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] - feature_array[9] - feature_array[10] + feature_array[11] + feature_array[12] + feature_array[13] + feature_array[14] - feature_array[15] + feature_array[16] - feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] + feature_array[21] + feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] - feature_array[26] - feature_array[27] - feature_array[28] - feature_array[29] + feature_array[30] - feature_array[31] - feature_array[32] + intra_22_0;

    wire signed [6:0] intra_22_2;
    assign intra_22_2 = + feature_array[33] + feature_array[34] + feature_array[35] + feature_array[36] - feature_array[37] + feature_array[38] + feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] + feature_array[43] - feature_array[44] + feature_array[45] + feature_array[46] - feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] + feature_array[52] + feature_array[53] + feature_array[54] - feature_array[55] + feature_array[56] - feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] - feature_array[61] - feature_array[62] + feature_array[63] + feature_array[64] + feature_array[65] - feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] - feature_array[70] + feature_array[71] - feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] - feature_array[80] + feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] + feature_array[92] + feature_array[93] - feature_array[94] + feature_array[95] - feature_array[96] + feature_array[97] - feature_array[98] + feature_array[99] - feature_array[100] + feature_array[101] - feature_array[102] + feature_array[103] - feature_array[104] + feature_array[105] - feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] - feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] - feature_array[117] - feature_array[118] + feature_array[119] - feature_array[120] - feature_array[121] + feature_array[122] - feature_array[123] + feature_array[124] + feature_array[125] - feature_array[126] + intra_22_1;

    wire signed [7:0] intra_22_3;
    assign intra_22_3 = + feature_array[127] + intra_22_2;
    assign hidden[22] = intra_22_3 >= 0;

    wire signed [4:0] intra_23_0;
    assign intra_23_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_23_1;
    assign intra_23_1 = + feature_array[2] + intra_23_0;

    wire signed [6:0] intra_23_2;
    assign intra_23_2 = + feature_array[3] - feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] - feature_array[11] + feature_array[12] + feature_array[13] + feature_array[14] - feature_array[15] + feature_array[16] - feature_array[17] - feature_array[18] - feature_array[19] - feature_array[20] - feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] - feature_array[29] - feature_array[30] + feature_array[31] + feature_array[32] + feature_array[33] + feature_array[34] + feature_array[35] - feature_array[36] - feature_array[37] + feature_array[38] + feature_array[39] + feature_array[40] - feature_array[41] + feature_array[42] + feature_array[43] - feature_array[44] - feature_array[45] + feature_array[46] + intra_23_1;

    wire signed [7:0] intra_23_3;
    assign intra_23_3 = + feature_array[47] + feature_array[48] - feature_array[49] - feature_array[50] - feature_array[51] + feature_array[52] - feature_array[53] + feature_array[54] + feature_array[55] + feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] + feature_array[62] + intra_23_2;

    wire signed [8:0] intra_23_4;
    assign intra_23_4 = + feature_array[63] + feature_array[64] - feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] - feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] - feature_array[82] + feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] - feature_array[87] + feature_array[88] - feature_array[89] - feature_array[90] + feature_array[91] - feature_array[92] + feature_array[93] - feature_array[94] - feature_array[95] - feature_array[96] - feature_array[97] - feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] + feature_array[103] + feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] - feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] + feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] + feature_array[119] + feature_array[120] - feature_array[121] + feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] - feature_array[127] + intra_23_3;
    assign hidden[23] = intra_23_4 >= 0;

    wire signed [4:0] intra_24_0;
    assign intra_24_0 = - feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [5:0] intra_24_1;
    assign intra_24_1 = + feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] - feature_array[12] + feature_array[13] - feature_array[14] + feature_array[15] + feature_array[16] + feature_array[17] + intra_24_0;

    wire signed [6:0] intra_24_2;
    assign intra_24_2 = + feature_array[18] + feature_array[19] + feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] - feature_array[26] + feature_array[27] - feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] + feature_array[32] + feature_array[33] - feature_array[34] + feature_array[35] - feature_array[36] - feature_array[37] + feature_array[38] + feature_array[39] - feature_array[40] - feature_array[41] - feature_array[42] + feature_array[43] - feature_array[44] + feature_array[45] + feature_array[46] - feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] + feature_array[52] - feature_array[53] - feature_array[54] - feature_array[55] - feature_array[56] - feature_array[57] - feature_array[58] + feature_array[59] + feature_array[60] + feature_array[61] + feature_array[62] - feature_array[63] + feature_array[64] - feature_array[65] + intra_24_1;

    wire signed [7:0] intra_24_3;
    assign intra_24_3 = - feature_array[66] - feature_array[67] - feature_array[68] - feature_array[69] - feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] - feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] + feature_array[78] + feature_array[79] - feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] + feature_array[84] - feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] - feature_array[89] - feature_array[90] + feature_array[91] + feature_array[92] - feature_array[93] + feature_array[94] + feature_array[95] - feature_array[96] - feature_array[97] - feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] - feature_array[103] - feature_array[104] + feature_array[105] - feature_array[106] - feature_array[107] + feature_array[108] + feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] - feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] + feature_array[121] + feature_array[122] + intra_24_2;

    wire signed [8:0] intra_24_4;
    assign intra_24_4 = + feature_array[123] + feature_array[124] + feature_array[125] - feature_array[126] - feature_array[127] + intra_24_3;
    assign hidden[24] = intra_24_4 >= 0;

    wire signed [5:0] intra_25_0;
    assign intra_25_0 = + feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [6:0] intra_25_1;
    assign intra_25_1 = + feature_array[3] + feature_array[4] + feature_array[5] - feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + feature_array[11] - feature_array[12] + feature_array[13] - feature_array[14] + feature_array[15] - feature_array[16] - feature_array[17] - feature_array[18] - feature_array[19] + feature_array[20] - feature_array[21] + feature_array[22] - feature_array[23] - feature_array[24] - feature_array[25] - feature_array[26] + feature_array[27] - feature_array[28] + feature_array[29] + feature_array[30] - feature_array[31] - feature_array[32] + feature_array[33] + feature_array[34] - feature_array[35] + feature_array[36] - feature_array[37] + intra_25_0;

    wire signed [7:0] intra_25_2;
    assign intra_25_2 = - feature_array[38] - feature_array[39] - feature_array[40] + feature_array[41] + feature_array[42] - feature_array[43] + feature_array[44] - feature_array[45] + feature_array[46] - feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] - feature_array[55] - feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] + feature_array[62] + feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] - feature_array[68] - feature_array[69] + feature_array[70] + feature_array[71] - feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] + intra_25_1;

    wire signed [8:0] intra_25_3;
    assign intra_25_3 = - feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] - feature_array[89] - feature_array[90] - feature_array[91] + feature_array[92] + feature_array[93] + feature_array[94] - feature_array[95] - feature_array[96] + feature_array[97] - feature_array[98] + feature_array[99] - feature_array[100] + feature_array[101] - feature_array[102] - feature_array[103] - feature_array[104] + feature_array[105] - feature_array[106] + feature_array[107] - feature_array[108] + feature_array[109] + feature_array[110] + feature_array[111] - feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] + feature_array[118] - feature_array[119] + feature_array[120] - feature_array[121] + intra_25_2;

    wire signed [9:0] intra_25_4;
    assign intra_25_4 = - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] + feature_array[126] - feature_array[127] + intra_25_3;
    assign hidden[25] = intra_25_4 >= 0;

    wire signed [5:0] intra_26_0;
    assign intra_26_0 = + feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [6:0] intra_26_1;
    assign intra_26_1 = + feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] - feature_array[8] - feature_array[9] + feature_array[10] + feature_array[11] - feature_array[12] - feature_array[13] - feature_array[14] + feature_array[15] - feature_array[16] - feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] - feature_array[25] - feature_array[26] + feature_array[27] + feature_array[28] - feature_array[29] - feature_array[30] - feature_array[31] - feature_array[32] + feature_array[33] + feature_array[34] + feature_array[35] - feature_array[36] + feature_array[37] + feature_array[38] - feature_array[39] - feature_array[40] - feature_array[41] + feature_array[42] + feature_array[43] - feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] + feature_array[55] - feature_array[56] - feature_array[57] + feature_array[58] - feature_array[59] + feature_array[60] - feature_array[61] + intra_26_0;

    wire signed [7:0] intra_26_2;
    assign intra_26_2 = + feature_array[62] + feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] - feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] - feature_array[86] - feature_array[87] - feature_array[88] - feature_array[89] - feature_array[90] + feature_array[91] + feature_array[92] - feature_array[93] + feature_array[94] + feature_array[95] - feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] + feature_array[109] - feature_array[110] - feature_array[111] - feature_array[112] - feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] + feature_array[117] + feature_array[118] - feature_array[119] - feature_array[120] - feature_array[121] + feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] + feature_array[127] + intra_26_1;
    assign hidden[26] = intra_26_2 >= 0;

    wire signed [5:0] intra_27_0;
    assign intra_27_0 = + feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [6:0] intra_27_1;
    assign intra_27_1 = + feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] + intra_27_0;

    wire signed [7:0] intra_27_2;
    assign intra_27_2 = + feature_array[8] + feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] + feature_array[13] + feature_array[14] + feature_array[15] - feature_array[16] + feature_array[17] - feature_array[18] + feature_array[19] - feature_array[20] - feature_array[21] + feature_array[22] + intra_27_1;

    wire signed [8:0] intra_27_3;
    assign intra_27_3 = + feature_array[23] + feature_array[24] + feature_array[25] - feature_array[26] + feature_array[27] + feature_array[28] + feature_array[29] + feature_array[30] + feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] + feature_array[35] - feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] - feature_array[43] - feature_array[44] + feature_array[45] - feature_array[46] - feature_array[47] - feature_array[48] + feature_array[49] + feature_array[50] + feature_array[51] + feature_array[52] + feature_array[53] - feature_array[54] - feature_array[55] + feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] + feature_array[61] + feature_array[62] - feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] - feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] - feature_array[77] - feature_array[78] - feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] - feature_array[87] + feature_array[88] + feature_array[89] - feature_array[90] + feature_array[91] + feature_array[92] - feature_array[93] - feature_array[94] + feature_array[95] - feature_array[96] - feature_array[97] - feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] + feature_array[102] - feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] + feature_array[107] - feature_array[108] - feature_array[109] - feature_array[110] - feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] - feature_array[117] + feature_array[118] + feature_array[119] + feature_array[120] + feature_array[121] + intra_27_2;

    wire signed [9:0] intra_27_4;
    assign intra_27_4 = + feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] + feature_array[127] + intra_27_3;
    assign hidden[27] = intra_27_4 >= 0;

    wire signed [4:0] intra_28_0;
    assign intra_28_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_28_1;
    assign intra_28_1 = - feature_array[2] - feature_array[3] + feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] - feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] + feature_array[15] + feature_array[16] - feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] - feature_array[21] - feature_array[22] + feature_array[23] + feature_array[24] + feature_array[25] + feature_array[26] - feature_array[27] - feature_array[28] - feature_array[29] - feature_array[30] + feature_array[31] + intra_28_0;

    wire signed [6:0] intra_28_2;
    assign intra_28_2 = + feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] - feature_array[36] + feature_array[37] + feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] - feature_array[45] - feature_array[46] - feature_array[47] - feature_array[48] - feature_array[49] - feature_array[50] + intra_28_1;

    wire signed [7:0] intra_28_3;
    assign intra_28_3 = - feature_array[51] - feature_array[52] - feature_array[53] - feature_array[54] + feature_array[55] + feature_array[56] - feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] + feature_array[66] - feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] + feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] - feature_array[86] - feature_array[87] - feature_array[88] + feature_array[89] - feature_array[90] - feature_array[91] - feature_array[92] - feature_array[93] + feature_array[94] + feature_array[95] - feature_array[96] + feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] + feature_array[101] + feature_array[102] - feature_array[103] + feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] + intra_28_2;

    wire signed [8:0] intra_28_4;
    assign intra_28_4 = - feature_array[109] - feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] + feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] + feature_array[126] - feature_array[127] + intra_28_3;
    assign hidden[28] = intra_28_4 >= 0;

    wire signed [5:0] intra_29_0;
    assign intra_29_0 = + feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [6:0] intra_29_1;
    assign intra_29_1 = + feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] + feature_array[7] + intra_29_0;

    wire signed [7:0] intra_29_2;
    assign intra_29_2 = + feature_array[8] - feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] - feature_array[14] + feature_array[15] + feature_array[16] - feature_array[17] - feature_array[18] - feature_array[19] + feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] + feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] - feature_array[32] - feature_array[33] + feature_array[34] + feature_array[35] - feature_array[36] - feature_array[37] + feature_array[38] - feature_array[39] + feature_array[40] + feature_array[41] + feature_array[42] + feature_array[43] - feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] + feature_array[52] + feature_array[53] - feature_array[54] - feature_array[55] + feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] - feature_array[63] + feature_array[64] + feature_array[65] + intra_29_1;

    wire signed [8:0] intra_29_3;
    assign intra_29_3 = + feature_array[66] + feature_array[67] + feature_array[68] - feature_array[69] + feature_array[70] - feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] - feature_array[87] - feature_array[88] - feature_array[89] - feature_array[90] - feature_array[91] - feature_array[92] + feature_array[93] - feature_array[94] - feature_array[95] + feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] + feature_array[102] - feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] - feature_array[110] - feature_array[111] - feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] + feature_array[118] + feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] + feature_array[126] - feature_array[127] + intra_29_2;
    assign hidden[29] = intra_29_3 >= 0;

    wire signed [4:0] intra_30_0;
    assign intra_30_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_30_1;
    assign intra_30_1 = - feature_array[2] + intra_30_0;

    wire signed [6:0] intra_30_2;
    assign intra_30_2 = - feature_array[3] - feature_array[4] + feature_array[5] + feature_array[6] - feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] + feature_array[12] - feature_array[13] - feature_array[14] + feature_array[15] + feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] - feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] + intra_30_1;

    wire signed [7:0] intra_30_3;
    assign intra_30_3 = + feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] + feature_array[29] + feature_array[30] + feature_array[31] + feature_array[32] - feature_array[33] + feature_array[34] - feature_array[35] - feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] + feature_array[40] - feature_array[41] + feature_array[42] - feature_array[43] + feature_array[44] - feature_array[45] - feature_array[46] - feature_array[47] - feature_array[48] + feature_array[49] + feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] - feature_array[54] - feature_array[55] - feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] - feature_array[70] + intra_30_2;

    wire signed [8:0] intra_30_4;
    assign intra_30_4 = - feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] + feature_array[77] + feature_array[78] - feature_array[79] - feature_array[80] - feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] - feature_array[85] + feature_array[86] - feature_array[87] - feature_array[88] + feature_array[89] - feature_array[90] - feature_array[91] - feature_array[92] - feature_array[93] + feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] - feature_array[102] - feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] + feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] - feature_array[126] + feature_array[127] + intra_30_3;
    assign hidden[30] = intra_30_4 >= 0;

    wire signed [5:0] intra_31_0;
    assign intra_31_0 = + feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [6:0] intra_31_1;
    assign intra_31_1 = + feature_array[3] + feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] + feature_array[8] + feature_array[9] + intra_31_0;

    wire signed [7:0] intra_31_2;
    assign intra_31_2 = + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] - feature_array[14] + feature_array[15] + feature_array[16] - feature_array[17] - feature_array[18] + feature_array[19] + feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] + feature_array[30] + feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] + feature_array[35] + feature_array[36] - feature_array[37] + feature_array[38] + feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] + feature_array[43] - feature_array[44] - feature_array[45] - feature_array[46] - feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] + feature_array[51] + feature_array[52] + feature_array[53] + feature_array[54] + feature_array[55] + feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] + feature_array[60] + feature_array[61] - feature_array[62] - feature_array[63] + intra_31_1;

    wire signed [8:0] intra_31_3;
    assign intra_31_3 = + feature_array[64] - feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] + feature_array[78] + feature_array[79] - feature_array[80] - feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] - feature_array[85] + feature_array[86] + intra_31_2;

    wire signed [9:0] intra_31_4;
    assign intra_31_4 = + feature_array[87] + feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] - feature_array[92] + feature_array[93] - feature_array[94] - feature_array[95] + feature_array[96] - feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] + feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] - feature_array[113] + feature_array[114] + feature_array[115] - feature_array[116] + feature_array[117] + feature_array[118] - feature_array[119] - feature_array[120] + feature_array[121] - feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] + feature_array[126] + feature_array[127] + intra_31_3;
    assign hidden[31] = intra_31_4 >= 0;

    wire signed [4:0] intra_32_0;
    assign intra_32_0 = - feature_array[0] + feature_array[1] + feature_array[2] - feature_array[3];

    wire signed [5:0] intra_32_1;
    assign intra_32_1 = - feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] + intra_32_0;

    wire signed [6:0] intra_32_2;
    assign intra_32_2 = + feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] - feature_array[14] - feature_array[15] + feature_array[16] - feature_array[17] + feature_array[18] + feature_array[19] - feature_array[20] - feature_array[21] + feature_array[22] + feature_array[23] + feature_array[24] - feature_array[25] + feature_array[26] - feature_array[27] - feature_array[28] - feature_array[29] + feature_array[30] - feature_array[31] + intra_32_1;

    wire signed [7:0] intra_32_3;
    assign intra_32_3 = + feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] + feature_array[39] + feature_array[40] - feature_array[41] - feature_array[42] - feature_array[43] - feature_array[44] - feature_array[45] - feature_array[46] - feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] - feature_array[54] - feature_array[55] + feature_array[56] - feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] - feature_array[62] + feature_array[63] + feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] + feature_array[76] + feature_array[77] + feature_array[78] + feature_array[79] + feature_array[80] - feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] - feature_array[85] - feature_array[86] + feature_array[87] + feature_array[88] - feature_array[89] - feature_array[90] - feature_array[91] - feature_array[92] - feature_array[93] + feature_array[94] + feature_array[95] + feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] + feature_array[102] - feature_array[103] + feature_array[104] - feature_array[105] + feature_array[106] - feature_array[107] - feature_array[108] + feature_array[109] + feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] + feature_array[114] - feature_array[115] - feature_array[116] - feature_array[117] + feature_array[118] - feature_array[119] + feature_array[120] - feature_array[121] - feature_array[122] + intra_32_2;

    wire signed [8:0] intra_32_4;
    assign intra_32_4 = - feature_array[123] - feature_array[124] + feature_array[125] - feature_array[126] - feature_array[127] + intra_32_3;
    assign hidden[32] = intra_32_4 >= 0;

    wire signed [4:0] intra_33_0;
    assign intra_33_0 = - feature_array[0] + feature_array[1] + feature_array[2];

    wire signed [5:0] intra_33_1;
    assign intra_33_1 = + feature_array[3] + feature_array[4] + intra_33_0;

    wire signed [6:0] intra_33_2;
    assign intra_33_2 = + feature_array[5] + feature_array[6] + intra_33_1;

    wire signed [7:0] intra_33_3;
    assign intra_33_3 = + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] - feature_array[16] + feature_array[17] - feature_array[18] + feature_array[19] - feature_array[20] + feature_array[21] + feature_array[22] + feature_array[23] + feature_array[24] - feature_array[25] - feature_array[26] - feature_array[27] - feature_array[28] + feature_array[29] - feature_array[30] + feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] - feature_array[38] - feature_array[39] - feature_array[40] - feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] - feature_array[48] - feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] - feature_array[54] + feature_array[55] - feature_array[56] + feature_array[57] + feature_array[58] - feature_array[59] - feature_array[60] + feature_array[61] - feature_array[62] + feature_array[63] + feature_array[64] + feature_array[65] - feature_array[66] + feature_array[67] + feature_array[68] - feature_array[69] - feature_array[70] + feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] + feature_array[78] - feature_array[79] + feature_array[80] + feature_array[81] - feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] + feature_array[86] - feature_array[87] + feature_array[88] + feature_array[89] - feature_array[90] - feature_array[91] + feature_array[92] + feature_array[93] - feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] + feature_array[102] - feature_array[103] + feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] + feature_array[109] - feature_array[110] + feature_array[111] + intra_33_2;

    wire signed [8:0] intra_33_4;
    assign intra_33_4 = - feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] - feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] + feature_array[121] - feature_array[122] - feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] + feature_array[127] + intra_33_3;
    assign hidden[33] = intra_33_4 >= 0;

    wire signed [4:0] intra_34_0;
    assign intra_34_0 = - feature_array[0] - feature_array[1];

    wire signed [5:0] intra_34_1;
    assign intra_34_1 = - feature_array[2] + intra_34_0;

    wire signed [6:0] intra_34_2;
    assign intra_34_2 = - feature_array[3] - feature_array[4] + feature_array[5] + feature_array[6] - feature_array[7] + intra_34_1;

    wire signed [7:0] intra_34_3;
    assign intra_34_3 = - feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] - feature_array[12] - feature_array[13] + feature_array[14] + feature_array[15] - feature_array[16] - feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] - feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] - feature_array[26] + feature_array[27] + feature_array[28] - feature_array[29] - feature_array[30] + feature_array[31] - feature_array[32] - feature_array[33] + feature_array[34] + feature_array[35] - feature_array[36] + feature_array[37] + feature_array[38] - feature_array[39] + feature_array[40] + feature_array[41] + feature_array[42] + feature_array[43] + feature_array[44] - feature_array[45] - feature_array[46] + feature_array[47] - feature_array[48] + feature_array[49] + feature_array[50] + feature_array[51] + feature_array[52] - feature_array[53] + feature_array[54] - feature_array[55] + intra_34_2;

    wire signed [8:0] intra_34_4;
    assign intra_34_4 = - feature_array[56] + feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] + feature_array[63] - feature_array[64] + feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] - feature_array[69] + feature_array[70] + feature_array[71] - feature_array[72] + feature_array[73] - feature_array[74] + feature_array[75] - feature_array[76] + feature_array[77] + feature_array[78] - feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] + feature_array[83] + feature_array[84] + feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] - feature_array[89] + feature_array[90] - feature_array[91] + feature_array[92] + feature_array[93] + feature_array[94] + feature_array[95] - feature_array[96] + feature_array[97] - feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] + feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] + feature_array[110] - feature_array[111] - feature_array[112] - feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] - feature_array[117] - feature_array[118] + feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] + feature_array[127] + intra_34_3;
    assign hidden[34] = intra_34_4 >= 0;

    wire signed [4:0] intra_35_0;
    assign intra_35_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_35_1;
    assign intra_35_1 = + feature_array[2] - feature_array[3] - feature_array[4] + feature_array[5] - feature_array[6] + feature_array[7] + intra_35_0;

    wire signed [6:0] intra_35_2;
    assign intra_35_2 = + feature_array[8] + feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] - feature_array[13] + feature_array[14] - feature_array[15] + feature_array[16] + feature_array[17] - feature_array[18] - feature_array[19] - feature_array[20] - feature_array[21] + intra_35_1;

    wire signed [7:0] intra_35_3;
    assign intra_35_3 = + feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] + feature_array[26] - feature_array[27] + feature_array[28] - feature_array[29] - feature_array[30] + feature_array[31] + feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] + feature_array[39] - feature_array[40] - feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] - feature_array[53] + feature_array[54] + feature_array[55] - feature_array[56] - feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] - feature_array[61] - feature_array[62] - feature_array[63] + intra_35_2;

    wire signed [8:0] intra_35_4;
    assign intra_35_4 = + feature_array[64] - feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] - feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] + feature_array[77] + feature_array[78] + feature_array[79] - feature_array[80] + feature_array[81] + feature_array[82] - feature_array[83] + feature_array[84] - feature_array[85] - feature_array[86] - feature_array[87] - feature_array[88] - feature_array[89] + feature_array[90] - feature_array[91] - feature_array[92] - feature_array[93] - feature_array[94] - feature_array[95] + feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] - feature_array[100] - feature_array[101] + feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] - feature_array[108] - feature_array[109] - feature_array[110] - feature_array[111] + feature_array[112] - feature_array[113] - feature_array[114] - feature_array[115] - feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] + feature_array[121] + feature_array[122] - feature_array[123] - feature_array[124] + feature_array[125] + feature_array[126] - feature_array[127] + intra_35_3;
    assign hidden[35] = intra_35_4 >= 0;

    wire signed [4:0] intra_36_0;
    assign intra_36_0 = + feature_array[0] - feature_array[1] - feature_array[2] - feature_array[3] + feature_array[4];

    wire signed [5:0] intra_36_1;
    assign intra_36_1 = - feature_array[5] + intra_36_0;

    wire signed [6:0] intra_36_2;
    assign intra_36_2 = - feature_array[6] - feature_array[7] + feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] + feature_array[12] + feature_array[13] + feature_array[14] - feature_array[15] - feature_array[16] + intra_36_1;

    wire signed [7:0] intra_36_3;
    assign intra_36_3 = - feature_array[17] - feature_array[18] - feature_array[19] - feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] - feature_array[26] + feature_array[27] + feature_array[28] - feature_array[29] + feature_array[30] + feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] - feature_array[35] + feature_array[36] - feature_array[37] + feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] - feature_array[45] - feature_array[46] + intra_36_2;

    wire signed [8:0] intra_36_4;
    assign intra_36_4 = - feature_array[47] - feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] - feature_array[52] + feature_array[53] + feature_array[54] + feature_array[55] - feature_array[56] + feature_array[57] - feature_array[58] - feature_array[59] - feature_array[60] - feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] + feature_array[65] - feature_array[66] + feature_array[67] - feature_array[68] - feature_array[69] - feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] - feature_array[76] + feature_array[77] - feature_array[78] - feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] - feature_array[83] - feature_array[84] + feature_array[85] - feature_array[86] + feature_array[87] + feature_array[88] - feature_array[89] - feature_array[90] + feature_array[91] - feature_array[92] + feature_array[93] - feature_array[94] + feature_array[95] + feature_array[96] + feature_array[97] - feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] - feature_array[102] + feature_array[103] + feature_array[104] + feature_array[105] + feature_array[106] - feature_array[107] + feature_array[108] - feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] - feature_array[114] - feature_array[115] + feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] - feature_array[120] - feature_array[121] - feature_array[122] + feature_array[123] + feature_array[124] + feature_array[125] - feature_array[126] - feature_array[127] + intra_36_3;
    assign hidden[36] = intra_36_4 >= 0;

    wire signed [4:0] intra_37_0;
    assign intra_37_0 = + feature_array[0] - feature_array[1];

    wire signed [5:0] intra_37_1;
    assign intra_37_1 = + feature_array[2] + intra_37_0;

    wire signed [6:0] intra_37_2;
    assign intra_37_2 = + feature_array[3] + feature_array[4] - feature_array[5] - feature_array[6] + feature_array[7] + feature_array[8] + feature_array[9] + feature_array[10] + feature_array[11] + feature_array[12] + feature_array[13] - feature_array[14] - feature_array[15] - feature_array[16] - feature_array[17] - feature_array[18] + feature_array[19] + feature_array[20] - feature_array[21] + feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] - feature_array[26] + feature_array[27] - feature_array[28] + feature_array[29] - feature_array[30] + feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] + feature_array[35] - feature_array[36] - feature_array[37] + intra_37_1;

    wire signed [7:0] intra_37_3;
    assign intra_37_3 = - feature_array[38] - feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] - feature_array[43] + feature_array[44] + feature_array[45] + feature_array[46] + feature_array[47] + feature_array[48] + feature_array[49] - feature_array[50] - feature_array[51] + feature_array[52] - feature_array[53] + feature_array[54] - feature_array[55] - feature_array[56] - feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] - feature_array[62] - feature_array[63] + feature_array[64] + feature_array[65] + feature_array[66] + feature_array[67] + feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + intra_37_2;

    wire signed [8:0] intra_37_4;
    assign intra_37_4 = + feature_array[76] + feature_array[77] - feature_array[78] + feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] + feature_array[84] + feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] - feature_array[92] + feature_array[93] + feature_array[94] - feature_array[95] - feature_array[96] - feature_array[97] - feature_array[98] - feature_array[99] + feature_array[100] + feature_array[101] - feature_array[102] + feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] + feature_array[107] + feature_array[108] + feature_array[109] - feature_array[110] - feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] + feature_array[115] + feature_array[116] - feature_array[117] + feature_array[118] + feature_array[119] + feature_array[120] + feature_array[121] + feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] - feature_array[126] - feature_array[127] + intra_37_3;
    assign hidden[37] = intra_37_4 >= 0;

    wire signed [4:0] intra_38_0;
    assign intra_38_0 = - feature_array[0] + feature_array[1];

    wire signed [5:0] intra_38_1;
    assign intra_38_1 = - feature_array[2] + intra_38_0;

    wire signed [6:0] intra_38_2;
    assign intra_38_2 = - feature_array[3] - feature_array[4] - feature_array[5] + feature_array[6] - feature_array[7] - feature_array[8] - feature_array[9] - feature_array[10] - feature_array[11] - feature_array[12] - feature_array[13] + feature_array[14] + feature_array[15] + feature_array[16] - feature_array[17] + feature_array[18] - feature_array[19] + feature_array[20] + feature_array[21] - feature_array[22] + feature_array[23] + feature_array[24] + feature_array[25] - feature_array[26] - feature_array[27] + feature_array[28] + feature_array[29] - feature_array[30] - feature_array[31] - feature_array[32] - feature_array[33] + feature_array[34] + feature_array[35] - feature_array[36] + feature_array[37] - feature_array[38] + feature_array[39] + feature_array[40] + feature_array[41] + feature_array[42] + feature_array[43] - feature_array[44] - feature_array[45] + intra_38_1;

    wire signed [7:0] intra_38_3;
    assign intra_38_3 = + feature_array[46] - feature_array[47] - feature_array[48] - feature_array[49] + feature_array[50] + feature_array[51] + feature_array[52] + feature_array[53] - feature_array[54] + feature_array[55] - feature_array[56] - feature_array[57] + feature_array[58] + feature_array[59] + feature_array[60] - feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] + feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] + feature_array[70] + feature_array[71] + feature_array[72] + feature_array[73] + feature_array[74] + feature_array[75] + feature_array[76] - feature_array[77] - feature_array[78] - feature_array[79] - feature_array[80] - feature_array[81] - feature_array[82] + feature_array[83] - feature_array[84] - feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] - feature_array[89] - feature_array[90] + feature_array[91] + feature_array[92] + feature_array[93] - feature_array[94] + feature_array[95] + feature_array[96] + feature_array[97] + feature_array[98] + feature_array[99] + feature_array[100] - feature_array[101] + feature_array[102] - feature_array[103] + intra_38_2;

    wire signed [8:0] intra_38_4;
    assign intra_38_4 = + feature_array[104] - feature_array[105] + feature_array[106] + feature_array[107] + feature_array[108] - feature_array[109] + feature_array[110] + feature_array[111] - feature_array[112] + feature_array[113] - feature_array[114] + feature_array[115] + feature_array[116] + feature_array[117] - feature_array[118] - feature_array[119] + feature_array[120] - feature_array[121] - feature_array[122] + feature_array[123] + feature_array[124] - feature_array[125] + feature_array[126] - feature_array[127] + intra_38_3;
    assign hidden[38] = intra_38_4 >= 0;

    wire signed [4:0] intra_39_0;
    assign intra_39_0 = - feature_array[0] - feature_array[1] + feature_array[2] - feature_array[3] + feature_array[4];

    wire signed [5:0] intra_39_1;
    assign intra_39_1 = - feature_array[5] + intra_39_0;

    wire signed [6:0] intra_39_2;
    assign intra_39_2 = - feature_array[6] - feature_array[7] - feature_array[8] + feature_array[9] - feature_array[10] - feature_array[11] - feature_array[12] + feature_array[13] + feature_array[14] + feature_array[15] - feature_array[16] + feature_array[17] + feature_array[18] + feature_array[19] - feature_array[20] - feature_array[21] - feature_array[22] + feature_array[23] - feature_array[24] + feature_array[25] + feature_array[26] + feature_array[27] - feature_array[28] + intra_39_1;

    wire signed [7:0] intra_39_3;
    assign intra_39_3 = - feature_array[29] - feature_array[30] - feature_array[31] - feature_array[32] + feature_array[33] - feature_array[34] + feature_array[35] + feature_array[36] + feature_array[37] + feature_array[38] - feature_array[39] - feature_array[40] + feature_array[41] - feature_array[42] + feature_array[43] + feature_array[44] - feature_array[45] - feature_array[46] - feature_array[47] + feature_array[48] - feature_array[49] + feature_array[50] + feature_array[51] + feature_array[52] + feature_array[53] + intra_39_2;

    wire signed [8:0] intra_39_4;
    assign intra_39_4 = - feature_array[54] - feature_array[55] - feature_array[56] - feature_array[57] - feature_array[58] + feature_array[59] - feature_array[60] + feature_array[61] + feature_array[62] - feature_array[63] - feature_array[64] - feature_array[65] - feature_array[66] - feature_array[67] - feature_array[68] + feature_array[69] - feature_array[70] - feature_array[71] - feature_array[72] - feature_array[73] - feature_array[74] - feature_array[75] - feature_array[76] - feature_array[77] + feature_array[78] + feature_array[79] + feature_array[80] + feature_array[81] + feature_array[82] + feature_array[83] + feature_array[84] + feature_array[85] + feature_array[86] + feature_array[87] - feature_array[88] + feature_array[89] + feature_array[90] + feature_array[91] + feature_array[92] + feature_array[93] + feature_array[94] - feature_array[95] + feature_array[96] + feature_array[97] - feature_array[98] - feature_array[99] + feature_array[100] + feature_array[101] + feature_array[102] - feature_array[103] - feature_array[104] - feature_array[105] - feature_array[106] - feature_array[107] + feature_array[108] - feature_array[109] + feature_array[110] + feature_array[111] + feature_array[112] + feature_array[113] + feature_array[114] + feature_array[115] - feature_array[116] - feature_array[117] + feature_array[118] + feature_array[119] + feature_array[120] + feature_array[121] + feature_array[122] + feature_array[123] + feature_array[124] + feature_array[125] + feature_array[126] - feature_array[127] + intra_39_3;
    assign hidden[39] = intra_39_4 >= 0;
assign scores[0*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden[1] + hidden_n[2] + hidden[3] + hidden[4] + hidden_n[5] + hidden[6] + hidden_n[7] + hidden_n[8] + hidden[9] + hidden_n[10] + hidden[11] + hidden_n[12] + hidden_n[13] + hidden[14] + hidden[15] + hidden_n[16] + hidden_n[17] + hidden_n[18] + hidden[19] + hidden[20] + hidden_n[21] + hidden[22] + hidden[23] + hidden_n[24] + hidden_n[25] + hidden[26] + hidden[27] + hidden_n[28] + hidden[29] + hidden_n[30] + hidden[31] + hidden_n[32] + hidden_n[33] + hidden[34] + hidden_n[35] + hidden[36] + hidden[37] + hidden[38] + hidden_n[39];
assign scores[1*SUM_BITS+:SUM_BITS] = + hidden_n[0] + hidden[1] + hidden[2] + hidden[3] + hidden_n[4] + hidden_n[5] + hidden_n[6] + hidden[7] + hidden[8] + hidden[9] + hidden[10] + hidden[11] + hidden[12] + hidden_n[13] + hidden[14] + hidden_n[15] + hidden[16] + hidden_n[17] + hidden[18] + hidden[19] + hidden[20] + hidden[21] + hidden[22] + hidden_n[23] + hidden_n[24] + hidden_n[25] + hidden_n[26] + hidden[27] + hidden_n[28] + hidden_n[29] + hidden_n[30] + hidden_n[31] + hidden_n[32] + hidden[33] + hidden[34] + hidden_n[35] + hidden[36] + hidden[37] + hidden_n[38] + hidden[39];
assign scores[2*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden[1] + hidden_n[2] + hidden[3] + hidden_n[4] + hidden[5] + hidden_n[6] + hidden[7] + hidden[8] + hidden[9] + hidden_n[10] + hidden[11] + hidden_n[12] + hidden_n[13] + hidden[14] + hidden_n[15] + hidden[16] + hidden[17] + hidden[18] + hidden[19] + hidden[20] + hidden[21] + hidden[22] + hidden_n[23] + hidden_n[24] + hidden_n[25] + hidden_n[26] + hidden_n[27] + hidden_n[28] + hidden[29] + hidden[30] + hidden_n[31] + hidden[32] + hidden[33] + hidden[34] + hidden_n[35] + hidden[36] + hidden_n[37] + hidden[38] + hidden[39];
assign scores[3*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden_n[1] + hidden[2] + hidden[3] + hidden[4] + hidden_n[5] + hidden[6] + hidden[7] + hidden_n[8] + hidden_n[9] + hidden_n[10] + hidden[11] + hidden[12] + hidden[13] + hidden[14] + hidden[15] + hidden_n[16] + hidden[17] + hidden[18] + hidden[19] + hidden_n[20] + hidden[21] + hidden[22] + hidden[23] + hidden_n[24] + hidden_n[25] + hidden_n[26] + hidden[27] + hidden_n[28] + hidden[29] + hidden_n[30] + hidden_n[31] + hidden_n[32] + hidden_n[33] + hidden[34] + hidden_n[35] + hidden[36] + hidden[37] + hidden_n[38] + hidden_n[39];
assign scores[4*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden_n[1] + hidden_n[2] + hidden[3] + hidden[4] + hidden[5] + hidden[6] + hidden[7] + hidden_n[8] + hidden[9] + hidden[10] + hidden_n[11] + hidden[12] + hidden_n[13] + hidden[14] + hidden[15] + hidden_n[16] + hidden_n[17] + hidden_n[18] + hidden[19] + hidden_n[20] + hidden_n[21] + hidden[22] + hidden[23] + hidden_n[24] + hidden_n[25] + hidden_n[26] + hidden[27] + hidden[28] + hidden[29] + hidden_n[30] + hidden[31] + hidden[32] + hidden[33] + hidden_n[34] + hidden[35] + hidden[36] + hidden[37] + hidden_n[38] + hidden_n[39];
assign scores[5*SUM_BITS+:SUM_BITS] = + hidden[0] + hidden_n[1] + hidden_n[2] + hidden[3] + hidden[4] + hidden_n[5] + hidden[6] + hidden_n[7] + hidden_n[8] + hidden_n[9] + hidden_n[10] + hidden[11] + hidden[12] + hidden[13] + hidden[14] + hidden[15] + hidden[16] + hidden[17] + hidden[18] + hidden[19] + hidden_n[20] + hidden[21] + hidden[22] + hidden[23] + hidden_n[24] + hidden_n[25] + hidden[26] + hidden[27] + hidden_n[28] + hidden[29] + hidden_n[30] + hidden_n[31] + hidden_n[32] + hidden[33] + hidden[34] + hidden_n[35] + hidden[36] + hidden[37] + hidden_n[38] + hidden_n[39];


argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
