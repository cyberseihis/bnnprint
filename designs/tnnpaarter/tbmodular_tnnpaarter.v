`timescale 1us/1ns
`ifndef DUTNAME
`define DUTNAME modular_bp
`define TBNAME tbmodular_bp
parameter FEAT_CNT = 4;
parameter FEAT_BITS = 4;
parameter HIDDEN_CNT = 4;
parameter CLASS_CNT = 4;
parameter TEST_CNT = 5;
`endif
module `TBNAME #(
`ifdef PARAMS
`include `PARAMS
`endif
)();
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
reg [FEAT_CNT*FEAT_BITS-1:0] testcases [0:TEST_CNT-1];
parameter Nsperiod=5000;
parameter period = Nsperiod/1000;


`ifdef TESTCASES
initial $readmemh(`TESTCASES,testcases);
`endif

`DUTNAME dut (.features(features),.prediction(prediction));

integer i,j;
initial begin
    features = testcases[0];
    /* $write("[");//" */
    for(i=0;i<TEST_CNT;i=i+1) begin
        features = testcases[i];
        #period
        /* $write(""); */
        $write("%d, ",prediction);
        /* for(j=0;j<CLASS_CNT;j=j+1) */
        /*     $write("%d, ", dut.scorarr[j]); */
        /* $display(""); */
    end
    /* $display("]"); */
end

endmodule
