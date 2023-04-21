module popcount_tnn #(
    parameter SIZE = 4, // Number of elements to add
    parameter TOTAL = 4 // Total inputs of layer
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input enable,
    input [$clog2(TOTAL+1)-1:0] cnt,
    input unsigned sample,  // Input data
    output reg unsigned [$clog2(SIZE+1)-1:0] acc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (enable && cnt<SIZE) begin
        acc <= acc+sample;
    end
end

endmodule
