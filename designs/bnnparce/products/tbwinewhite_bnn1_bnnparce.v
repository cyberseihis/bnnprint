`timescale 1us/1ns









module tbwinewhite_bnn1_bnnparce #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 7,
parameter TEST_CNT = 1000


)();
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
reg [FEAT_CNT*FEAT_BITS-1:0] testcases [0:TEST_CNT-1];
parameter Nsperiod=5000;
parameter period = Nsperiod/1000;



initial $readmemh("winewhite.memh",testcases);


winewhite_bnn1_bnnparce dut (.features(features),.prediction(prediction));

integer i;
initial begin
    features = testcases[0];
    $write("[");//"
    for(i=0;i<TEST_CNT;i=i+1) begin
        features = testcases[i];
        #period
        $write("%d, ",prediction);
    end
    $display("]");
end

endmodule
