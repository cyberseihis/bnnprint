module xnorhatb();
wire [15:0]a= 16'hffff;
wire [49:0] o;
xnorpop xp (a, o);
initial begin
    #1
    for (integer i = 0; i < 10; i=i+1) begin
        $write("%d,", o[i*5+:5]);
    end
end
endmodule
