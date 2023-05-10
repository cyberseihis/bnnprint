module get1();

reg [7:0] in;

wire [7:0] first;
wire [7:0] seen;

genvar x;
generate
assign first[7] = in[7];
assign seen[7] = in[7];
for(x=6;x>=0;x=x-1)begin
    assign first[x] = in[x] & ~(seen[x+1]);
    assign seen[x] = in[x] | seen[x+1];
end
endgenerate

integer i;
initial begin
    for(i=0;i<200;i=i+1) begin
        in <= i;
        #1
        $display("%b | %b",in,first);
    end
end
endmodule
