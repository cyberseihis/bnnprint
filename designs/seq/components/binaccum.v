module binaccum #(
    parameter SIZE = 4 // Number of elements to add
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input halt,
    input unsigned data_in,  // Input data
    output reg unsigned [$clog2(SIZE+1)-1:0] acc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!halt) begin
        acc <= acc+data_in;
    end
end

endmodule
