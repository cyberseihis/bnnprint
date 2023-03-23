module taccum #(
    parameter N = 4,      // Number of non-zero weights
    parameter B = 8,
    parameter Id = 0
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input put,
    input unsigned [B-1:0] data_in,  // Input data
    input add_sub,         // Add/subtract control input
    input use_in,         // Is weight non-zero control input
    output out
);
reg signed [B+$clog2(N+1)-1:0] acc;
wire signed [B+$clog2(N+1)-1:0] next_acc;
wire unsigned [B-1:0] operant;  // Input data
assign operant = use_in ? data_in : 0;
assign next_acc = add_sub ? acc + operant:acc - operant;
assign out = next_acc >= 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!put) begin
        acc <= next_acc;
    end //else $display(next_acc);
    if (put)
        $display("S %d %d",Id,next_acc);
end

endmodule
