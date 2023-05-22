
















module winewhite_bnn1_bnnpaarx #(

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
localparam PAAR1 = 2944'h009f00a500a200a4009c00a3009b00a10091009e0095009d0097009a0096009900940098008e0093008a0092007b0090008d008f007c008c007e008b00880089008000870083008600810085008200840079007f007c007d0074007d0078007b00780079006c0075006f00740063007400720073005e0071004c0070006c006e0066006d0064006b0068006a005a0062004a0061004a004b003b00470039004000280040002a00330021002600210024000c00170005000d0077007a00430076003c007500460073003a004800320038000f002c00150027006f0072007000710045006c006d006e0068006b0064006a001d006600650069004f00670014006300180062004900610037005e0022004c001b003d001200200004001e000a0010005b0060005d005f004e005c0011005a0034003f002d0035000000230013001f0002000b00580059005600570054005500520053005000510044004d003e0042002b0030000e00190007000900010006 ;
localparam YMAP1 = 112'h00aa00a700a800a900a000a600ab;
localparam ADDCNT1 = $bits(PAAR1) / 32;
localparam FULLCNT1 = ADDCNT1 + (HIDDEN_CNT * 2);
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

wire unsigned [SUM_BITS-1:0] xnode [FULLCNT1-1:0];

generate
    for(i=0;i<HIDDEN_CNT;i=i+1)
        assign xnode[i] = hidden[i];
    for(i=0;i<HIDDEN_CNT;i=i+1)
        assign xnode[HIDDEN_CNT+i] = hidden_n[i];
for(i=0;i<ADDCNT1;i=i+1) begin
    localparam op1 = PAAR1[i*32+:16];
    localparam op2 = PAAR1[i*32+16+:16];
    localparam nodeloc = (2 * HIDDEN_CNT) + i;
    assign xnode[nodeloc] = xnode[op1] + xnode[op2];
end
for(i=0;i<CLASS_CNT;i=i+1) begin
    assign scores[i*SUM_BITS+:SUM_BITS] = xnode[YMAP1[i*16+:16]];
end
endgenerate

argmax #(.SIZE(CLASS_CNT),.INDEX_BITS($clog2(CLASS_CNT)),.BITS(SUM_BITS)) result (
    .inx(scores),
    .outimax(prediction)
);
endmodule
