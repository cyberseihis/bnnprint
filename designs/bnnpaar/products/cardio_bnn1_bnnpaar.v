
















module cardio_bnn1_bnnpaar #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 8064'h00da00fe00d400fb00dc00f800e000f700bd00f600cc00f500d500f400c400f300d000f200d200f100de00f000ac00ef00ad00ee00c000ed00bc00ec00be00eb00bb00ea00b500e900ab00e800b800e700aa00e600b100e500c700e400b600e300cd00e200c500e100d300df00c900dd009600db00bf00d900af00d800cb00d600a500d100b200cf00b400ce009500ca009a00c8008c00c6009300c3006700c2006700c1009c00ba00a700b9008d00b7007900b3008400b0006a00ae008a00a9007e00a8009d00a6005900a4006e00a3008600a2007d00a1006b00a00071009f0081009e006b009b007c00990078009800790097007d0094007a009200780091008900900066008f0083008e0055008b007b00880070008700810085007f0082007b0080006a00800068007f007a007e005c007c00740077007300770061007400610073006d00720060007200680071006500700062006f002c006f005c006e0066006d0063006900530069004c0068003c0067006000660055006500540065006300640054006400320064004900630061006200510062004e00600059005f0057005f0048005f0041005e0059005d0051005d002f005d004d005c0030005b0049005a0042005a00360059005300580052005800540057004c0054004c00520046005100380051004f0050004700500032004f0015004b0034004a002b0048003c004700310047003b0046003e0045004300440032004300290043003f00410038004000090040000200400035003f0023003e002b003d0026003d002a003c0025003c0034003b0030003a0029003a000f003a003100390036003700280034001200300002002f0002002e0002002a00120029001c0026000100160003001400530076005600750049006c004c005e0039005a0056005800190057002d0055001c0052004d00500009004f0044004d002c004b0028004b0049004a00430045002a00430024003f0015003e0009003b0037003a002d0039000f0035002b0032002900300006005b0045004a002d004700300042002f004200370038002f00360029002c00120028001400270023002500020025001100220032004e003a0048003e0046002a00440011003f00100039002b003800320037001c00330026002e000f00240006001500100012003c00400031003b00300036000a001800220041002f003d001900310017001a000c0013000b000e0000001f0005001d00040007002d0035002b0034000f002a00060029000b002100090033001b0020000d001b000200120008000d002c002e000e001e001100280004001a00230026000800200018001d0000000c0013001f001000250005000a0001002700220024001e002100070017001500190003001c00140016 ;
localparam YMAP = 640'h010a011201210111011e0110010c00fa0103011c01170104010200d7010901070115011301160105010b011901010106011b011800ff01140120011a00fc00fd011f0100010e00f90108010d011d010f;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 120'b101010000001111100000011001000100011100111001011000110110011011101101001101001110100101100111001001101110110000110110011 ;
localparam WIDTH = 320'h08070708080808080708070707080707060807080707070707070808080807080707070707070708;
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
