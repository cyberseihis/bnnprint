`ifndef DUTNAME
`define DUTNAME bndemo
parameter N = 4;
parameter B = 4;
parameter M = 4;
parameter C = 4;
`endif
module `DUTNAME #(
`ifdef PARAMS
`include `PARAMS
`endif
)(
    input [N*B-1:0] inp,
    output [$clog2(C)-1:0] klass
);
localparam SumL = $clog2(M+1);
localparam IumL = $clog2(N+1)+B;
wire unsigned [B-1:0] inm [N-1:0];
wire [M-1:0] mid;
wire unsigned [IumL-1:0] pmid [M-1:0];
wire unsigned [IumL-1:0] nmid [M-1:0];
wire [M-1:0] mid_n;
wire [C*SumL-1:0] out; 
assign mid_n = ~mid;

genvar i;
generate
    for(i=0;i<N;i=i+1)
        assign inm[N-1-i] = inp[i*B+:B];
endgenerate

`ifdef HRDCD
`include `HRDCD
`endif

argmax #(.N(C),.I($clog2(C)),.K(SumL)) result (
    .inx(out),
    .outimax(klass)
);
endmodule
