






module gasIdtnn #(

parameter N = 128,
parameter M = 40,
parameter B = 4,
parameter C = 6,
parameter Ts = 5


)(
    input [N*B-1:0] inp,
    output [$clog2(C)-1:0] klass
);
localparam SumL = $clog2(M+1);
localparam IumL = $clog2(N+1)+B;
wire unsigned [B-1:0] inm [N-1:0];
wire [M-1:0] mid;
wire unsigned [IumL-1:0] pmid [M-1:0];
wire unsigned [IumL-1:0] nmid [M-1:0];
wire [M-1:0] mid_n;
wire [C*SumL-1:0] out; 
assign mid_n = ~mid;

genvar i;
generate
    for(i=0;i<N;i=i+1)
        assign inm[N-1-i] = inp[i*B+:B];
endgenerate


assign pmid[0] = + inm[0] + inm[1] + inm[2] + inm[3] + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[20] + inm[22] + inm[29] + inm[34] + inm[35] + inm[42] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[95] + inm[98] + inm[99] + inm[100] + inm[104] + inm[106] + inm[107] + inm[116] + inm[124] + inm[126];
assign nmid[0] = + inm[5] + inm[16] + inm[17] + inm[18] + inm[24] + inm[25] + inm[26] + inm[27] + inm[44] + inm[50] + inm[51] + inm[69] + inm[81] + inm[82] + inm[83] + inm[89] + inm[90];
assign mid[0] = pmid[0] >= nmid[0];
assign pmid[1] = + inm[18] + inm[19] + inm[25] + inm[27] + inm[35] + inm[43] + inm[51] + inm[52] + inm[59] + inm[73] + inm[74] + inm[75] + inm[81] + inm[83] + inm[91] + inm[99] + inm[100] + inm[108] + inm[113] + inm[114] + inm[115] + inm[116] + inm[121] + inm[123] + inm[124];
assign nmid[1] = + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[40] + inm[45] + inm[64] + inm[65] + inm[88] + inm[96] + inm[104] + inm[106];
assign mid[1] = pmid[1] >= nmid[1];
assign pmid[2] = + inm[9] + inm[12] + inm[14] + inm[16] + inm[17] + inm[18] + inm[21] + inm[24] + inm[25] + inm[26] + inm[28] + inm[29] + inm[30] + inm[32] + inm[35] + inm[36] + inm[37] + inm[40] + inm[43] + inm[49] + inm[50] + inm[56] + inm[58] + inm[63] + inm[70] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[77] + inm[80] + inm[81] + inm[82] + inm[83] + inm[90] + inm[96] + inm[103] + inm[104] + inm[110] + inm[111] + inm[127];
assign nmid[2] = + inm[3] + inm[4] + inm[10] + inm[11] + inm[15] + inm[19] + inm[34] + inm[42] + inm[48] + inm[51] + inm[60] + inm[65] + inm[69] + inm[78] + inm[87] + inm[91] + inm[92] + inm[97] + inm[98] + inm[99] + inm[102] + inm[107] + inm[116] + inm[123];
assign mid[2] = pmid[2] >= nmid[2];
assign pmid[3] = + inm[1] + inm[12] + inm[17] + inm[18] + inm[19] + inm[20] + inm[25] + inm[26] + inm[28] + inm[32] + inm[35] + inm[43] + inm[51] + inm[63] + inm[68] + inm[72] + inm[76] + inm[80] + inm[81] + inm[83] + inm[84] + inm[89] + inm[100] + inm[108] + inm[112] + inm[113] + inm[115] + inm[123] + inm[124];
assign nmid[3] = + inm[3] + inm[4] + inm[10] + inm[11] + inm[21] + inm[34] + inm[42] + inm[65] + inm[69] + inm[92] + inm[97];
assign mid[3] = pmid[3] >= nmid[3];
assign pmid[4] = + inm[8] + inm[12] + inm[16] + inm[17] + inm[19] + inm[25] + inm[26] + inm[80] + inm[81] + inm[82] + inm[89] + inm[112] + inm[114] + inm[116];
assign nmid[4] = + inm[28] + inm[34] + inm[35] + inm[42] + inm[43] + inm[44] + inm[60] + inm[64] + inm[65] + inm[67] + inm[73] + inm[74] + inm[75] + inm[97] + inm[98] + inm[99] + inm[104] + inm[105] + inm[106] + inm[107];
assign mid[4] = pmid[4] >= nmid[4];
assign pmid[5] = + inm[14] + inm[34] + inm[35] + inm[42] + inm[43] + inm[51] + inm[59] + inm[65] + inm[73] + inm[74] + inm[75] + inm[83] + inm[92] + inm[97] + inm[98] + inm[99] + inm[107] + inm[108] + inm[116] + inm[119] + inm[123] + inm[124];
assign nmid[5] = + inm[0] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[19] + inm[48] + inm[56] + inm[64] + inm[66] + inm[68] + inm[69] + inm[72] + inm[82] + inm[84] + inm[88] + inm[112];
assign mid[5] = pmid[5] >= nmid[5];
assign pmid[6] = + inm[2] + inm[6] + inm[15] + inm[21] + inm[23] + inm[24] + inm[29] + inm[31] + inm[34] + inm[36] + inm[37] + inm[39] + inm[41] + inm[44] + inm[45] + inm[46] + inm[48] + inm[58] + inm[63] + inm[69] + inm[71] + inm[73] + inm[76] + inm[78] + inm[81] + inm[83] + inm[85] + inm[90] + inm[92] + inm[93] + inm[96] + inm[99] + inm[103] + inm[104] + inm[111] + inm[112] + inm[116] + inm[118] + inm[119] + inm[120] + inm[125];
assign nmid[6] = + inm[1] + inm[13] + inm[16] + inm[20] + inm[28] + inm[30] + inm[33] + inm[43] + inm[49] + inm[52] + inm[54] + inm[55] + inm[59] + inm[62] + inm[77] + inm[97] + inm[106] + inm[114] + inm[122] + inm[124];
assign mid[6] = pmid[6] >= nmid[6];
assign pmid[7] = + inm[2] + inm[4] + inm[8] + inm[11] + inm[12] + inm[15] + inm[18] + inm[19] + inm[27] + inm[36] + inm[52] + inm[53] + inm[58] + inm[62] + inm[85] + inm[90] + inm[91] + inm[97] + inm[100] + inm[101] + inm[103] + inm[104] + inm[108] + inm[125] + inm[126];
assign nmid[7] = + inm[9] + inm[25] + inm[32] + inm[34] + inm[35] + inm[42] + inm[43] + inm[51] + inm[65] + inm[66] + inm[69] + inm[73] + inm[74] + inm[80] + inm[82] + inm[88] + inm[92] + inm[96] + inm[98] + inm[106] + inm[107] + inm[109] + inm[114] + inm[116] + inm[122] + inm[123];
assign mid[7] = pmid[7] >= nmid[7];
assign pmid[8] = + inm[8] + inm[12] + inm[17] + inm[18] + inm[19] + inm[25] + inm[26] + inm[27] + inm[45] + inm[80] + inm[81] + inm[82] + inm[83] + inm[84] + inm[89] + inm[110] + inm[113] + inm[115] + inm[116] + inm[121] + inm[123];
assign nmid[8] = + inm[1] + inm[3] + inm[4] + inm[9] + inm[10] + inm[11] + inm[20] + inm[28] + inm[32] + inm[34] + inm[35] + inm[40] + inm[42] + inm[43] + inm[53] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[96] + inm[97] + inm[98] + inm[99] + inm[104] + inm[105] + inm[106] + inm[107];
assign mid[8] = pmid[8] >= nmid[8];
assign pmid[9] = + inm[0] + inm[2] + inm[3] + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[20] + inm[28] + inm[34] + inm[35] + inm[41] + inm[57] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[82] + inm[98] + inm[99] + inm[107] + inm[114] + inm[116] + inm[122] + inm[124];
assign nmid[9] = + inm[16] + inm[17] + inm[18] + inm[19] + inm[24] + inm[25] + inm[26] + inm[27] + inm[43] + inm[44] + inm[81] + inm[91] + inm[97] + inm[100] + inm[104] + inm[105] + inm[108] + inm[123];
assign mid[9] = pmid[9] >= nmid[9];
assign pmid[10] = + inm[1] + inm[3] + inm[7] + inm[28] + inm[32] + inm[33] + inm[34] + inm[35] + inm[36] + inm[40] + inm[41] + inm[42] + inm[43] + inm[49] + inm[51] + inm[52] + inm[57] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[98] + inm[99] + inm[100] + inm[106] + inm[107] + inm[108] + inm[123] + inm[124];
assign nmid[10] = + inm[8] + inm[10] + inm[11] + inm[12] + inm[16] + inm[17] + inm[18] + inm[19] + inm[25] + inm[26] + inm[48] + inm[80] + inm[81] + inm[82] + inm[83] + inm[84] + inm[88] + inm[89] + inm[90] + inm[109] + inm[113] + inm[120];
assign mid[10] = pmid[10] >= nmid[10];
assign pmid[11] = + inm[5] + inm[11] + inm[18] + inm[26] + inm[34] + inm[42] + inm[65] + inm[70] + inm[78] + inm[82] + inm[92];
assign nmid[11] = + inm[0] + inm[1] + inm[2] + inm[4] + inm[8] + inm[9] + inm[12] + inm[19] + inm[20] + inm[28] + inm[33] + inm[35] + inm[43] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[75] + inm[76] + inm[100] + inm[108] + inm[112] + inm[115] + inm[123] + inm[124];
assign mid[11] = pmid[11] >= nmid[11];
assign pmid[12] = + inm[0] + inm[1] + inm[2] + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[19] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[76] + inm[80] + inm[81] + inm[84] + inm[100] + inm[101] + inm[108] + inm[112] + inm[113] + inm[115];
assign nmid[12] = + inm[13] + inm[18] + inm[26] + inm[32] + inm[34] + inm[42] + inm[43] + inm[59] + inm[73] + inm[75] + inm[97] + inm[98] + inm[99] + inm[105] + inm[106] + inm[107] + inm[110] + inm[123];
assign mid[12] = pmid[12] >= nmid[12];
assign pmid[13] = + inm[8] + inm[12] + inm[16] + inm[17] + inm[18] + inm[19] + inm[25] + inm[26] + inm[27] + inm[44] + inm[51] + inm[80] + inm[81] + inm[82] + inm[83] + inm[84] + inm[89] + inm[91] + inm[100] + inm[101] + inm[108] + inm[113] + inm[115] + inm[116] + inm[121] + inm[123];
assign nmid[13] = + inm[10] + inm[11] + inm[20] + inm[28] + inm[32] + inm[34] + inm[40] + inm[42] + inm[49] + inm[64] + inm[65] + inm[66] + inm[67] + inm[69] + inm[72] + inm[73] + inm[78] + inm[92] + inm[98] + inm[99] + inm[106] + inm[107];
assign mid[13] = pmid[13] >= nmid[13];
assign pmid[14] = + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[16] + inm[48] + inm[64] + inm[68] + inm[80] + inm[84] + inm[88] + inm[94] + inm[96] + inm[101] + inm[104] + inm[112] + inm[120];
assign nmid[14] = + inm[25] + inm[27] + inm[28] + inm[34] + inm[35] + inm[42] + inm[43] + inm[51] + inm[52] + inm[57] + inm[59] + inm[60] + inm[73] + inm[74] + inm[75] + inm[79] + inm[83] + inm[87] + inm[91] + inm[92] + inm[97] + inm[98] + inm[99] + inm[100] + inm[105] + inm[106] + inm[107] + inm[108] + inm[113] + inm[116] + inm[121] + inm[123] + inm[124];
assign mid[14] = pmid[14] >= nmid[14];
assign pmid[15] = + inm[4] + inm[13] + inm[19] + inm[33] + inm[45] + inm[48] + inm[49] + inm[50] + inm[61] + inm[64] + inm[71] + inm[77] + inm[83] + inm[87] + inm[88] + inm[90] + inm[103] + inm[107] + inm[109] + inm[118] + inm[126];
assign nmid[15] = + inm[1] + inm[2] + inm[16] + inm[17] + inm[28] + inm[32] + inm[34] + inm[46] + inm[51] + inm[53] + inm[57] + inm[60] + inm[72] + inm[75] + inm[82] + inm[84] + inm[85] + inm[89] + inm[104] + inm[122] + inm[127];
assign mid[15] = pmid[15] >= nmid[15];
assign pmid[16] = + inm[17] + inm[18] + inm[19] + inm[25] + inm[26] + inm[27] + inm[42] + inm[43] + inm[44] + inm[51] + inm[59] + inm[60] + inm[70] + inm[81] + inm[92] + inm[97] + inm[100] + inm[105] + inm[108] + inm[123];
assign nmid[16] = + inm[0] + inm[8] + inm[9] + inm[10] + inm[11] + inm[28] + inm[32] + inm[54] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[76] + inm[80] + inm[112];
assign mid[16] = pmid[16] >= nmid[16];
assign pmid[17] = + inm[0] + inm[1] + inm[4] + inm[12] + inm[17] + inm[19] + inm[25] + inm[27] + inm[28] + inm[44] + inm[49] + inm[51] + inm[66] + inm[68] + inm[72] + inm[76] + inm[80] + inm[81] + inm[82] + inm[83] + inm[84] + inm[88] + inm[89] + inm[91] + inm[100] + inm[108] + inm[113] + inm[114] + inm[115] + inm[116] + inm[121] + inm[123] + inm[124];
assign nmid[17] = + inm[3] + inm[10] + inm[11] + inm[23] + inm[34] + inm[40] + inm[42] + inm[53] + inm[63] + inm[65] + inm[73] + inm[74] + inm[75] + inm[86] + inm[98] + inm[99] + inm[106] + inm[107];
assign mid[17] = pmid[17] >= nmid[17];
assign pmid[18] = + inm[4] + inm[7] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[16] + inm[17] + inm[19] + inm[22] + inm[23] + inm[24] + inm[25] + inm[27] + inm[36] + inm[40] + inm[44] + inm[45] + inm[48] + inm[86] + inm[90] + inm[98] + inm[102] + inm[104] + inm[105] + inm[119];
assign nmid[18] = + inm[5] + inm[28] + inm[30] + inm[35] + inm[37] + inm[43] + inm[47] + inm[51] + inm[57] + inm[59] + inm[66] + inm[67] + inm[69] + inm[72] + inm[73] + inm[75] + inm[76] + inm[83] + inm[87] + inm[89] + inm[92] + inm[95] + inm[99] + inm[107] + inm[110] + inm[113] + inm[114] + inm[115] + inm[120] + inm[121] + inm[122] + inm[123] + inm[124] + inm[127];
assign mid[18] = pmid[18] >= nmid[18];
assign pmid[19] = + inm[0] + inm[1] + inm[2] + inm[3] + inm[4] + inm[20] + inm[28] + inm[34] + inm[35] + inm[42] + inm[43] + inm[52] + inm[59] + inm[60] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[96] + inm[98] + inm[99] + inm[100] + inm[106] + inm[107] + inm[108] + inm[116] + inm[118] + inm[123] + inm[124];
assign nmid[19] = + inm[12] + inm[16] + inm[17] + inm[18] + inm[24] + inm[25] + inm[26] + inm[38] + inm[80] + inm[81] + inm[82] + inm[84] + inm[88] + inm[89] + inm[90] + inm[112] + inm[120];
assign mid[19] = pmid[19] >= nmid[19];
assign pmid[20] = + inm[3] + inm[4] + inm[8] + inm[10] + inm[11] + inm[34] + inm[42] + inm[54] + inm[60] + inm[64] + inm[65] + inm[69] + inm[90] + inm[92] + inm[97] + inm[116] + inm[121];
assign nmid[20] = + inm[14] + inm[16] + inm[17] + inm[18] + inm[19] + inm[20] + inm[24] + inm[25] + inm[26] + inm[27] + inm[28] + inm[32] + inm[35] + inm[43] + inm[49] + inm[72] + inm[76] + inm[80] + inm[83] + inm[100] + inm[104] + inm[108] + inm[123];
assign mid[20] = pmid[20] >= nmid[20];
assign pmid[21] = + inm[17] + inm[25] + inm[26] + inm[35] + inm[43] + inm[51] + inm[58] + inm[59] + inm[75] + inm[83] + inm[89] + inm[100] + inm[108] + inm[111] + inm[113] + inm[115] + inm[116] + inm[123];
assign nmid[21] = + inm[0] + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[20] + inm[33] + inm[48] + inm[56] + inm[64] + inm[65] + inm[67] + inm[68] + inm[96] + inm[120];
assign mid[21] = pmid[21] >= nmid[21];
assign pmid[22] = + inm[0] + inm[1] + inm[8] + inm[10] + inm[11] + inm[12] + inm[17] + inm[19] + inm[24] + inm[26] + inm[32] + inm[50] + inm[68] + inm[72] + inm[80] + inm[81] + inm[82] + inm[84] + inm[101] + inm[104] + inm[109] + inm[112] + inm[120];
assign nmid[22] = + inm[2] + inm[3] + inm[7] + inm[20] + inm[22] + inm[28] + inm[34] + inm[35] + inm[42] + inm[43] + inm[52] + inm[59] + inm[60] + inm[65] + inm[71] + inm[73] + inm[74] + inm[75] + inm[91] + inm[92] + inm[97] + inm[99] + inm[105] + inm[106] + inm[107] + inm[108] + inm[115] + inm[116] + inm[121] + inm[123];
assign mid[22] = pmid[22] >= nmid[22];
assign pmid[23] = + inm[0] + inm[1] + inm[2] + inm[3] + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[13] + inm[23] + inm[25] + inm[27] + inm[28] + inm[35] + inm[45] + inm[50] + inm[51] + inm[59] + inm[60] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[80] + inm[81] + inm[82] + inm[83] + inm[84] + inm[91] + inm[92] + inm[99] + inm[100] + inm[101] + inm[107] + inm[108] + inm[112] + inm[113] + inm[114] + inm[115] + inm[116] + inm[121] + inm[122] + inm[123] + inm[124];
assign nmid[23] = + inm[6] + inm[12] + inm[17] + inm[18] + inm[26] + inm[32] + inm[40] + inm[42] + inm[43] + inm[56] + inm[88] + inm[96] + inm[97] + inm[98] + inm[104] + inm[105] + inm[106];
assign mid[23] = pmid[23] >= nmid[23];
assign pmid[24] = + inm[0] + inm[1] + inm[3] + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[44] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[76] + inm[112] + inm[120];
assign nmid[24] = + inm[25] + inm[26] + inm[34] + inm[35] + inm[42] + inm[43] + inm[51] + inm[59] + inm[73] + inm[74] + inm[83] + inm[91] + inm[99] + inm[105] + inm[106] + inm[107] + inm[121] + inm[123];
assign mid[24] = pmid[24] >= nmid[24];
assign pmid[25] = + inm[17] + inm[25] + inm[28] + inm[35] + inm[43] + inm[50] + inm[51] + inm[59] + inm[66] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[81] + inm[82] + inm[83] + inm[89] + inm[99] + inm[100] + inm[107] + inm[108] + inm[109] + inm[113] + inm[115] + inm[116] + inm[121] + inm[122] + inm[123] + inm[124];
assign nmid[25] = + inm[4] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[36] + inm[42] + inm[65] + inm[96] + inm[97] + inm[98] + inm[104] + inm[105] + inm[106] + inm[125];
assign mid[25] = pmid[25] >= nmid[25];
assign pmid[26] = + inm[3] + inm[4] + inm[10] + inm[11] + inm[26] + inm[34] + inm[40] + inm[42] + inm[65] + inm[78] + inm[92] + inm[96] + inm[97] + inm[98] + inm[104] + inm[105] + inm[106];
assign nmid[26] = + inm[0] + inm[1] + inm[8] + inm[16] + inm[17] + inm[19] + inm[25] + inm[28] + inm[35] + inm[43] + inm[51] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[76] + inm[80] + inm[81] + inm[82] + inm[83] + inm[84] + inm[89] + inm[91] + inm[100] + inm[108] + inm[109] + inm[112] + inm[113] + inm[115] + inm[116] + inm[120] + inm[121] + inm[122] + inm[123] + inm[124];
assign mid[26] = pmid[26] >= nmid[26];
assign pmid[27] = + inm[19] + inm[20] + inm[27] + inm[28] + inm[34] + inm[35] + inm[42] + inm[43] + inm[51] + inm[52] + inm[59] + inm[60] + inm[65] + inm[73] + inm[74] + inm[75] + inm[91] + inm[92] + inm[97] + inm[98] + inm[99] + inm[100] + inm[106] + inm[107] + inm[108] + inm[115] + inm[116] + inm[121] + inm[123] + inm[124];
assign nmid[27] = + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[16] + inm[26] + inm[48] + inm[80] + inm[81] + inm[82] + inm[88] + inm[90] + inm[96] + inm[110] + inm[112] + inm[120];
assign mid[27] = pmid[27] >= nmid[27];
assign pmid[28] = + inm[17] + inm[19] + inm[25] + inm[27] + inm[34] + inm[43] + inm[52] + inm[59] + inm[61] + inm[85] + inm[91] + inm[92] + inm[98] + inm[100] + inm[105] + inm[108] + inm[116] + inm[121] + inm[123];
assign nmid[28] = + inm[0] + inm[2] + inm[8] + inm[10] + inm[11] + inm[12] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[112];
assign mid[28] = pmid[28] >= nmid[28];
assign pmid[29] = + inm[14] + inm[16] + inm[20] + inm[26] + inm[29] + inm[31] + inm[34] + inm[35] + inm[72] + inm[73] + inm[94] + inm[98] + inm[106] + inm[112] + inm[114] + inm[122];
assign nmid[29] = + inm[1] + inm[2] + inm[4] + inm[7] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[19] + inm[23] + inm[27] + inm[32] + inm[36] + inm[37] + inm[39] + inm[44] + inm[52] + inm[54] + inm[57] + inm[58] + inm[59] + inm[61] + inm[62] + inm[63] + inm[66] + inm[67] + inm[68] + inm[69] + inm[79] + inm[81] + inm[83] + inm[88] + inm[90] + inm[92] + inm[93] + inm[97] + inm[100] + inm[101] + inm[107] + inm[108] + inm[109] + inm[110] + inm[116] + inm[118];
assign mid[29] = pmid[29] >= nmid[29];
assign pmid[30] = + inm[27] + inm[36] + inm[49] + inm[52] + inm[84] + inm[94];
assign nmid[30] = + inm[0] + inm[5] + inm[14] + inm[15] + inm[16] + inm[18] + inm[19] + inm[20] + inm[21] + inm[22] + inm[32] + inm[38] + inm[41] + inm[42] + inm[43] + inm[45] + inm[47] + inm[48] + inm[51] + inm[53] + inm[54] + inm[58] + inm[60] + inm[61] + inm[62] + inm[64] + inm[65] + inm[68] + inm[69] + inm[73] + inm[78] + inm[79] + inm[81] + inm[83] + inm[86] + inm[88] + inm[92] + inm[93] + inm[98] + inm[99] + inm[100] + inm[103] + inm[104] + inm[105] + inm[106] + inm[107] + inm[108] + inm[121] + inm[125] + inm[126] + inm[127];
assign mid[30] = pmid[30] >= nmid[30];
assign pmid[31] = + inm[4] + inm[8] + inm[10] + inm[11] + inm[12] + inm[24] + inm[26] + inm[40] + inm[56] + inm[65] + inm[90] + inm[96] + inm[112];
assign nmid[31] = + inm[19] + inm[25] + inm[27] + inm[28] + inm[35] + inm[43] + inm[51] + inm[59] + inm[72] + inm[74] + inm[75] + inm[76] + inm[83] + inm[91] + inm[98] + inm[99] + inm[100] + inm[107] + inm[108] + inm[113] + inm[115] + inm[116] + inm[121] + inm[123] + inm[124];
assign mid[31] = pmid[31] >= nmid[31];
assign pmid[32] = + inm[4] + inm[8] + inm[12] + inm[16] + inm[19] + inm[26] + inm[27] + inm[32] + inm[33] + inm[40] + inm[44] + inm[96] + inm[97] + inm[98] + inm[100] + inm[104] + inm[105] + inm[106] + inm[108];
assign nmid[32] = + inm[0] + inm[20] + inm[28] + inm[34] + inm[35] + inm[43] + inm[50] + inm[51] + inm[52] + inm[59] + inm[60] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[81] + inm[82] + inm[83] + inm[91] + inm[99] + inm[107] + inm[109] + inm[112] + inm[113] + inm[114] + inm[115] + inm[116] + inm[120] + inm[121] + inm[122] + inm[123] + inm[124];
assign mid[32] = pmid[32] >= nmid[32];
assign pmid[33] = + inm[3] + inm[7] + inm[12] + inm[22] + inm[24] + inm[28] + inm[29] + inm[34] + inm[36] + inm[37] + inm[40] + inm[45] + inm[47] + inm[49] + inm[50] + inm[53] + inm[54] + inm[66] + inm[67] + inm[68] + inm[71] + inm[81] + inm[89] + inm[90] + inm[91] + inm[92] + inm[95] + inm[96] + inm[106] + inm[107] + inm[121] + inm[125] + inm[127];
assign nmid[33] = + inm[2] + inm[5] + inm[11] + inm[20] + inm[41] + inm[61] + inm[65] + inm[72] + inm[78] + inm[79] + inm[86] + inm[108] + inm[112] + inm[113] + inm[114] + inm[120] + inm[124];
assign mid[33] = pmid[33] >= nmid[33];
assign pmid[34] = + inm[0] + inm[3] + inm[4] + inm[15] + inm[19] + inm[20] + inm[27] + inm[28] + inm[35] + inm[43] + inm[51] + inm[52] + inm[59] + inm[60] + inm[61] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[74] + inm[75] + inm[76] + inm[81] + inm[83] + inm[91] + inm[92] + inm[95] + inm[99] + inm[100] + inm[107] + inm[108] + inm[113] + inm[115] + inm[116] + inm[121] + inm[123] + inm[124];
assign nmid[34] = + inm[8] + inm[10] + inm[12] + inm[16] + inm[17] + inm[18] + inm[24] + inm[26] + inm[32] + inm[36] + inm[40] + inm[46] + inm[48] + inm[77] + inm[82] + inm[88] + inm[89] + inm[90] + inm[96] + inm[104] + inm[112] + inm[120];
assign mid[34] = pmid[34] >= nmid[34];
assign pmid[35] = + inm[0] + inm[1] + inm[3] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] + inm[20] + inm[28] + inm[33] + inm[49] + inm[51] + inm[60] + inm[61] + inm[64] + inm[65] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[76] + inm[83] + inm[112] + inm[114] + inm[115] + inm[116] + inm[124];
assign nmid[35] = + inm[16] + inm[17] + inm[18] + inm[24] + inm[25] + inm[26] + inm[34] + inm[36] + inm[42] + inm[43] + inm[44] + inm[96] + inm[97] + inm[98] + inm[104] + inm[105];
assign mid[35] = pmid[35] >= nmid[35];
assign pmid[36] = + inm[18] + inm[21] + inm[25] + inm[26] + inm[27] + inm[34] + inm[40] + inm[42] + inm[43] + inm[44] + inm[59] + inm[60] + inm[65] + inm[79] + inm[92] + inm[97] + inm[98] + inm[99] + inm[105] + inm[106] + inm[107];
assign nmid[36] = + inm[0] + inm[1] + inm[8] + inm[10] + inm[11] + inm[12] + inm[19] + inm[23] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[76] + inm[80] + inm[81] + inm[82] + inm[94] + inm[100] + inm[108] + inm[109] + inm[112] + inm[115] + inm[124];
assign mid[36] = pmid[36] >= nmid[36];
assign pmid[37] = + inm[12] + inm[17] + inm[18] + inm[25] + inm[26] + inm[31] + inm[44] + inm[50] + inm[81] + inm[82] + inm[84] + inm[89] + inm[90] + inm[112];
assign nmid[37] = + inm[0] + inm[3] + inm[4] + inm[9] + inm[20] + inm[28] + inm[33] + inm[35] + inm[42] + inm[64] + inm[66] + inm[67] + inm[68] + inm[72] + inm[73] + inm[75] + inm[76] + inm[86] + inm[96] + inm[98] + inm[99] + inm[104] + inm[106] + inm[107];
assign mid[37] = pmid[37] >= nmid[37];
assign pmid[38] = + inm[8] + inm[11] + inm[12] + inm[19] + inm[28] + inm[53] + inm[56] + inm[64] + inm[67] + inm[68] + inm[76] + inm[100] + inm[108];
assign nmid[38] = + inm[14] + inm[25] + inm[26] + inm[34] + inm[42] + inm[43] + inm[123];
assign mid[38] = pmid[38] >= nmid[38];
assign pmid[39] = + inm[0] + inm[8] + inm[10] + inm[11] + inm[12] + inm[26] + inm[48] + inm[65] + inm[80] + inm[81] + inm[82] + inm[88] + inm[90] + inm[112];
assign nmid[39] = + inm[1] + inm[19] + inm[20] + inm[27] + inm[28] + inm[34] + inm[35] + inm[43] + inm[52] + inm[59] + inm[67] + inm[72] + inm[75] + inm[76] + inm[91] + inm[97] + inm[98] + inm[99] + inm[100] + inm[105] + inm[106] + inm[107] + inm[108] + inm[115] + inm[116] + inm[123] + inm[124];
assign mid[39] = pmid[39] >= nmid[39];
assign out[0*SumL+:SumL] = + mid_n[2] + mid[8] + mid[10] + mid_n[14] + mid[19] + mid_n[22] + mid_n[26] + mid[29] + mid_n[31] + mid_n[32] + mid[34] + mid_n[39];
assign out[1*SumL+:SumL] = + mid_n[0] + mid[8] + mid_n[9] + mid_n[10] + mid_n[11] + mid[13] + mid[16] + mid_n[19] + mid[21] + mid[28] + mid_n[31] + mid[37];
assign out[2*SumL+:SumL] = + mid_n[0] + mid_n[6] + mid_n[9] + mid_n[12] + mid_n[17] + mid_n[25] + mid[26] + mid[28] + mid[29] + mid[32] + mid_n[34] + mid_n[35];
assign out[3*SumL+:SumL] = + mid_n[12] + mid_n[17] + mid[29];
assign out[4*SumL+:SumL] = + mid[4] + mid_n[5] + mid[8] + mid[12] + mid_n[21] + mid[22] + mid[24] + mid_n[36] + mid[39];
assign out[5*SumL+:SumL] = + mid_n[3] + mid_n[4] + mid_n[6] + mid_n[13] + mid_n[17] + mid[20] + mid_n[21] + mid_n[22] + mid_n[25] + mid[36];


argmax #(.N(C),.I($clog2(C)),.K(SumL)) result (
    .inx(out),
    .outimax(klass)
);
endmodule
