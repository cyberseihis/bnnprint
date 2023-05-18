
















module pendigits_bnn1_bnnpaar #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 6336'h00a800ca00b900c8009900c300a600c2009500c1009a00c000a000bf00a300be009600bd008200bc008700bb009800ba008f00b8008000b5007100b4008900b1007f00b0008800ae009d00ac007b00ab009400aa009000a9008600a7006700a5007000a4008c00a2005f00a10076009f0097009e007d009c005f009b0072009300830092007c0091005a008e0079008d0085008b0057008a006f0084006600810060007e004f007a007000780054007700630075005900730052007300380072003400710058006f0037006e002d006e0045006c0035006c006a006b0041006b005c006a005b006900590069005e006700480066005d0063005400610045006100350060004a005e0039005d0049005c0033005b004d005a004f0058005100570041005600320056002b005500460054004e00530048005000410050003f00500044004f0020004c002b004b0038004a003d0049002400460042004500220045003f004300090040003a003e0035003d0036003c0029003c003a003b003700390029003900150036002d003500330034002d003200260032002f003100000031002a002e0027002e0026002e0027002d000c002d0015002a0019002600030018000100070064006d004b00680049006500420062003700550027005300480052004c0051002c004e002e004d003e004a0033004700250047003400460008004200220041003c0040002300400021003e0030003d0015003d003b003c0005003a0000003a0036003800050030001c002d00090029000c00200013001c0010001800350044001800430024003f002e003b00290038003600370019002e0028002b0021002800190022000d001f002c003900230034002a0033001c002f0026002d000b001e000f001d000000050015003000090027000e001b000800130006000a00250032000c002f0027002c00110017000300310020002b0016001a00020014000200040029002a0020002500190028000c0026001200140013002300150022000a001600180024000500210003001c00080010000d000f000b000e001b001e00010017000000090006001a0004001200070011001d001f ;
localparam YMAP = 640'h00cb00af00dd00d800c7007400c600e400d200c400c900e100e200b200c500e300d500de00df00d700cd00d400e500b300cc00cf00e000d600b700db00d000da00d100ce00d300b600ad007400dc00d9;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 400'b0000100000101111101101100001011000110000011110110111101011101100111100000000000001011101010001011000011110000100011101100111000000001111010000000110111100001000010010110010110110100000011111111101000010001000011011000111010110000010000010110101011011010111100111100010101011111110110001011100011000001010100011000011111010001111111000101011111010000101001111000111000011011001011111000001101001000001 ;
localparam WIDTH = 320'h07080808080808080808080708070808080808080708080808080707070708080807080808080708;
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
    localparam nodeloc = (2 * FEAT_CNT) + 1;
    assign node[nodeloc] = node[op1] + node[op2];
end
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    assign hidden[i] = node[YMAP[i*16+:16]] >= 0;
end
endgenerate

generate
for(i=0;i<CLASS_CNT;i=i+1) begin
    localparam Wneur = Weights1[i*HIDDEN_CNT+:HIDDEN_CNT];
    reg unsigned [SUM_BITS-1:0] tmpscore;
    always @ (*) begin
        tmpscore = 0;
        for(j=0;j<HIDDEN_CNT;j=j+1) begin
        if(Wneur[j])
            tmpscore = tmpscore + hidden[j];
        else 
            tmpscore = tmpscore + hidden_n[j];
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
