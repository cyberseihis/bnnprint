`timescale 1us/1ns









module tbwinequality_red_tp #(

parameter FEAT_CNT = 11,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 5


)();
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
wire [FEAT_CNT*FEAT_BITS-1:0] testcases [TEST_CNT-1:0];
parameter Nsperiod=5000;
localparam period=Nsperiod/500;


assign testcases[0] = 44'h46012229a22;
assign testcases[1] = 44'h58022538633;
assign testcases[2] = 44'h57122338733;
assign testcases[3] = 44'h92912439523;
assign testcases[4] = 44'h46012229a22;



winequality_red_tp dut (.features(features),.prediction(prediction));

integer i,j;
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
