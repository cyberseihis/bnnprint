
















module Har_tnn1_tnnpaar #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 4320'h006e0089004a007d004e0079005e0078004f007600400075004800740053007200570071004400700060006f003a006d0046006c0061006b003e006a0050006900560068003000670033006500490064005c006300430062004b005f0033005d002b005a00320059003c005800290055003900540037005200470051003f004d00360045002a0042002400410030003f0034003e0036003d0026003d002c003c0021003b0020003b0020003a00240039002f003800280038001c00370032003500310035003100340025002f002a002e001a002e0026002d0022002d0010002d000f002b000e002b001c002a0027002900220029001e0027001c002700210026001f0025001a0025001700250023002400080024001600230018002100170021001c002000050020000300200004001e0000001e0012001d0019001b000e0019000e0018000d001800100017000d0016000c0014000d00120010001100010010000a000c0008000c0005000900000009000500070002000700000004000b002c001b0028000f0023000c0022001a001f0008001d0015001c0012001900020018000400170012001300050013000c0011000300100001000e0002000d0007000b00000007001e001f0014001d0015001800150017000f0016000a0014000100110008000b0002001b0016001a001100190005000b00040009000d000e00060013000a000f000300090000000800100015000300170001000c00060007 ;
localparam YMAP = 640'h0090007e008c008500960097009c008a009400820099009d0080008d009a007f0092007a00660088008e0077008b0073005b008100910084007c0098009e0083009b007b009500860087004c0093008f;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 240'b100000010000110000000010001010000000100100000001000000000000000001011001001000000000010110000001001000110000000000010001000000010000101100000110000001000100001000000100000000010001010001010100010000000000010000000011000100100010010001000000 ;
localparam WNNZ = 240'b110010010010110010000110001010000000100101001001101000100000010001011001001100000100010110100001001001110000100000010011000000110000111101100110001001000100001100011110101000010101010101011100011000000001010101010111010100110110010001000000;
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
localparam INDEX_BITS = $clog2(FEAT_CNT+1)+FEAT_BITS;
wire signed [FEAT_BITS:0] feature_array [FEAT_CNT-1:0];
wire [HIDDEN_CNT-1:0] hidden;
wire [HIDDEN_CNT-1:0] hidden_n;
wire [CLASS_CNT*SUM_BITS-1:0] scores; 
wire [SUM_BITS-1:0] scorarr [CLASS_CNT-1:0];
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

function [7:0] zerocnt(input integer k);
    integer i,j;
    reg [HIDDEN_CNT-1:0] neur1;
    begin
        i = 0;
        neur1 = WNNZ[k*HIDDEN_CNT+:HIDDEN_CNT];
        for(j=0;j<HIDDEN_CNT;j=j+1)
            i = i + !(neur1[j]);
        zerocnt = i;
    end
endfunction

function [7:0] minzc(input integer k);
    integer i,j,h;
    begin
        i = HIDDEN_CNT;
        for(j=0;j<CLASS_CNT;j=j+1) begin
            h = zerocnt(j);
            if(h<i)
                i = h;
        end
        minzc = i;
    end
endfunction

localparam MINZC = minzc(0);

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
    assign scores[i*SUM_BITS+:SUM_BITS] = 2*tmpscore + zerocnt(i) - MINZC;
    /* assign scorarr[i] = 2*tmpscore + zerocnt(i) - MINZC; */
end
endgenerate

argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
