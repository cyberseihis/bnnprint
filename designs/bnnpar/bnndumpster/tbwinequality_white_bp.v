`timescale 1us/1ns









module tbwinequality_white_bp #(

parameter N = 11,
parameter M = 40,
parameter B = 4,
parameter C = 7,
parameter Ts = 5


)();
reg clk;
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];
parameter Nsperiod=5000;
parameter period = Nsperiod/500;


assign testcases[0] = 44'h53352264442;
assign testcases[1] = 44'h43302152854;
assign testcases[2] = 44'h73422232845;
assign testcases[3] = 44'h52322373735;
assign testcases[4] = 44'h52322373735;



winequality_white_bp dut (.inp(inp),.klass(klass));

integer i;
initial begin
    inp = testcases[0];
    $write("[");
    for(i=0;i<Ts;i=i+1) begin
        inp = testcases[i];
        #period
        /* $displayh(i); */
        /* $display("%h %h %d",inp,dut.out,klass); */
        $write("%d, ",klass);
    end
    $display("]");
end

endmodule
