module accum #(parameter N = 4, parameter B = 8)(
    input clk,             // Clock input
    input rst,             // Reset input
    input put,
    input unsigned [B-1:0] data_in,  // Input data
    input add_sub,         // Add/subtract control input
    output reg out
);
reg signed [B+N-1:0] acc;
wire signed [B+N-1:0] next_acc;
assign next_acc = add_sub ? acc + data_in:acc - data_in;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else begin
    if (put) begin
        $display(next_acc);
        out <= next_acc >= 0;
    end
    else
        acc <= next_acc;
    end
end

endmodule
