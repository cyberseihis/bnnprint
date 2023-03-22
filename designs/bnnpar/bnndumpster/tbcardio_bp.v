








module tbcardio_bp #(

parameter N = 19,
parameter M = 40,
parameter B = 4,
parameter C = 3,
parameter Ts = 5


)();
reg clk;
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];
parameter Nsperiod=10;
parameter period = Nsperiod;


assign testcases[0] = 76'h4000d18100621208964;
assign testcases[1] = 76'h8203140320b3a52a991;
assign testcases[2] = 76'h8103140420b3a42a991;
assign testcases[3] = 76'h8104150720a07a0a991;
assign testcases[4] = 76'h8203150600a0780a991;



cardio_bp dut (.inp(inp),.klass(klass));

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
