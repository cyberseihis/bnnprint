








module tbgasId #(

parameter N = 128,
parameter M = 40,
parameter B = 4,
parameter C = 6,
parameter Ts = 5


)();
reg clk;
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];


assign testcases[0] = 512'h10000fef10000fff41000fff50000fff20000fff30000fff30000fef30000fef10000fff10000fff21000fff21000fff21000fff21100fff21000fef21000fef;
assign testcases[1] = 512'h10100fef10100fff41000fff50000fff20000fff30000fff30000fef40000fef10100fff10110fff21100fef21000fef22100fff22100fff21000fef21000fef;
assign testcases[2] = 512'h10110fef20100fff51000fff50000fff30000fff40000eff40100fef40100fef10110fff10111fef31110fef32100fef32100eff32100eff22100fef22100fef;
assign testcases[3] = 512'h10111fef20110fff51100fff50000fff30000fff40000eff40100fef40100fef10111fff10111fef31110fef32110fef32200eff32200eff22110fef22100fef;
assign testcases[4] = 512'h20110fef20110eff52100fff51000fff30000fff40000eff40100fef40100fef20111eef20111eef32110fef32110fef33200eff43200dff22110fef32100fef;



gasId dut (.inp(inp),.klass(klass));

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
