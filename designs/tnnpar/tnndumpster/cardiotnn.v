






module cardiotnn #(

parameter N = 19,
parameter M = 40,
parameter B = 4,
parameter C = 3,
parameter Ts = 5


)(
    input [N*B-1:0] inp,
    output [$clog2(C)-1:0] klass
);
localparam SumL = $clog2(M+1);
localparam ZumL = SumL+1;
localparam IumL = $clog2(N+1)+B;
wire unsigned [B-1:0] inm [N-1:0];
wire [M-1:0] mid;
wire unsigned [IumL-1:0] pmid [M-1:0];
wire unsigned [IumL-1:0] nmid [M-1:0];
wire [M-1:0] mid_n;
wire [SumL-1:0] pop [C-1:0]; 
wire [(SumL+1)-1:0] out [C-1:0]; 
wire [C*(SumL+1)-1:0] sums; 
assign mid_n = ~mid;

genvar i;
generate
    for(i=0;i<N;i=i+1)
        assign inm[N-1-i] = inp[i*B+:B];
endgenerate
generate
    for(i=0;i<C;i=i+1)
        assign sums[i*ZumL+:ZumL] = out[i];
endgenerate


assign pmid[0] = + inm[1] + inm[2] + inm[4] + inm[5] + inm[14] + inm[18];
assign nmid[0] = + inm[17];
assign mid[0] = pmid[0] >= nmid[0];
assign pmid[1] = + inm[2] + inm[12] + inm[16] + inm[17];
assign nmid[1] = + inm[1] + inm[5] + inm[7] + inm[13];
assign mid[1] = pmid[1] >= nmid[1];
assign pmid[2] = + inm[0] + inm[1] + inm[3] + inm[4] + inm[8] + inm[16];
assign nmid[2] = + inm[2] + inm[11] + inm[12] + inm[14];
assign mid[2] = pmid[2] >= nmid[2];
assign pmid[3] = + inm[0] + inm[8] + inm[9] + inm[17];
assign nmid[3] = + inm[1] + inm[3] + inm[5] + inm[7] + inm[13] + inm[15];
assign mid[3] = pmid[3] >= nmid[3];
assign pmid[4] = + inm[0] + inm[2] + inm[10] + inm[14] + inm[17];
assign nmid[4] = + inm[1] + inm[4] + inm[8] + inm[12] + inm[13] + inm[15] + inm[16];
assign mid[4] = pmid[4] >= nmid[4];
assign pmid[5] = + inm[0] + inm[4] + inm[6] + inm[9] + inm[12] + inm[17];
assign nmid[5] = + inm[1] + inm[3] + inm[5] + inm[8] + inm[11] + inm[15];
assign mid[5] = pmid[5] >= nmid[5];
assign pmid[6] = + inm[6] + inm[9] + inm[17];
assign nmid[6] = + inm[0] + inm[1] + inm[3] + inm[14] + inm[15] + inm[16];
assign mid[6] = pmid[6] >= nmid[6];
assign pmid[7] = + inm[0] + inm[4] + inm[9] + inm[13] + inm[18];
assign nmid[7] = + inm[1] + inm[3] + inm[7] + inm[10] + inm[12] + inm[15];
assign mid[7] = pmid[7] >= nmid[7];
assign pmid[8] = + inm[13] + inm[17];
assign nmid[8] = + inm[6] + inm[9] + inm[10] + inm[14] + inm[18];
assign mid[8] = pmid[8] >= nmid[8];
assign pmid[9] = + inm[0] + inm[4] + inm[9] + inm[18];
assign nmid[9] = + inm[1] + inm[3] + inm[5] + inm[7] + inm[8] + inm[14];
assign mid[9] = pmid[9] >= nmid[9];
assign pmid[10] = + inm[4] + inm[7] + inm[9] + inm[12];
assign nmid[10] = + inm[1] + inm[3] + inm[8] + inm[10] + inm[11] + inm[15] + inm[18];
assign mid[10] = pmid[10] >= nmid[10];
assign pmid[11] = + inm[4] + inm[6] + inm[8] + inm[9] + inm[11];
assign nmid[11] = + inm[1] + inm[14] + inm[15];
assign mid[11] = pmid[11] >= nmid[11];
assign pmid[12] = + inm[2] + inm[6] + inm[9] + inm[16] + inm[18];
assign nmid[12] = + inm[1] + inm[3] + inm[15];
assign mid[12] = pmid[12] >= nmid[12];
assign pmid[13] = + inm[1] + inm[3] + inm[13] + inm[14] + inm[15] + inm[17];
assign nmid[13] = + inm[0] + inm[2] + inm[4] + inm[6] + inm[9] + inm[10] + inm[18];
assign mid[13] = pmid[13] >= nmid[13];
assign pmid[14] = + inm[7] + inm[8] + inm[10];
assign nmid[14] = + inm[6];
assign mid[14] = pmid[14] >= nmid[14];
assign pmid[15] = + inm[10] + inm[12];
assign nmid[15] = + inm[1] + inm[2] + inm[3] + inm[5] + inm[7] + inm[8] + inm[9] + inm[11] + inm[15];
assign mid[15] = pmid[15] >= nmid[15];
assign pmid[16] = + inm[5] + inm[6] + inm[12] + inm[14];
assign nmid[16] = + inm[1] + inm[3] + inm[7] + inm[9] + inm[11] + inm[17];
assign mid[16] = pmid[16] >= nmid[16];
assign pmid[17] = + inm[1] + inm[3] + inm[5] + inm[8];
assign nmid[17] = + inm[6] + inm[7] + inm[9] + inm[12];
assign mid[17] = pmid[17] >= nmid[17];
assign pmid[18] = + inm[1] + inm[3] + inm[5] + inm[10] + inm[14] + inm[16];
assign nmid[18] = + inm[6] + inm[8];
assign mid[18] = pmid[18] >= nmid[18];
assign pmid[19] = + inm[2] + inm[4] + inm[8] + inm[9] + inm[18];
assign nmid[19] = + inm[1] + inm[3] + inm[6] + inm[7] + inm[10] + inm[13] + inm[16] + inm[17];
assign mid[19] = pmid[19] >= nmid[19];
assign pmid[20] = + inm[1] + inm[2] + inm[5] + inm[7] + inm[8] + inm[11] + inm[13];
assign nmid[20] = + inm[6] + inm[9] + inm[10] + inm[14];
assign mid[20] = pmid[20] >= nmid[20];
assign pmid[21] = + inm[3] + inm[9] + inm[12] + inm[14] + inm[15];
assign nmid[21] = + inm[0] + inm[1] + inm[5] + inm[16];
assign mid[21] = pmid[21] >= nmid[21];
assign pmid[22] = + inm[1] + inm[17];
assign nmid[22] = + inm[5] + inm[7];
assign mid[22] = pmid[22] >= nmid[22];
assign pmid[23] = + inm[11] + inm[15];
assign nmid[23] = + inm[0] + inm[2] + inm[4] + inm[5] + inm[8] + inm[14];
assign mid[23] = pmid[23] >= nmid[23];
assign pmid[24] = + inm[0] + inm[1] + inm[3] + inm[7] + inm[10] + inm[16];
assign nmid[24] = + inm[6] + inm[9] + inm[12];
assign mid[24] = pmid[24] >= nmid[24];
assign pmid[25] = + inm[3] + inm[8];
assign nmid[25] = + inm[0] + inm[10] + inm[12] + inm[18];
assign mid[25] = pmid[25] >= nmid[25];
assign pmid[26] = + inm[1] + inm[3] + inm[11] + inm[15] + inm[16];
assign nmid[26] = + inm[7] + inm[9] + inm[10] + inm[18];
assign mid[26] = pmid[26] >= nmid[26];
assign pmid[27] = + inm[1] + inm[5] + inm[8] + inm[9] + inm[10] + inm[12] + inm[14];
assign nmid[27] = + inm[4] + inm[7] + inm[13];
assign mid[27] = pmid[27] >= nmid[27];
assign pmid[28] = + inm[1] + inm[5] + inm[15] + inm[17];
assign nmid[28] = + inm[0] + inm[4] + inm[9] + inm[14];
assign mid[28] = pmid[28] >= nmid[28];
assign pmid[29] = + inm[13];
assign nmid[29] = + inm[0] + inm[4] + inm[12] + inm[14] + inm[15] + inm[16] + inm[17] + inm[18];
assign mid[29] = pmid[29] >= nmid[29];
assign pmid[30] = + inm[1] + inm[2] + inm[3] + inm[6] + inm[8] + inm[9] + inm[11];
assign nmid[30] = + inm[0] + inm[4] + inm[13] + inm[15] + inm[17];
assign mid[30] = pmid[30] >= nmid[30];
assign pmid[31] = + inm[1] + inm[4] + inm[5] + inm[7] + inm[8] + inm[9] + inm[11] + inm[12] + inm[14] + inm[18];
assign nmid[31] = + inm[2] + inm[3] + inm[10] + inm[13] + inm[15] + inm[16] + inm[17];
assign mid[31] = pmid[31] >= nmid[31];
assign pmid[32] = + inm[1] + inm[3] + inm[5] + inm[7] + inm[14] + inm[15];
assign nmid[32] = + inm[2] + inm[6] + inm[9] + inm[18];
assign mid[32] = pmid[32] >= nmid[32];
assign pmid[33] = + inm[0] + inm[5] + inm[11] + inm[13] + inm[14];
assign nmid[33] = + inm[1] + inm[2] + inm[4] + inm[9] + inm[12] + inm[17] + inm[18];
assign mid[33] = pmid[33] >= nmid[33];
assign pmid[34] = + inm[0] + inm[1] + inm[5] + inm[14];
assign nmid[34] = + inm[3] + inm[7] + inm[13];
assign mid[34] = pmid[34] >= nmid[34];
assign pmid[35] = + inm[0] + inm[15] + inm[17] + inm[18];
assign nmid[35] = + inm[2] + inm[5] + inm[11] + inm[12] + inm[16];
assign mid[35] = pmid[35] >= nmid[35];
assign pmid[36] = + inm[1] + inm[3] + inm[5] + inm[7] + inm[8] + inm[17];
assign nmid[36] = + inm[4] + inm[9] + inm[10];
assign mid[36] = pmid[36] >= nmid[36];
assign pmid[37] = + inm[1] + inm[3] + inm[7] + inm[18];
assign nmid[37] = + inm[2] + inm[4] + inm[9] + inm[10] + inm[17];
assign mid[37] = pmid[37] >= nmid[37];
assign pmid[38] = + inm[5] + inm[6] + inm[9] + inm[14] + inm[15] + inm[18];
assign nmid[38] = + inm[1] + inm[3] + inm[7] + inm[16] + inm[17];
assign mid[38] = pmid[38] >= nmid[38];
assign pmid[39] = + inm[0] + inm[5] + inm[6] + inm[7] + inm[8] + inm[12] + inm[18];
assign nmid[39] = + inm[1] + inm[3] + inm[14] + inm[17];
assign mid[39] = pmid[39] >= nmid[39];
assign pop[0] = + mid[1] + mid_n[3] + mid_n[10] + mid_n[12] + mid[17] + mid[24] + mid[26] + mid[27] + mid[28] + mid[32] + mid_n[33] + mid[36] + mid[37];assign out[0] = 2*pop[0] + 0;
assign pop[1] = + mid[1] + mid_n[2] + mid[5] + mid[6] + mid[7] + mid[9] + mid[12] + mid[15] + mid[27] + mid[28] + mid_n[30] + mid_n[33] + mid_n[37];assign out[1] = 2*pop[1] + 0;
assign pop[2] = + mid[2] + mid[4] + mid[5] + mid[7] + mid_n[8] + mid[11] + mid_n[13] + mid_n[15] + mid[19] + mid[27] + mid[31] + mid_n[33] + mid[38];assign out[2] = 2*pop[2] + 0;


argmax #(.N(C),.I($clog2(C)),.K(SumL+1)) result (
    .inx(sums),
    .outimax(klass)
);
endmodule