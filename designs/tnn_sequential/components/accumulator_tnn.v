module accumulator_tnn #(
    parameter SIZE = 4,      // Number of non-zero weights
    parameter BITS = 8       // Bits per sample
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input halt,
    input unsigned [BITS-1:0] sample,  // Input data
    input add_sub,         // Add/subtract control input
    input valid,         // Is weight non-zero control input
    output out
);
reg signed [BITS+$clog2(SIZE+1)-1:0] acc;
wire signed [BITS+$clog2(SIZE+1)-1:0] next_acc;
wire unsigned [BITS-1:0] operant;  // Input data
assign operant = valid ? sample : 0;
assign next_acc = add_sub ? acc + operant:acc - operant;
assign out = next_acc >= 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!halt) begin
        acc <= next_acc;
    end
end

endmodule
