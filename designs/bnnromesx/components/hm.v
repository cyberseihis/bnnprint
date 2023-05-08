module hm();

parameter CNT_LEN = 6;

function [CNT_LEN-1:0] rol (
    input [CNT_LEN-1:0] rin
);
rol = {rin[CNT_LEN-2:0], rin[CNT_LEN-1] ^~ rin[CNT_LEN-2]};
endfunction

function [CNT_LEN-1:0] roln (
    input [CNT_LEN-1:0] rin,
    input integer n
);
reg [CNT_LEN-1:0] x;
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
