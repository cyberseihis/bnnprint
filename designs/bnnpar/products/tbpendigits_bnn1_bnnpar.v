`timescale 1us/1ns









module tbpendigits_bnn1_bnnpar #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 1000


)();
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
reg [FEAT_CNT*FEAT_BITS-1:0] testcases [0:TEST_CNT-1];
parameter Nsperiod=5000;
parameter period = Nsperiod/1000;



initial $readmemh("pendigits.memh",testcases);


pendigits_bnn1_bnnpar dut (.features(features),.prediction(prediction));

integer i;
initial begin
    features = testcases[0];
    /* $write("[");//" */
    for(i=0;i<10;i=i+1) begin
        features = testcases[i];
        #period
        /* $write("%d, ",prediction); */
        $display("%b", dut.hidden);
    end
    /* $display("]"); */
end

endmodule
