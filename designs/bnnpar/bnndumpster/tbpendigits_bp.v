








module tbpendigits_bp #(

parameter N = 16,
parameter M = 40,
parameter B = 4,
parameter C = 10,
parameter Ts = 5


)();
reg clk;
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];
parameter Nsperiod=10;
parameter period = Nsperiod;


assign testcases[0] = 64'h8f4d96400498fe6f;
assign testcases[1] = 64'h0e4f7c572260b0f1;
assign testcases[2] = 64'h095bceffcc884430;
assign testcases[3] = 64'h0f1f1b37e5f7c4b0;
assign testcases[4] = 64'h0b8dffddaa665380;



pendigits_bp dut (.inp(inp),.klass(klass));

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
