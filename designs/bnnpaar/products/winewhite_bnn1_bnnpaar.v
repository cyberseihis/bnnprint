
















module winewhite_bnn1_bnnpaar #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 4640'h006d008d0068008b0067008900630088005f008600560084006000800055007f0048007d0046007a0064007800650077004c0076004b00750058007200610071004b00700043006f0057006e0042006c004c006b005c006a0053006900510066004700620049005e0032005d002f005b004e005a004100590039005400430053003f005100360050002d0050003d004f0021004f0044004e002f004900380048002b004700170046003c0045003b00450021004400320042003f0041002d0040001000400031003d0036003b002b003b0024003a0033003800160038002c003700250036003400350023003400210034002c0031001300300028002e0025002e0010002b0025002900230029001b00290016002600040025002100240008002400110022001700200006001e0003001e001a001d0008001c0019001b00020017000e0016000c000f00050006003e004d003c004a0011003a0019003900320037002b0035001c0033001a00310000002f0026002e000b002d001a002c0002002a0028002900220028000d002500170023002000210012001f0007001f00050015000f001000070009001d0030000d002a001200270007002700210026000a00240008002000090012000d00100002000c001d0023001300200011001e0006001d0001000f0008000a00020005001b00220019001e0003001600130015000b001f000e001b00000019000400180008001a000f0018001200140016001c00020009000b00170005000d000e0015000a001300000011000600100003000c0007001400010004 ;
localparam YMAP = 640'h007c0092009e00a600980085007e00990087008300950081009a008c007b009000a20097008a0052008f009b009600a3007900a000a4008e0074009d007300a50094009300520082009f0091009c00a1;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 280'b1100111000000011001100101100101011000111100011011110001100111111010011101101011100011011111010110001111101001110110101110000110111101010000011000100001011010011000011011110101100001111010011101101011100001101100010110001111111101110111001110000000011001010100110110101111011010110 ;
localparam WIDTH = 320'h07070606060706070707070606060707060606060708060706060606060706070706060607060707;
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
