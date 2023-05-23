
















module cardio_tnn1_tnnpaar #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 6464'h00b500d300a200cb00b600c9009500c700a800c5009600c4009200c3008300c2008a00c100a300c000a500bf008000be008800bd00af00bc008400bb009100b8009b00b7008200b4008500b3009d00b200a100b1007f00b0007a00ae006400ad007700ac006300ab008f00aa008900a9008700a7005c00a6007900a4005800a0008e009f0072009e007d009c0086009a007e009900730098008d009700670094007c0093005d00900078008c0054008b00610081005e007b00510076005400750051007400650071004f00700059006f0055006e0030006d002e006c005c006b005a006a004b0069005b00680059006600470062005b0060004f005f004e005a0052005800330057002c0057004900560012005600480055004a005300400053003d00520024004e003f004d0039004d004b004c0045004c0048004a00310049004400470038004600170046003d00450042004400400043003a0043003100420039004100380041003d003f001a003e0035003c0036003b00220039002d00370030003600300035002c0035002900350031003300300033001b0033002c00320023003200210032002b003100260031002a0030001c002f002d002e002b002e002a002d0028002c0007002b0019002a002000290025002800190028002400270013002300120023001f0021001500210008001f0005001f0017001d000d001d0002001d0007001b0001001a000a001900150018000e0018001400170015001600000016000f001100050011000a001000020010000b000f0000000c0009000a00040009000000080002000400340050000c003e000f003c0001003b0019003a000700380029003600320034000d002f000b002f000b002e001e002c001c002a0012002a0006002800100027002400250022002300180021001100210000001b0010001a0008001a00150017000c0014000b001400030013000e0011000600080004000800200037001d002d0009002300050021000d001c000a001b0019002b000100280006002600020020000c001e000f001500040029001d0025001100180013001700070008001200240000001f001c0027001a0026000900220005000e0001000300140016 ;
localparam YMAP = 640'h00e900da00cd00e400e700c800ee00d900ef00eb00e600de00dc00dd00ca00d800d400ba00df00e200ec00d100ce00d200e000b900ea00d600cc00e100db00d000e300d700d500ed00e800e500cf00c6;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 120'b010000001000100000001000000010001011010000000000000110000000000010010010111000100011000100011101000000100000000000000010 ;
localparam WNNZ = 120'b010000101000100000001000101010011011010000100010010110000000000010010010111001100011001100011101000000100001010000001010;
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
