module binthresh #(
    parameter N = 4, // Number of elements to add
    parameter T = 3  // Threshold
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input put,
    input unsigned data_in,  // Input data
    output out
);
reg unsigned [$clog2(T)-1:0] acc;
wire unsigned [$clog2(T+1)-1:0] next_acc;
assign next_acc = acc+data_in;
assign out = acc == T;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!put && !out) begin
        acc <= next_acc;
    end else $display(next_acc);
end

endmodule
