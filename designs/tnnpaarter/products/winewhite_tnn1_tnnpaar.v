
















module winewhite_tnn1_tnnpaar #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 1000


)(
    input [FEAT_CNT*FEAT_BITS-1:0] features,
    output [$clog2(CLASS_CNT)-1:0] prediction
);

localparam PAAR0 = 3616'h0048006d004e006b005600640038006300460062003b005f0050005e0029005b0041005a00430059003c005800450055002500540028005300400052002d00510032004f0033004d002a004c0027004b002f004a002800490039004700320044001d0042001c003f0037003e0021003d0015003a00070036000d00350025003400020034000700330026003000240030001c002f0025002e0016002e001f002a00210029001f0028001f002700060027001900240016002400200023001d002300130023001a002200100022001500200017001f001b001e0009001e000a001d0016001c000f001b0006001b0019001a0018001a0001001a00150019000c00170009001700060017000c0014000500140012001300030013000000130010001200060012000a00110009001100030011000d000e0003000a000100080003000500010005002b00310021002c000b002600180022001d00200014001c00080019000300180015001600040015000f00140004000d0002000a0000001e0018001b000c001a0014001900070015000d0012000b001300080010000100100005000c001100170006000e0000000e000300090005000a0006001600040007000f001200010002 ;
localparam YMAP = 640'h007b002d0035007c00820081006900600065005c008400150074006a0070008600720085008300710068007e00780073006e00770066007d0067006c0076007a0079006100570075005d0080007f006f;
localparam ADDCNT = $bits(PAAR0) / 32;
localparam FULLCNT = ADDCNT + (FEAT_CNT * 2);
localparam Weights1 = 280'b0010000000000001000101000010000000110000000000001000000000000000000000000000000000000000000100000100000000000000000000000010000010000001100000011000000000000010001100000000000100010100000000000000000001100000000100010101100000001000100000000000000000010000000101001000100010010000 ;
localparam WNNZ = 280'b0110111101001001100101110011000001110110000000101000000010000001001010000000000000000010000100000110000100010001000000000010001010000001100000011000000000000010001100100000001100010100000000100000000001100100110100011101100100001100100000000100000000010000100101011000111011010010;
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
