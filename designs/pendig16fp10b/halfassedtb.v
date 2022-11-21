module halfassedtb();
    wire [111:0] a;
    wire [175:0] o;
    assign a ={7'd98, 7'd56, 7'd61, 7'd42, 7'd23, 7'd0, 7'd0, 7'd42, 7'd29, 7'd100, 7'd66, 7'd60, 7'd98, 7'd18, 7'd100, 7'd80};
    densein l1 (a, o);
    initial begin
        $display("a %d",a[6:0]);
        for (integer i = 0; i < 16; i=i+1) begin
            #1
            $display("o%d %d", i, $signed(o[i*11+:11]));
        end
    end
endmodule
