module pendigit_draft(input [111:0] activations, output [49:0] popcounts);
wire signed [10:0] sums [15:0];
wire [15:0] normalised;
assign sums[0] = + activations[6:0] + activations[13:7] - activations[20:14] - activations[27:21] - activations[34:28] - activations[41:35] - activations[48:42] - activations[55:49] - activations[62:56] - activations[69:63] + activations[76:70] - activations[83:77] - activations[90:84] - activations[97:91] - activations[104:98] - activations[111:105];
assign normalised[0] = -220 < sums[0];
assign sums[1] = + activations[6:0] + activations[13:7] - activations[20:14] - activations[27:21] - activations[34:28] - activations[41:35] - activations[48:42] + activations[55:49] + activations[62:56] - activations[69:63] + activations[76:70] + activations[83:77] + activations[90:84] + activations[97:91] + activations[104:98] - activations[111:105];
assign normalised[1] = 114 < sums[1];
assign sums[2] = - activations[6:0] + activations[13:7] - activations[20:14] + activations[27:21] + activations[34:28] + activations[41:35] - activations[48:42] - activations[55:49] + activations[62:56] - activations[69:63] + activations[76:70] + activations[83:77] - activations[90:84] + activations[97:91] - activations[104:98] + activations[111:105];
assign normalised[2] = -45 < sums[2];
assign sums[3] = + activations[6:0] - activations[13:7] - activations[20:14] - activations[27:21] + activations[34:28] - activations[41:35] + activations[48:42] + activations[55:49] + activations[62:56] + activations[69:63] + activations[76:70] - activations[83:77] + activations[90:84] + activations[97:91] - activations[104:98] + activations[111:105];
assign normalised[3] = 196 < sums[3];
assign sums[4] = + activations[6:0] - activations[13:7] + activations[20:14] - activations[27:21] - activations[34:28] + activations[41:35] - activations[48:42] + activations[55:49] - activations[62:56] - activations[69:63] + activations[76:70] + activations[83:77] - activations[90:84] + activations[97:91] - activations[104:98] + activations[111:105];
assign normalised[4] = -183 < sums[4];
assign sums[5] = - activations[6:0] + activations[13:7] - activations[20:14] + activations[27:21] + activations[34:28] + activations[41:35] + activations[48:42] - activations[55:49] + activations[62:56] - activations[69:63] + activations[76:70] + activations[83:77] - activations[90:84] + activations[97:91] + activations[104:98] + activations[111:105];
assign normalised[5] = 299 < sums[5];
assign sums[6] = + activations[6:0] + activations[13:7] + activations[20:14] + activations[27:21] - activations[34:28] + activations[41:35] - activations[48:42] + activations[55:49] + activations[62:56] + activations[69:63] + activations[76:70] + activations[83:77] + activations[90:84] - activations[97:91] - activations[104:98] - activations[111:105];
assign normalised[6] = 435 < sums[6];
assign sums[7] = + activations[6:0] + activations[13:7] + activations[20:14] + activations[27:21] + activations[34:28] + activations[41:35] - activations[48:42] - activations[55:49] - activations[62:56] - activations[69:63] - activations[76:70] - activations[83:77] - activations[90:84] + activations[97:91] + activations[104:98] + activations[111:105];
assign normalised[7] = 102 < sums[7];
assign sums[8] = + activations[6:0] + activations[13:7] - activations[20:14] - activations[27:21] - activations[34:28] - activations[41:35] - activations[48:42] - activations[55:49] - activations[62:56] + activations[69:63] - activations[76:70] + activations[83:77] - activations[90:84] - activations[97:91] + activations[104:98] - activations[111:105];
assign normalised[8] = -267 < sums[8];
assign sums[9] = + activations[6:0] - activations[13:7] + activations[20:14] - activations[27:21] + activations[34:28] + activations[41:35] + activations[48:42] + activations[55:49] - activations[62:56] + activations[69:63] + activations[76:70] + activations[83:77] - activations[90:84] + activations[97:91] + activations[104:98] + activations[111:105];
assign normalised[9] = 236 < sums[9];
assign sums[10] = - activations[6:0] + activations[13:7] - activations[20:14] - activations[27:21] - activations[34:28] + activations[41:35] + activations[48:42] + activations[55:49] - activations[62:56] + activations[69:63] - activations[76:70] + activations[83:77] - activations[90:84] - activations[97:91] + activations[104:98] - activations[111:105];
assign normalised[10] = -75 < sums[10];
assign sums[11] = - activations[6:0] - activations[13:7] - activations[20:14] + activations[27:21] + activations[34:28] + activations[41:35] + activations[48:42] + activations[55:49] - activations[62:56] - activations[69:63] - activations[76:70] - activations[83:77] - activations[90:84] - activations[97:91] + activations[104:98] - activations[111:105];
assign normalised[11] = 91 < sums[11];
assign sums[12] = - activations[6:0] + activations[13:7] + activations[20:14] - activations[27:21] - activations[34:28] + activations[41:35] + activations[48:42] + activations[55:49] + activations[62:56] - activations[69:63] + activations[76:70] + activations[83:77] - activations[90:84] + activations[97:91] + activations[104:98] - activations[111:105];
assign normalised[12] = 203 < sums[12];
assign sums[13] = + activations[6:0] + activations[13:7] - activations[20:14] - activations[27:21] - activations[34:28] - activations[41:35] - activations[48:42] - activations[55:49] + activations[62:56] + activations[69:63] - activations[76:70] + activations[83:77] + activations[90:84] + activations[97:91] + activations[104:98] + activations[111:105];
assign normalised[13] = 154 < sums[13];
assign sums[14] = + activations[6:0] - activations[13:7] + activations[20:14] - activations[27:21] - activations[34:28] + activations[41:35] + activations[48:42] + activations[55:49] + activations[62:56] + activations[69:63] - activations[76:70] + activations[83:77] + activations[90:84] - activations[97:91] + activations[104:98] - activations[111:105];
assign normalised[14] = 22 < sums[14];
assign sums[15] = + activations[6:0] + activations[13:7] + activations[20:14] + activations[27:21] + activations[34:28] + activations[41:35] + activations[48:42] + activations[55:49] + activations[62:56] + activations[69:63] + activations[76:70] - activations[83:77] + activations[90:84] - activations[97:91] - activations[104:98] - activations[111:105];
assign normalised[15] = 646 < sums[15];

