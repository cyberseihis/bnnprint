module accumulator_tnnzeq #(
    parameter SIZE = 4,      // Number of non-zero weights
    parameter BITS = 8       // Bits per sample
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input halt,
    input signed [BITS:0] sample,  // Input data
    output out
);
reg signed [BITS+$clog2(SIZE+1):0] acc;
wire signed [BITS+$clog2(SIZE+1):0] next_acc;
assign next_acc = acc + sample;
assign out = next_acc >= 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!halt) begin
        acc <= next_acc;
    end
end

endmodule
