`timescale 1us/1ns









module tbHar_bnn1_bnnpaarter #(

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
parameter period = Nsperiod/1000;



initial $readmemh("Har.memh",testcases);


Har_bnn1_bnnpaarter dut (.features(features),.prediction(prediction));

integer i;
initial begin
    features = testcases[0];
    /* $write("[");//" */
    for(i=0;i<1;i=i+1) begin
        features = testcases[i];
        #period
        $write("");
        /* $write("%d, ",prediction); */
    end
    /* $display("]"); */
end

endmodule
