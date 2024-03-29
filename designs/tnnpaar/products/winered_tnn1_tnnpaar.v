
















module winered_tnn1_tnnpaar #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 4096'h005600710050006f004b006d0035006c0052006b0037006a003a0069003e00680030006700370066003a006500390064004000630036006200470061004100600035005f0038005d0046005c002c005b0032005a002a0059003c0058004d005700360055002a0054002f0053003d00510034004f0049004e0034004c0033004a00320048001a00450023004400240043003100420029003f0020003b002f0039001c003800150033002e003100100030001b002e001c002d0006002d0021002c0016002b0013002b001d0029001c0029001f0028002400270022002600210026001d0026001f0025001e0025001d0025001800240011002400210023001a00230000002300000022000c002100130020001b001f0017001f001c001e0019001e001c001d0011001d0008001b00040019001400180013001800070018000f001600100014000c001400060013000b0012000a0012000b000f0007000c0003000c0000000a0002000700020004001700280019002700140022000e0020001a001e000f001b0003001900090018000d00170009001600080015001100120001001200040010000a000f0007000e0004000d0003001700040013000d00100007000b0006000700010014000e0011000a00110009000d0006000b0001000300080016000500130000001200020010000c000f000a000c000000060014001500020005 ;
localparam YMAP = 640'h00810087001a008e007e0075008c0079007000930080007f007c00880077008b007d00760089005e008400820092008a0072008300780086006e007b007a0094008500730091008f008d007400900095;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 240'b001010100100001000000000001000000100000000110011000000000100000001001000100001000000001100000000100000000000000001000000000000100000000000000000011000010001000000001000001000000000000000101110000000001000000001010000010000000000000000010100 ;
localparam WNNZ = 240'b001010100100001000000000011100010101000100110011101000100101000011011000100011111000011100000000100000000001000001000010000010100000001000000000011100110001001100001000001100000000000000101110001000001000000001110100110001100001000000011101;
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
