module swag;

parameter len = 4;
parameter [15:0] Ar = 16'h1e82;

function [3:0] max(input [len*4-1:0] vec);
   reg [3:0] max_val;
   reg [3:0] pval;
   integer i;
   begin
      max_val = vec[3:0];
      for(i = 1; i < 4; i = i + 1) begin
        pval = vec[i*4+:4];
        max_val = pval>max_val?pval:max_val;
      end
      max=max_val;
   end
endfunction

parameter help = max(Ar);
initial begin
    $display("help %d",help);
end

endmodule
