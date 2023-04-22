`timescale 1us/1ns
`ifndef DUTNAME
`define DUTNAME modular_tnnpar
`define TBNAME tbmodular_tnnpar
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
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
wire [FEAT_CNT*FEAT_BITS-1:0] testcases [TEST_CNT-1:0];
parameter Nsperiod=5000;
localparam period=Nsperiod/500;

`ifdef TESTCASES
`include `TESTCASES
`endif

`DUTNAME dut (.features(features),.prediction(prediction));

integer i,j;
initial begin
    features = testcases[0];
    for(i=0;i<TEST_CNT;i=i+1) begin
        features = testcases[i];
        #period
        $display("%h",features);
        $display("%b",dut.hidden);
        for(j=0;j<CLASS_CNT;j=j+1) begin
            $write("%d ,",dut.scores[j]);
        end
        $display("");
        $display("%d",prediction);
    end
end

endmodule
