module bndemo();
localparam SumL = $clog2(M+1);
localparam IumL = $clog2(N+1)+B;
wire [N*B-1:0] inm;
wire [M-1:0] mid;
wire [M-1:0] mid_n;
wire [C*SumL-1:0] out; 
assign mid_n = ~mid;
assign inm = 64'h8f4d96400498fe6f;
/* 8f4d96400498fe6f */
/* 0e4f7c572260b0f1 */
/* 095bceffcc884430 */
/* 0f1f1b37e5f7c4b0 */
/* 0b8dffddaa665380 */
parameter N = 16;
parameter M = 40;
parameter B = 4;
parameter C = 10;
assign mid[0] = - inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[1] = - inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[2] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[3] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] + inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[4] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[5] = - inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[6] = - inm[0*B+:B] + inm[1*B+:B] + inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[7] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[8] = + inm[0*B+:B] + inm[1*B+:B] + inm[2*B+:B] + inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[9] = + inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] - inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[10] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[11] = + inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[12] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[13] = + inm[0*B+:B] + inm[1*B+:B] + inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[14] = + inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[15] = - inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] + inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[16] = + inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[17] = + inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[18] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] + inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[19] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[20] = + inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] + inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[21] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] + inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[22] = + inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] - inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[23] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[24] = + inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[25] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] + inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[26] = + inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[27] = + inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] + inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[28] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[29] = - inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] - inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[30] = - inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] + inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[31] = - inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] - inm[13*B+:B] - inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[32] = - inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] - inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] + inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[33] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[34] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;
assign mid[35] = + inm[0*B+:B] - inm[1*B+:B] + inm[2*B+:B] - inm[3*B+:B] + inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[36] = - inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] - inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] - inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[37] = + inm[0*B+:B] + inm[1*B+:B] + inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] - inm[5*B+:B] - inm[6*B+:B] - inm[7*B+:B] + inm[8*B+:B] - inm[9*B+:B] - inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[38] = + inm[0*B+:B] - inm[1*B+:B] - inm[2*B+:B] + inm[3*B+:B] + inm[4*B+:B] - inm[5*B+:B] + inm[6*B+:B] + inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] + inm[10*B+:B] - inm[11*B+:B] + inm[12*B+:B] + inm[13*B+:B] - inm[14*B+:B] + inm[15*B+:B] >= 0;
assign mid[39] = + inm[0*B+:B] + inm[1*B+:B] - inm[2*B+:B] - inm[3*B+:B] - inm[4*B+:B] + inm[5*B+:B] + inm[6*B+:B] - inm[7*B+:B] - inm[8*B+:B] + inm[9*B+:B] - inm[10*B+:B] + inm[11*B+:B] + inm[12*B+:B] - inm[13*B+:B] + inm[14*B+:B] - inm[15*B+:B] >= 0;assign out[0*SumL+:SumL] = + mid[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid_n[4] + mid_n[5] + mid[6] + mid_n[7] + mid_n[8] + mid[9] + mid_n[10] + mid[11] + mid[12] + mid_n[13] + mid_n[14] + mid_n[15] + mid_n[16] + mid_n[17] + mid[18] + mid[19] + mid[20] + mid[21] + mid[22] + mid_n[23] + mid[24] + mid_n[25] + mid_n[26] + mid[27] + mid[28] + mid_n[29] + mid[30] + mid[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid_n[35] + mid[36] + mid[37] + mid[38] + mid_n[39];
assign out[1*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid[2] + mid[3] + mid[4] + mid[5] + mid_n[6] + mid_n[7] + mid[8] + mid_n[9] + mid[10] + mid_n[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid_n[16] + mid[17] + mid[18] + mid[19] + mid[20] + mid[21] + mid_n[22] + mid[23] + mid_n[24] + mid[25] + mid_n[26] + mid_n[27] + mid_n[28] + mid[29] + mid[30] + mid[31] + mid[32] + mid[33] + mid[34] + mid[35] + mid_n[36] + mid_n[37] + mid_n[38] + mid[39];
assign out[2*SumL+:SumL] = + mid_n[0] + mid[1] + mid[2] + mid[3] + mid[4] + mid[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid_n[9] + mid[10] + mid[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid_n[16] + mid[17] + mid_n[18] + mid[19] + mid_n[20] + mid_n[21] + mid_n[22] + mid_n[23] + mid_n[24] + mid[25] + mid[26] + mid_n[27] + mid_n[28] + mid_n[29] + mid[30] + mid[31] + mid[32] + mid_n[33] + mid[34] + mid_n[35] + mid_n[36] + mid_n[37] + mid[38] + mid[39];
assign out[3*SumL+:SumL] = + mid_n[0] + mid[1] + mid[2] + mid[3] + mid[4] + mid[5] + mid[6] + mid[7] + mid_n[8] + mid[9] + mid_n[10] + mid[11] + mid_n[12] + mid[13] + mid_n[14] + mid_n[15] + mid_n[16] + mid[17] + mid[18] + mid[19] + mid[20] + mid_n[21] + mid_n[22] + mid[23] + mid[24] + mid[25] + mid[26] + mid_n[27] + mid[28] + mid_n[29] + mid[30] + mid[31] + mid_n[32] + mid[33] + mid[34] + mid_n[35] + mid[36] + mid_n[37] + mid[38] + mid_n[39];
assign out[4*SumL+:SumL] = + mid[0] + mid[1] + mid_n[2] + mid[3] + mid_n[4] + mid_n[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid[9] + mid_n[10] + mid_n[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid[16] + mid_n[17] + mid[18] + mid_n[19] + mid[20] + mid[21] + mid[22] + mid_n[23] + mid_n[24] + mid_n[25] + mid[26] + mid[27] + mid_n[28] + mid[29] + mid[30] + mid_n[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid[35] + mid_n[36] + mid_n[37] + mid_n[38] + mid[39];
assign out[5*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid[4] + mid_n[5] + mid[6] + mid[7] + mid[8] + mid[9] + mid[10] + mid[11] + mid[12] + mid[13] + mid[14] + mid_n[15] + mid_n[16] + mid_n[17] + mid_n[18] + mid_n[19] + mid_n[20] + mid[21] + mid_n[22] + mid[23] + mid[24] + mid_n[25] + mid[26] + mid[27] + mid_n[28] + mid[29] + mid_n[30] + mid_n[31] + mid[32] + mid[33] + mid_n[34] + mid[35] + mid_n[36] + mid_n[37] + mid[38] + mid_n[39];
assign out[6*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid[3] + mid_n[4] + mid_n[5] + mid_n[6] + mid_n[7] + mid[8] + mid[9] + mid[10] + mid[11] + mid_n[12] + mid[13] + mid[14] + mid_n[15] + mid_n[16] + mid_n[17] + mid_n[18] + mid_n[19] + mid_n[20] + mid_n[21] + mid[22] + mid_n[23] + mid[24] + mid[25] + mid[26] + mid[27] + mid_n[28] + mid_n[29] + mid_n[30] + mid_n[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid_n[35] + mid[36] + mid[37] + mid[38] + mid_n[39];
assign out[7*SumL+:SumL] = + mid_n[0] + mid[1] + mid[2] + mid_n[3] + mid[4] + mid[5] + mid[6] + mid_n[7] + mid_n[8] + mid_n[9] + mid[10] + mid_n[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid[16] + mid[17] + mid[18] + mid_n[19] + mid_n[20] + mid_n[21] + mid_n[22] + mid[23] + mid[24] + mid_n[25] + mid[26] + mid_n[27] + mid_n[28] + mid_n[29] + mid[30] + mid_n[31] + mid[32] + mid_n[33] + mid[34] + mid[35] + mid[36] + mid_n[37] + mid[38] + mid_n[39];
assign out[8*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid_n[4] + mid_n[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid_n[9] + mid_n[10] + mid_n[11] + mid[12] + mid[13] + mid[14] + mid[15] + mid_n[16] + mid_n[17] + mid[18] + mid[19] + mid_n[20] + mid[21] + mid[22] + mid[23] + mid_n[24] + mid[25] + mid_n[26] + mid[27] + mid[28] + mid[29] + mid[30] + mid_n[31] + mid[32] + mid[33] + mid_n[34] + mid[35] + mid[36] + mid[37] + mid[38] + mid_n[39];
assign out[9*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid[4] + mid[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid[9] + mid[10] + mid_n[11] + mid[12] + mid_n[13] + mid_n[14] + mid_n[15] + mid_n[16] + mid[17] + mid[18] + mid_n[19] + mid[20] + mid[21] + mid_n[22] + mid[23] + mid[24] + mid[25] + mid[26] + mid[27] + mid_n[28] + mid[29] + mid_n[30] + mid_n[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid[35] + mid_n[36] + mid_n[37] + mid_n[38] + mid_n[39];

initial begin
    #10
    $display("mid %b",mid);
    $display("ouch %d %d", 9-0, out[0*SumL+:SumL]);
    $display("ouch %d %d", 9-1, out[1*SumL+:SumL]);
    $display("ouch %d %d", 9-2, out[2*SumL+:SumL]);
    $display("ouch %d %d", 9-3, out[3*SumL+:SumL]);
    $display("ouch %d %d", 9-4, out[4*SumL+:SumL]);
    $display("ouch %d %d", 9-5, out[5*SumL+:SumL]);
    $display("ouch %d %d", 9-6, out[6*SumL+:SumL]);
    $display("ouch %d %d", 9-7, out[7*SumL+:SumL]);
    $display("ouch %d %d", 9-8, out[8*SumL+:SumL]);
    $display("ouch %d %d", 9-9, out[9*SumL+:SumL]);
end

endmodule