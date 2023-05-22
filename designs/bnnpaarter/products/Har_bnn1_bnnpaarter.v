
















module Har_bnn1_bnnpaarter #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 5424'h001b00260001001b002600000017005d00010022005c0001001e005a0001001700580001001900570001001900550001001000540001003f005300010013005100010020004e0001001e004c0001002f004b0001001b004a0001001f00490001002400470001002700460001002600450001003000440001001600420001001f00400001002d003d0001003100390001001c00320001001b00310001001a002a0001003b00520000002e004d0000003e00480000002900430000002000410000000e003c0000002d003a0000001100380000002800370000002500350000001500350000002000340000000d00340000001400320000001000300000000c002f0000001d002e00000027002a0000001b00290000001300290000001000270000001d00250000000d00250000000f00230000001d00220000001500220000001900210000001f002000000019001e00000016001e0000000c001e0000001b001d0000000f001c00000012001a0000000f00180000001300140000001500220001000f001c0001000f00180001001900240000001300200000001500190000000f00170000001b002b0001000d001c00010016002c0000001500280000000c00240000000f001d00000019001a00000013001a0000001200160000001000110000000e001c00010014001500010012001f00000016002300010012002100010011001700010016001a0000000f00190000001500180001000e00110001000c000d0000001300140001000c00180001000f00130000000d00100000001100170000001000140000001000120001000e001100000003000900010005000800000004000a0001000200060000000e000f00000007000b0000000000010000000c000d00010007000b00010000000100010002000600010004000a0000000500080001000300090000 ;
localparam YMAP = 1280'h0000005b000100640000006600010077000100780001006e0000005e000000360000003300010068000100740000007c0001004f0000006f0001007500010036000000500000006d00010059000100560000007900010065000000670000007100000062000000610000006c000000630000006b000100720001007b0001003300010073000000690001006a000000760000005f0000007a0001007000000060;
localparam ADDCNT = $bits(PAAR0) / 48;
localparam FULLCNT = ADDCNT + FEAT_CNT;
localparam Weights1 = 240'b111001111101100000101111100101100010100011010110111111001010010101011010011101001110011111011110001101011100001000101010010101000110011010101101110010110100110101111111011000000011000110001111110000010111001001000101000010011100001111000100 ;
localparam WIDTH = 320'h06060607070607070707070807070707070707070707070707080707070707070707070708070707;
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
    localparam subad = PAAR0[i*48];
    localparam op1 = PAAR0[i*48+16+:16];
    localparam op2 = PAAR0[i*48+32+:16];
    localparam nodeloc = FEAT_CNT + i;
    if(subad)
        assign node[nodeloc] = node[op1] - node[op2];
    else
        assign node[nodeloc] = node[op1] + node[op2];
end
for(i=0;i<HIDDEN_CNT;i=i+1) begin
    localparam ymap = YMAP[i*32+:16];
    localparam signy = YMAP[i*32+16];
    if(signy)
        assign hidden[i] = node[ymap] >= 0;
    else
        assign hidden[i] = node[ymap] < 0;
    initial begin
        #20
        $display("%b, %d | %d", signy, ymap, node[ymap]);
    end
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
