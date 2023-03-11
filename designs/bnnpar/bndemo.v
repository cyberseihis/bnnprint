module bndemo();
localparam SumL = $clog2(M+1);
localparam IumL = $clog2(N+1)+B;
/* localparam IumL = 20; */
wire [N*B-1:0] inp;
wire signed [IumL-1:0] inm [N-1:0];
wire [M-1:0] mid;
wire signed [IumL-1:0] vmid [M-1:0];
wire [M-1:0] mid_n;
wire [C*SumL-1:0] out; 
assign mid_n = ~mid;
assign inp = 64'h8f4d96400498fe6f;
/* 8f4d96400498fe6f */
/* 0e4f7c572260b0f1 */
/* 095bceffcc884430 */
/* 0f1f1b37e5f7c4b0 */
/* 0b8dffddaa665380 */

genvar i;
generate
    for(i=0;i<N;i=i+1)
        assign inm[i] = {5'b0,inp[i*B+:B]};
endgenerate

parameter N = 16;
parameter M = 40;
parameter B = 4;
parameter C = 10;
assign vmid[0] = - inm[0] + inm[1] - inm[2] - inm[3] - inm[4] - inm[5] + inm[6] - inm[7] + inm[8] + inm[9] - inm[10] + inm[11] - inm[12] + inm[13] - inm[14] - inm[15];
assign mid[0] = vmid[0] >= 0;
assign vmid[1] = - inm[0] + inm[1] - inm[2] + inm[3] + inm[4] - inm[5] - inm[6] - inm[7] + inm[8] - inm[9] + inm[10] + inm[11] - inm[12] - inm[13] + inm[14] - inm[15];
assign mid[1] = vmid[1] >= 0;
assign vmid[2] = - inm[0] - inm[1] - inm[2] - inm[3] + inm[4] + inm[5] + inm[6] + inm[7] + inm[8] - inm[9] - inm[10] - inm[11] + inm[12] - inm[13] + inm[14] - inm[15];
assign mid[2] = vmid[2] >= 0;
assign vmid[3] = + inm[0] - inm[1] + inm[2] + inm[3] - inm[4] + inm[5] + inm[6] + inm[7] - inm[8] + inm[9] + inm[10] - inm[11] + inm[12] - inm[13] - inm[14] - inm[15];
assign mid[3] = vmid[3] >= 0;
assign vmid[4] = - inm[0] - inm[1] - inm[2] + inm[3] + inm[4] + inm[5] + inm[6] + inm[7] + inm[8] + inm[9] - inm[10] + inm[11] - inm[12] - inm[13] + inm[14] - inm[15];
assign mid[4] = vmid[4] >= 0;
assign vmid[5] = - inm[0] + inm[1] - inm[2] - inm[3] - inm[4] + inm[5] + inm[6] - inm[7] - inm[8] + inm[9] - inm[10] + inm[11] - inm[12] - inm[13] + inm[14] - inm[15];
assign mid[5] = vmid[5] >= 0;
assign vmid[6] = - inm[0] + inm[1] + inm[2] + inm[3] + inm[4] - inm[5] - inm[6] - inm[7] + inm[8] - inm[9] + inm[10] - inm[11] - inm[12] + inm[13] - inm[14] + inm[15];
assign mid[6] = vmid[6] >= 0;
assign vmid[7] = - inm[0] - inm[1] - inm[2] + inm[3] + inm[4] + inm[5] - inm[6] - inm[7] + inm[8] - inm[9] + inm[10] - inm[11] - inm[12] - inm[13] - inm[14] - inm[15];
assign mid[7] = vmid[7] >= 0;
assign vmid[8] = + inm[0] + inm[1] + inm[2] + inm[3] - inm[4] + inm[5] - inm[6] - inm[7] - inm[8] - inm[9] - inm[10] - inm[11] - inm[12] - inm[13] - inm[14] - inm[15];
assign mid[8] = vmid[8] >= 0;
assign vmid[9] = + inm[0] + inm[1] - inm[2] + inm[3] - inm[4] - inm[5] - inm[6] - inm[7] + inm[8] + inm[9] + inm[10] - inm[11] - inm[12] - inm[13] - inm[14] - inm[15];
assign mid[9] = vmid[9] >= 0;
assign vmid[10] = + inm[0] - inm[1] + inm[2] + inm[3] + inm[4] - inm[5] - inm[6] - inm[7] - inm[8] + inm[9] - inm[10] + inm[11] - inm[12] - inm[13] + inm[14] + inm[15];
assign mid[10] = vmid[10] >= 0;
assign vmid[11] = + inm[0] + inm[1] - inm[2] - inm[3] + inm[4] - inm[5] + inm[6] - inm[7] - inm[8] + inm[9] - inm[10] + inm[11] - inm[12] + inm[13] + inm[14] - inm[15];
assign mid[11] = vmid[11] >= 0;
assign vmid[12] = + inm[0] - inm[1] + inm[2] - inm[3] - inm[4] + inm[5] + inm[6] + inm[7] - inm[8] + inm[9] - inm[10] + inm[11] + inm[12] + inm[13] - inm[14] + inm[15];
assign mid[12] = vmid[12] >= 0;
assign vmid[13] = + inm[0] + inm[1] + inm[2] - inm[3] + inm[4] + inm[5] - inm[6] - inm[7] - inm[8] - inm[9] + inm[10] - inm[11] - inm[12] + inm[13] - inm[14] + inm[15];
assign mid[13] = vmid[13] >= 0;
assign vmid[14] = + inm[0] + inm[1] - inm[2] + inm[3] - inm[4] + inm[5] - inm[6] - inm[7] - inm[8] - inm[9] - inm[10] - inm[11] + inm[12] + inm[13] - inm[14] + inm[15];
assign mid[14] = vmid[14] >= 0;
assign vmid[15] = - inm[0] - inm[1] + inm[2] + inm[3] - inm[4] + inm[5] + inm[6] + inm[7] + inm[8] + inm[9] - inm[10] - inm[11] - inm[12] - inm[13] + inm[14] - inm[15];
assign mid[15] = vmid[15] >= 0;
assign vmid[16] = + inm[0] + inm[1] - inm[2] + inm[3] + inm[4] - inm[5] - inm[6] - inm[7] - inm[8] + inm[9] - inm[10] + inm[11] - inm[12] - inm[13] + inm[14] - inm[15];
assign mid[16] = vmid[16] >= 0;
assign vmid[17] = + inm[0] - inm[1] - inm[2] + inm[3] + inm[4] - inm[5] + inm[6] - inm[7] - inm[8] - inm[9] - inm[10] - inm[11] + inm[12] - inm[13] + inm[14] - inm[15];
assign mid[17] = vmid[17] >= 0;
assign vmid[18] = - inm[0] - inm[1] - inm[2] - inm[3] + inm[4] - inm[5] + inm[6] + inm[7] + inm[8] + inm[9] - inm[10] + inm[11] + inm[12] + inm[13] + inm[14] + inm[15];
assign mid[18] = vmid[18] >= 0;
assign vmid[19] = + inm[0] - inm[1] + inm[2] + inm[3] + inm[4] + inm[5] - inm[6] - inm[7] - inm[8] + inm[9] - inm[10] - inm[11] + inm[12] - inm[13] - inm[14] + inm[15];
assign mid[19] = vmid[19] >= 0;
assign vmid[20] = + inm[0] - inm[1] - inm[2] - inm[3] - inm[4] - inm[5] + inm[6] + inm[7] + inm[8] + inm[9] + inm[10] + inm[11] + inm[12] - inm[13] + inm[14] - inm[15];
assign mid[20] = vmid[20] >= 0;
assign vmid[21] = + inm[0] - inm[1] + inm[2] - inm[3] - inm[4] - inm[5] - inm[6] + inm[7] + inm[8] + inm[9] + inm[10] + inm[11] - inm[12] + inm[13] + inm[14] + inm[15];
assign mid[21] = vmid[21] >= 0;
assign vmid[22] = + inm[0] - inm[1] - inm[2] + inm[3] - inm[4] - inm[5] - inm[6] - inm[7] + inm[8] - inm[9] + inm[10] - inm[11] + inm[12] + inm[13] - inm[14] + inm[15];
assign mid[22] = vmid[22] >= 0;
assign vmid[23] = + inm[0] - inm[1] + inm[2] - inm[3] + inm[4] + inm[5] + inm[6] + inm[7] - inm[8] + inm[9] - inm[10] - inm[11] + inm[12] + inm[13] - inm[14] + inm[15];
assign mid[23] = vmid[23] >= 0;
assign vmid[24] = + inm[0] - inm[1] - inm[2] - inm[3] + inm[4] + inm[5] - inm[6] + inm[7] + inm[8] + inm[9] + inm[10] + inm[11] - inm[12] + inm[13] - inm[14] + inm[15];
assign mid[24] = vmid[24] >= 0;
assign vmid[25] = + inm[0] - inm[1] + inm[2] + inm[3] + inm[4] + inm[5] - inm[6] + inm[7] - inm[8] + inm[9] + inm[10] - inm[11] + inm[12] - inm[13] - inm[14] - inm[15];
assign mid[25] = vmid[25] >= 0;
assign vmid[26] = + inm[0] + inm[1] - inm[2] + inm[3] + inm[4] - inm[5] - inm[6] - inm[7] - inm[8] + inm[9] + inm[10] + inm[11] - inm[12] - inm[13] + inm[14] - inm[15];
assign mid[26] = vmid[26] >= 0;
assign vmid[27] = + inm[0] + inm[1] - inm[2] - inm[3] - inm[4] + inm[5] - inm[6] - inm[7] + inm[8] - inm[9] + inm[10] + inm[11] + inm[12] + inm[13] - inm[14] + inm[15];
assign mid[27] = vmid[27] >= 0;
assign vmid[28] = - inm[0] - inm[1] - inm[2] + inm[3] + inm[4] - inm[5] + inm[6] - inm[7] + inm[8] - inm[9] + inm[10] - inm[11] + inm[12] - inm[13] - inm[14] + inm[15];
assign mid[28] = vmid[28] >= 0;
assign vmid[29] = - inm[0] - inm[1] + inm[2] - inm[3] - inm[4] + inm[5] - inm[6] + inm[7] + inm[8] + inm[9] - inm[10] + inm[11] - inm[12] - inm[13] + inm[14] - inm[15];
assign mid[29] = vmid[29] >= 0;
assign vmid[30] = - inm[0] + inm[1] - inm[2] + inm[3] + inm[4] - inm[5] + inm[6] - inm[7] + inm[8] - inm[9] - inm[10] + inm[11] - inm[12] + inm[13] + inm[14] + inm[15];
assign mid[30] = vmid[30] >= 0;
assign vmid[31] = - inm[0] + inm[1] - inm[2] - inm[3] + inm[4] - inm[5] + inm[6] - inm[7] + inm[8] + inm[9] - inm[10] - inm[11] - inm[12] - inm[13] - inm[14] - inm[15];
assign mid[31] = vmid[31] >= 0;
assign vmid[32] = - inm[0] + inm[1] - inm[2] + inm[3] + inm[4] - inm[5] + inm[6] + inm[7] - inm[8] - inm[9] - inm[10] - inm[11] - inm[12] + inm[13] + inm[14] + inm[15];
assign mid[32] = vmid[32] >= 0;
assign vmid[33] = - inm[0] - inm[1] - inm[2] + inm[3] + inm[4] + inm[5] + inm[6] + inm[7] + inm[8] + inm[9] - inm[10] + inm[11] - inm[12] + inm[13] + inm[14] - inm[15];
assign mid[33] = vmid[33] >= 0;
assign vmid[34] = - inm[0] - inm[1] - inm[2] - inm[3] + inm[4] + inm[5] + inm[6] + inm[7] + inm[8] - inm[9] - inm[10] - inm[11] + inm[12] - inm[13] + inm[14] - inm[15];
assign mid[34] = vmid[34] >= 0;
assign vmid[35] = + inm[0] - inm[1] + inm[2] - inm[3] + inm[4] + inm[5] + inm[6] + inm[7] - inm[8] + inm[9] - inm[10] + inm[11] + inm[12] - inm[13] + inm[14] + inm[15];
assign mid[35] = vmid[35] >= 0;
assign vmid[36] = - inm[0] - inm[1] - inm[2] + inm[3] - inm[4] - inm[5] + inm[6] + inm[7] + inm[8] - inm[9] + inm[10] - inm[11] - inm[12] + inm[13] - inm[14] + inm[15];
assign mid[36] = vmid[36] >= 0;
assign vmid[37] = + inm[0] + inm[1] + inm[2] - inm[3] - inm[4] - inm[5] - inm[6] - inm[7] + inm[8] - inm[9] - inm[10] - inm[11] + inm[12] + inm[13] - inm[14] + inm[15];
assign mid[37] = vmid[37] >= 0;
assign vmid[38] = + inm[0] - inm[1] - inm[2] + inm[3] + inm[4] - inm[5] + inm[6] + inm[7] - inm[8] + inm[9] + inm[10] - inm[11] + inm[12] + inm[13] - inm[14] + inm[15];
assign mid[38] = vmid[38] >= 0;
assign vmid[39] = + inm[0] + inm[1] - inm[2] - inm[3] - inm[4] + inm[5] + inm[6] - inm[7] - inm[8] + inm[9] - inm[10] + inm[11] + inm[12] - inm[13] + inm[14] - inm[15];
assign mid[39] = vmid[39] >= 0;assign out[0*SumL+:SumL] = + mid[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid_n[4] + mid_n[5] + mid[6] + mid_n[7] + mid_n[8] + mid[9] + mid_n[10] + mid[11] + mid[12] + mid_n[13] + mid_n[14] + mid_n[15] + mid_n[16] + mid_n[17] + mid[18] + mid[19] + mid[20] + mid[21] + mid[22] + mid_n[23] + mid[24] + mid_n[25] + mid_n[26] + mid[27] + mid[28] + mid_n[29] + mid[30] + mid[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid_n[35] + mid[36] + mid[37] + mid[38] + mid_n[39];
assign out[1*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid[2] + mid[3] + mid[4] + mid[5] + mid_n[6] + mid_n[7] + mid[8] + mid_n[9] + mid[10] + mid_n[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid_n[16] + mid[17] + mid[18] + mid[19] + mid[20] + mid[21] + mid_n[22] + mid[23] + mid_n[24] + mid[25] + mid_n[26] + mid_n[27] + mid_n[28] + mid[29] + mid[30] + mid[31] + mid[32] + mid[33] + mid[34] + mid[35] + mid_n[36] + mid_n[37] + mid_n[38] + mid[39];
assign out[2*SumL+:SumL] = + mid_n[0] + mid[1] + mid[2] + mid[3] + mid[4] + mid[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid_n[9] + mid[10] + mid[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid_n[16] + mid[17] + mid_n[18] + mid[19] + mid_n[20] + mid_n[21] + mid_n[22] + mid_n[23] + mid_n[24] + mid[25] + mid[26] + mid_n[27] + mid_n[28] + mid_n[29] + mid[30] + mid[31] + mid[32] + mid_n[33] + mid[34] + mid_n[35] + mid_n[36] + mid_n[37] + mid[38] + mid[39];
assign out[3*SumL+:SumL] = + mid_n[0] + mid[1] + mid[2] + mid[3] + mid[4] + mid[5] + mid[6] + mid[7] + mid_n[8] + mid[9] + mid_n[10] + mid[11] + mid_n[12] + mid[13] + mid_n[14] + mid_n[15] + mid_n[16] + mid[17] + mid[18] + mid[19] + mid[20] + mid_n[21] + mid_n[22] + mid[23] + mid[24] + mid[25] + mid[26] + mid_n[27] + mid[28] + mid_n[29] + mid[30] + mid[31] + mid_n[32] + mid[33] + mid[34] + mid_n[35] + mid[36] + mid_n[37] + mid[38] + mid_n[39];
assign out[4*SumL+:SumL] = + mid[0] + mid[1] + mid_n[2] + mid[3] + mid_n[4] + mid_n[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid[9] + mid_n[10] + mid_n[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid[16] + mid_n[17] + mid[18] + mid_n[19] + mid[20] + mid[21] + mid[22] + mid_n[23] + mid_n[24] + mid_n[25] + mid[26] + mid[27] + mid_n[28] + mid[29] + mid[30] + mid_n[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid[35] + mid_n[36] + mid_n[37] + mid_n[38] + mid[39];
assign out[5*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid[4] + mid_n[5] + mid[6] + mid[7] + mid[8] + mid[9] + mid[10] + mid[11] + mid[12] + mid[13] + mid[14] + mid_n[15] + mid_n[16] + mid_n[17] + mid_n[18] + mid_n[19] + mid_n[20] + mid[21] + mid_n[22] + mid[23] + mid[24] + mid_n[25] + mid[26] + mid[27] + mid_n[28] + mid[29] + mid_n[30] + mid_n[31] + mid[32] + mid[33] + mid_n[34] + mid[35] + mid_n[36] + mid_n[37] + mid[38] + mid_n[39];
assign out[6*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid[3] + mid_n[4] + mid_n[5] + mid_n[6] + mid_n[7] + mid[8] + mid[9] + mid[10] + mid[11] + mid_n[12] + mid[13] + mid[14] + mid_n[15] + mid_n[16] + mid_n[17] + mid_n[18] + mid_n[19] + mid_n[20] + mid_n[21] + mid[22] + mid_n[23] + mid[24] + mid[25] + mid[26] + mid[27] + mid_n[28] + mid_n[29] + mid_n[30] + mid_n[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid_n[35] + mid[36] + mid[37] + mid[38] + mid_n[39];
assign out[7*SumL+:SumL] = + mid_n[0] + mid[1] + mid[2] + mid_n[3] + mid[4] + mid[5] + mid[6] + mid_n[7] + mid_n[8] + mid_n[9] + mid[10] + mid_n[11] + mid_n[12] + mid_n[13] + mid_n[14] + mid[15] + mid[16] + mid[17] + mid[18] + mid_n[19] + mid_n[20] + mid_n[21] + mid_n[22] + mid[23] + mid[24] + mid_n[25] + mid[26] + mid_n[27] + mid_n[28] + mid_n[29] + mid[30] + mid_n[31] + mid[32] + mid_n[33] + mid[34] + mid[35] + mid[36] + mid_n[37] + mid[38] + mid_n[39];
assign out[8*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid_n[4] + mid_n[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid_n[9] + mid_n[10] + mid_n[11] + mid[12] + mid[13] + mid[14] + mid[15] + mid_n[16] + mid_n[17] + mid[18] + mid[19] + mid_n[20] + mid[21] + mid[22] + mid[23] + mid_n[24] + mid[25] + mid_n[26] + mid[27] + mid[28] + mid[29] + mid[30] + mid_n[31] + mid[32] + mid[33] + mid_n[34] + mid[35] + mid[36] + mid[37] + mid[38] + mid_n[39];
assign out[9*SumL+:SumL] = + mid_n[0] + mid_n[1] + mid_n[2] + mid_n[3] + mid[4] + mid[5] + mid_n[6] + mid_n[7] + mid_n[8] + mid[9] + mid[10] + mid_n[11] + mid[12] + mid_n[13] + mid_n[14] + mid_n[15] + mid_n[16] + mid[17] + mid[18] + mid_n[19] + mid[20] + mid[21] + mid_n[22] + mid[23] + mid[24] + mid[25] + mid[26] + mid[27] + mid_n[28] + mid[29] + mid_n[30] + mid_n[31] + mid_n[32] + mid_n[33] + mid_n[34] + mid[35] + mid_n[36] + mid_n[37] + mid_n[38] + mid_n[39];

integer j;
initial begin
    #10
    for(j=0;j<M;j=j+1)
        $display("vmid %d %d",j,vmid[j]);
    /* $display("mid %b",mid); */
end

endmodule