assign popcounts[4:0] = !normalised[0] + normalised[1] + !normalised[2] + normalised[3] + normalised[4] + normalised[5] + !normalised[6] + !normalised[7] + !normalised[8] + !normalised[9] + !normalised[10] + !normalised[11] + !normalised[12] + normalised[13] + !normalised[14] + !normalised[15];
assign popcounts[9:5] = normalised[0] + !normalised[1] + !normalised[2] + normalised[3] + normalised[4] + !normalised[5] + !normalised[6] + !normalised[7] + !normalised[8] + normalised[9] + normalised[10] + normalised[11] + normalised[12] + !normalised[13] + normalised[14] + !normalised[15];
assign popcounts[14:10] = !normalised[0] + !normalised[1] + !normalised[2] + !normalised[3] + !normalised[4] + !normalised[5] + !normalised[6] + normalised[7] + normalised[8] + !normalised[9] + normalised[10] + normalised[11] + !normalised[12] + !normalised[13] + normalised[14] + !normalised[15];
assign popcounts[19:15] = !normalised[0] + !normalised[1] + normalised[2] + normalised[3] + !normalised[4] + !normalised[5] + normalised[6] + !normalised[7] + !normalised[8] + !normalised[9] + !normalised[10] + normalised[11] + !normalised[12] + !normalised[13] + !normalised[14] + normalised[15];
assign popcounts[24:20] = !normalised[0] + normalised[1] + normalised[2] + !normalised[3] + !normalised[4] + !normalised[5] + normalised[6] + !normalised[7] + normalised[8] + !normalised[9] + normalised[10] + !normalised[11] + normalised[12] + normalised[13] + normalised[14] + !normalised[15];
assign popcounts[29:25] = !normalised[0] + !normalised[1] + normalised[2] + !normalised[3] + normalised[4] + normalised[5] + normalised[6] + normalised[7] + normalised[8] + normalised[9] + normalised[10] + !normalised[11] + !normalised[12] + normalised[13] + !normalised[14] + normalised[15];
assign popcounts[34:30] = normalised[0] + normalised[1] + !normalised[2] + !normalised[3] + normalised[4] + !normalised[5] + normalised[6] + normalised[7] + normalised[8] + normalised[9] + !normalised[10] + normalised[11] + !normalised[12] + !normalised[13] + !normalised[14] + !normalised[15];
assign popcounts[39:35] = !normalised[0] + !normalised[1] + normalised[2] + !normalised[3] + !normalised[4] + normalised[5] + !normalised[6] + normalised[7] + !normalised[8] + normalised[9] + normalised[10] + normalised[11] + normalised[12] + !normalised[13] + !normalised[14] + !normalised[15];
assign popcounts[44:40] = !normalised[0] + !normalised[1] + normalised[2] + normalised[3] + normalised[4] + !normalised[5] + !normalised[6] + normalised[7] + !normalised[8] + normalised[9] + !normalised[10] + !normalised[11] + !normalised[12] + normalised[13] + normalised[14] + !normalised[15];
assign popcounts[49:45] = !normalised[0] + normalised[1] + !normalised[2] + normalised[3] + normalised[4] + !normalised[5] + normalised[6] + !normalised[7] + !normalised[8] + normalised[9] + normalised[10] + !normalised[11] + !normalised[12] + !normalised[13] + normalised[14] + normalised[15];
endmodule
