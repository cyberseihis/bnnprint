
















module pendigits_tnn1_tnnpaar #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 5952'h009d00bc009200b9008300b6008e00b5008f00b4008600b3009f00b0007f00af009900ae008800ad009400ac007300ab008700aa008000a9006900a7005e00a4007400a3008100a2007e00a1008900a00056009c0056009b0095009a00520098006d00970065009600820093004e0091007900900055008d006e008c006b008b0066008500750084005e007d005a007c0062007b004e007a0049007800590077004200760061007200510071005200700058006f0055006c003b006a005d006800500067003900640051006300490060002d0060005b005d0059005c0036005c0044005b0057005a0029005800400057004b005300410053003a0050004d004f0031004f0039004d0043004c0039004c003c004b003e0048003d00480045004600400046003900450037004400380043000a0042002600410021004100240040003c003f0035003f0033003f0036003c001f003800280037003400350032003300010032002e002f0029002f001e002f0020002e000b002e0021002d0006002c0015002b001b0028001b0027002100260011002600030026002300250023002400190022000b002100070021000a0020000400200018001f0001001e001b001d0011001d0013001b0016001a0007001900050018000900170009000f0009000c000600090054005f003e004a00380047002b003d0035003b001c003a001d003700170036002a0034001c003400200031001c0031002c00300012002a00250029000400280019002600080024000400240014002300030023000d001f0005001b0006001a0002001a00000016000a001500060014000b0013001000120007000800090033002f00320011002e000e0025001400210003000e0004000c0002000a00220030002a002c000f002b00200029000600100018002d0016002800250026000100140020002400210023000200050004001a0008001100070009001300220012001500000027000c0018001b001e000300190010001c00010017000b000e000d000f001d001f ;
localparam YMAP = 640'h00c000c200c300cb00b200b800b700d700d800cd00c500d100d600d3009e00c400a500d500d9008a00be00ce00c600bf00a800d000b100a600cf00d200c900bd00c700bb00cc00c100ca00c800ba00d4;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 400'b0000000111000000011000100000000001001000000001010101101010000101011000000000000000000000000110101010000001010000000101000000000000000011000111010000110011100010100000000100010101000010010000001000001010001010101110000010000010001100000010000000000000000000110010001001001001010110100000000000001010000000110110010001010100000011000000001000001011010001000000000000000000001000000010000000010010001010 ;
localparam WNNZ = 400'b0010000111000010111010111001000011111000101011010111111110100111111010010101000000010000101110111010000001010000110111010010010100001011111111111101110111100010100010001100010101000010110101101000011110001011111111001111101011101100001011000000000011110000111010001101011101111111100000000101001010011000111110011111111100001011000101001100111011010111111000111000000100101001110011100101110110111110;
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
localparam INDEX_BITS = $clog2(FEAT_CNT+1)+FEAT_BITS;
wire signed [FEAT_BITS:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire [HIDDEN_CNT-1:0] hidden_n;
wire [CLASS_CNT*SUM_BITS-1:0] scores; 
assign hidden_n = ~hidden;

wire signed [INDEX_BITS:0] node [FULLCNT-1:0];

genvar i;
generate
    for(i=0;i<FEAT_CNT;i=i+1)
        assign feature_array[i] = {1'b0,features[i*FEAT_BITS+:FEAT_BITS]};
    for(i=0;i<FEAT_CNT;i=i+1)
        assign node[i] = feature_array[i];
    for(i=0;i<FEAT_CNT;i=i+1)
        assign node[FEAT_CNT+i] = -feature_array[i];
endgenerate

integer j;
generate
for(i=0;i<ADDCNT;i=i+1) begin
    localparam op1 = PAAR0[i*32+:16];
    localparam op2 = PAAR0[i*32+16+:16];
    localparam nodeloc = (2 * FEAT_CNT) + i;
    assign node[nodeloc] = node[op1] + node[op2];
end
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    assign hidden[i] = node[YMAP[i*16+:16]] >= 0;
end
endgenerate

/* initial begin */
/*     #10 */
/*     for(j=0;j<FULLCNT;j=j+1) */
/*         $display("%d | %d", j, node[j]); */
/* end */

generate
for(i=0;i<CLASS_CNT;i=i+1) begin
    localparam Wneur = Weights1[i*HIDDEN_CNT+:HIDDEN_CNT];
    localparam Wuse = WNNZ[i*HIDDEN_CNT+:HIDDEN_CNT];
    reg unsigned [SUM_BITS-1:0] tmpscore;
    always @ (*) begin
        tmpscore = 0;
        for(j=0;j<HIDDEN_CNT;j=j+1) begin
        if(Wuse[j]) begin
            if(Wneur[j])
                tmpscore = tmpscore + hidden[j];
            else 
                tmpscore = tmpscore + hidden_n[j];
        end
        end
    end
    assign scores[i*SUM_BITS+:SUM_BITS] = tmpscore;
end
endgenerate

argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
