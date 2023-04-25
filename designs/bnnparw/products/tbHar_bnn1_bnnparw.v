`timescale 1us/1ns









module tbHar_bnn1_bnnparw #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 1000


)();
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
reg [FEAT_CNT*FEAT_BITS-1:0] testcases [0:TEST_CNT-1];
parameter Nsperiod=5000;
parameter period = Nsperiod/500;



initial $readmemh("Har.memh",testcases);


Har_bnn1_bnnparw dut (.features(features),.prediction(prediction));

integer i;
initial begin
    features = testcases[0];
    /* $write("[");//" */
    for(i=0;i<TEST_CNT;i=i+1) begin
        features = testcases[i];
        #period
        $display("%d",prediction);
    end
    /* $display("]"); */
end

endmodule
