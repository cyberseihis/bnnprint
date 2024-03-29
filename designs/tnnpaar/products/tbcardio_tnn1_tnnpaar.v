`timescale 1us/1ns









module tbcardio_tnn1_tnnpaar #(

parameter FEAT_CNT = 19,
parameter HIDDEN_CNT = 40,
parameter FEAT_BITS = 4,
parameter CLASS_CNT = 3,
parameter TEST_CNT = 1000


)();
reg clk;
reg [FEAT_CNT*FEAT_BITS-1:0] features;
wire [$clog2(CLASS_CNT)-1:0] prediction;
reg [FEAT_CNT*FEAT_BITS-1:0] testcases [0:TEST_CNT-1];
parameter Nsperiod=5000;
parameter period = Nsperiod/1000;



initial $readmemh("cardio.memh",testcases);


cardio_tnn1_tnnpaar dut (.features(features),.prediction(prediction));

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
