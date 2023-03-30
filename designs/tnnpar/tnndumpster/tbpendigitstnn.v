`timescale 1us/1ns









module tbpendigitstnn #(

parameter FEAT_CNT = 16,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 10,
parameter TEST_CNT = 5


)();
localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
wire [FEAT_CNT*FEAT_BITS-1:0] testcases [TEST_CNT-1:0];
parameter Nsperiod=5000;
localparam period=Nsperiod/500;


assign testcases[0] = 64'h8f4d96400498fe6f;
assign testcases[1] = 64'h0e4f7c572260b0f1;
assign testcases[2] = 64'h095bceffcc884430;
assign testcases[3] = 64'h0f1f1b37e5f7c4b0;
assign testcases[4] = 64'h0b8dffddaa665380;



pendigitstnn dut (.features(features),.prediction(prediction));

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
