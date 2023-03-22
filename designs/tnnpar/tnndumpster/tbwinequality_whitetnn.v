








module tbwinequality_whitetnn #(

parameter N = 11,
parameter M = 40,
parameter B = 4,
parameter C = 7,
parameter Ts = 5


)();
localparam SumL = $clog2(M+1);
reg clk;
reg [N*B-1:0] inp;
wire [$clog2(C)-1:0] klass;
wire [N*B-1:0] testcases [Ts-1:0];
parameter Nsperiod=10;
localparam period=Nsperiod;


assign testcases[0] = 44'h53352264442;
assign testcases[1] = 44'h43302152854;
assign testcases[2] = 44'h73422232845;
assign testcases[3] = 44'h52322373735;
assign testcases[4] = 44'h52322373735;



winequality_whitetnn dut (.inp(inp),.klass(klass));

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
