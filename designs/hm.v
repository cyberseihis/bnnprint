module hm();

parameter K = 6;

function [K-1:0] rol (
    input [K-1:0] rin
);
rol = {rin[K-2:0], rin[K-1] ^~ rin[K-2]};
endfunction

function [K-1:0] roln (
    input [K-1:0] rin,
    input integer n
);
reg [K-1:0] x;
integer i;
begin
    x = rin;
    for(i=0;i<n;i=i+1)
        x = rol(x);
    roln = x;
end
endfunction

integer i;
initial begin
    for(i=0;i<64;i=i+1)
        $display("%b",roln(6'b0,i));
end

endmodule
