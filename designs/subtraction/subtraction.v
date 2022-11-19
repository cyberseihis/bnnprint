module subtraction();
wire [13:0] a;
wire signed [7:0] x;
assign a[6:0] = 50;
assign a[13:7] = 70;
assign x=a[6:0]-a[13:7];
initial begin
	$display("%d", x);
	$finish;
end
endmodule
