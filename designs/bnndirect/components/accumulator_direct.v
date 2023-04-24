module accumulator_direct #(parameter SIZE = 4, parameter BITS = 8)(
    input clk,             // Clock input
    input rst,             // Reset input
    input halt,
    input signed [BITS:0] data_in,  // Input data
    input add_sub,         // Add/subtract control input
    output acc_out
);
reg signed [BITS+$clog2(SIZE+1)-1:0] acc; // THAT -1 IS ILLEGAL
wire signed [BITS+$clog2(SIZE+1)-1:0] next_acc;
assign next_acc = acc + data_in;
assign acc_out = next_acc >= 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!halt) begin
        acc <= next_acc;
    end //else $display(next_acc);
end

endmodule
