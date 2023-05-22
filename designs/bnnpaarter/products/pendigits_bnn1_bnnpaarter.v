
















module pendigits_bnn1_bnnpaarter #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 6960'h001600470001001600470000005a008000010029007f00010021007d0001001c007b0001003000790001001400780001002e00770001001900760001004900750001006d00740001001f007200010034007100010035006f00010036006e00010025006b0001001f00680001003300670001002a00660001004f006400010061006200010056005d00010031005c0001003e005900010037005300010013004b0001002b004a0001002000480001001900400001002f00370001004600700000003d006a00000038006500000054006300000039006000000033005f00000031005e0000002f005b0000002c005800000028005700000027005500000023005200000021005100000021005000000024004e00000024004d00000025004c00000044004500000027004500000027004200000016004200000016004000000033003e0000001d003b00000035003a00000017003a0000002f00390000002400380000001c00360000001a00360000003100340000001f00340000002300320000001e003100000020003000000025002f0000001e002e00000019002d0000002a002b00000028002b0000001f002b0000001b00270000002000250000001a00250000001e00240000001700240000001700210000001b002000000015001f0000001b001c0000001700180000004400460001003b003d0001001b002c0001001700370000002700350000002c00300000001f00300000001f002d00010028002c0001001600230001001a001d0001003f004100000022003c0000002a00320000001f002d0000001300290000001700270000000c002600000009001e00000013001c0000001a00250001001c002b0000001e002100000024002a00000019001b00000017002e00000015002100010014002800000017001900000011001d00010016002900000013001e00000011001d0000002000230001000c00260001001600180000001b001c0001000900220001000d000f0001001300150000000100070000001800190000001600180001000900120001000b000e00010000000800000017001a0000001100140001000c001000010006000a0000000200050001001100140000001300150001000300040001000900120000000c001000000003000400000002000500000006000a0001000000080001000b000e0000000d000f0000000100070001 ;
localparam YMAP = 1280'h00010082000000920000009c0001008a00010099000100430001008e00000096000000970001009f00010098000000730001009500010088000000a00001009d00000083000000930001008d0001007e000000810001008f0000009a00000085000100910000009b0001008c00000084000000900000009e0001008b000000690000009400000086000000870001007a00000089000100430001006c0000007c;
localparam ADDCNT = $bits(PAAR0) / 48;
localparam FULLCNT = ADDCNT + FEAT_CNT;
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
endgenerate

integer j;
generate
for(i=0;i<ADDCNT;i=i+1) begin
    localparam adsub = PAAR0[i*48];
    localparam op1 = PAAR0[i*48+16+:16];
    localparam op2 = PAAR0[i*48+32+:16];
    localparam nodeloc = FEAT_CNT + i;
    if(adsub)
        assign node[nodeloc] = node[op1] + node[op2];
    else
        assign node[nodeloc] = node[op1] - node[op2];
end
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    localparam ymap = YMAP[i*32+:16];
    localparam signy = YMAP[i*32+16];
    if(signy)
        assign hidden[i] = node[ymap] >= 0;
    else
        assign hidden[i] = node[ymap] < 0;
end
endgenerate

initial begin
    #10
    for(j=0;j<FULLCNT;j=j+1) begin
        $display("%d | %d | %b, %d, %d", j, node[j], PAAR0[(j- FEAT_CNT )*48],  PAAR0[(j-FEAT_CNT)*48+16+:16], PAAR0[(j-FEAT_CNT)*48+32+:16]);
    end
end

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
