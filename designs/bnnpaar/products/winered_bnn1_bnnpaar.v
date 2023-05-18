
















module winered_bnn1_bnnpaar #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 4192'h00550079004e0073004400710043006d0044006c0043006b0057006a00410069004d006800450067005100660049006500540064003f006300380062003e0061005000600035005f0034005e004a005d0047005c003d005b0053005a004c0059003300580042005600400052003d004f003f004c004a004b002e004b00300049002f0048002200480033004700410046003e0046003b004500330042001c004200330041003c0040003400400026003f001d003e0025003d0030003b0029003b002a003a00340039002c003800200038003200370030003700290037002f00360030003500160034002a0031002a002f0029002f0016002f0027002e0029002d001f002d0018002d0022002c00250028000700270023002600230025001d00250020002400210022000b001f001600190016003c002b003a00070039001c0036001f00350021002d002200290012002700180026001d001f001b003200020031002a002e0028002c002100280019002700240026002000230017002300000021001b001e0017001d0004000c0019002b00240025001800220000001f0007001e00100013001d00200012001e000200190001000f000f001a000d0018000c000f000b001b0004001a0003000a000e001500060014000900110017001c00050013000300150005000800000016001100140006000900020012000c000d0007000b00010004000a000e00080010 ;
localparam YMAP = 640'h007f0090007400760080008c007e008f0098009400860078007b008100890097007a008d0096008500840077007c00920072006e00910075007d008b0070009300950082006f008e008a008800870083;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 240'b101011110101010111101111010101000101111001101110110011111110010011110100100011101000101011111101111001010101001011000101101011100011011000100010000100100000001111000110100000011011100000011101001111010010001011110000001101110000010000111001 ;
localparam WIDTH = 320'h07070707070607070706060706070707070707070707070707060707060707070706060707070707;
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
