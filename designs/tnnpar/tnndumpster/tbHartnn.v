`timescale 1us/1ns









module tbHartnn #(

parameter N = 12,
parameter M = 40,
parameter B = 4,
parameter C = 6,
parameter Ts = 5


)();
localparam SumL = $clog2(M+1);
reg clk;
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];
parameter Nsperiod=5000;
localparam period=Nsperiod/500;


assign testcases[0] = 48'hb9811498a121;
assign testcases[1] = 48'hb9700187a110;
assign testcases[2] = 48'hb9700088a000;
assign testcases[3] = 48'hb9700088a000;
assign testcases[4] = 48'hb97000889000;



Hartnn dut (.inp(inp),.klass(klass));

integer i,j;
initial begin
    inp = testcases[0];
    $write("[");
    for(i=0;i<Ts;i=i+1) begin
        inp = testcases[i];
        #period
        /* $displayh(i); */
        /* $display("%b",dut.mid); */
        /* for(j=0;j<C;j=j+1) */
        /*     $write("%d, ",dut.out[j]); */
        /* $display(""); */
        $write("%d, ",klass);
    end
    $display("]");
end

endmodule
