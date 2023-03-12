`ifndef DUTNAME
`define DUTNAME bndemo
`define TBNAME tbbndemo
parameter N = 4;
parameter B = 4;
parameter M = 4;
parameter C = 4;
parameter Ts = 5;
`endif
module `TBNAME #(
`ifdef PARAMS
`include `PARAMS
`endif
)();
reg clk;
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];

`ifdef TESTCASES
`include `TESTCASES
`endif

`DUTNAME dut (.inp(inp),.klass(klass));

integer i;
initial begin
    inp = testcases[0];
    for(i=0;i<Ts;i=i+1) begin
        inp = testcases[i];
        #10
        /* $displayh(i); */
        /* $display("%h %h %d",inp,dut.out,klass); */
        $display("%d",klass);
    end
end

endmodule
