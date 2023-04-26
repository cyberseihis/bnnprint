module swag (
    
);
    parameter len = 8;
    parameter ar = 32'ha312d841;
    parameter mr =  8'b11101011;

    // position of 1 in mr to # of 1s before it
    // aka index in sparce array
    function integer name(
        input [len-1:0] mask,
        input integer a
    );
    integer i,j;
    begin
    i = -1;
    for(j=0;j<=a;j=j+1)begin
       if(mask[j]) i = i+1;  
    end
    name = i; 
    end
    endfunction


    function integer onez(input [len-1:0] mask);
        onez = name(mask,len-1) + 1;
    endfunction

    wire [onez(mr)*4-1:0] olaf;
    genvar j;
    generate
        for(j=0;j<8;j=j+1)
            if(mr[j])
            assign olaf[name(mr,j)*4+:4] = ar[j*4+:4];
    endgenerate

    integer i;
    initial begin
        $display("bitch %d", $bits(mr));
        $display("olaf %h",olaf);
        $display("cnt %d",onez(mr));
    end
endmodule
