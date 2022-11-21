module bnorm(input [175:0] a, output [15:0] o);
assign o[0] = $signed( a[10:0]) > -220;
assign o[1] = $signed( a[21:11]) > 114;
assign o[2] = $signed( a[32:22]) > -45;
assign o[3] = $signed( a[43:33]) > 196;
assign o[4] = $signed( a[54:44]) > -183;
assign o[5] = $signed( a[65:55]) > 299;
assign o[6] = $signed( a[76:66]) > 435;
assign o[7] = $signed( a[87:77]) > 102;
assign o[8] = $signed( a[98:88]) > -267;
assign o[9] = $signed( a[109:99]) > 236;
assign o[10] = $signed( a[120:110]) > -75;
assign o[11] = $signed( a[131:121]) > 91;
assign o[12] = $signed( a[142:132]) > 203;
assign o[13] = $signed( a[153:143]) > 154;
assign o[14] = $signed( a[164:154]) > 22;
assign o[15] = $signed( a[175:165]) > 646;
endmodule
