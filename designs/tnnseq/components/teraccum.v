module teraccum #(
    parameter N = 4 // Number of elements to add
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input ena,
    input [$clog2(N)-1:0] cnt,
    input unsigned data_in,  // Input data
    output reg unsigned [$clog2(N+1)-1:0] acc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (ena && cnt<N) begin
        acc <= acc+data_in;
    end
end

endmodule
