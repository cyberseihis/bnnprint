module tbbndemo();
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];

`include `TBPARAMS

`BNAME #(.N(N), .B(B), .M(M), .C(C)) dut (.inp(inp),.klass(klass));

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
