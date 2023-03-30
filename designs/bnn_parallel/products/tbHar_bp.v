`timescale 1us/1ns









module tbHar_bp #(

parameter FEAT_CNT = 12,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 6,
parameter TEST_CNT = 5


)();
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
wire [FEAT_CNT*FEAT_BITS-1:0] testcases [TEST_CNT-1:0];
parameter Nsperiod=5000;
parameter period = Nsperiod/500;


assign testcases[0] = 48'hb9811498a121;
assign testcases[1] = 48'hb9700187a110;
assign testcases[2] = 48'hb9700088a000;
assign testcases[3] = 48'hb9700088a000;
assign testcases[4] = 48'hb97000889000;



Har_bp dut (.features(features),.prediction(prediction));

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
