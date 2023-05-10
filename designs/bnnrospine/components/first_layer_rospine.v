module first_layer_rospine #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] Weights = 0
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [HIDDEN_CNT-1:0] hidden,
  output done
  );
  
  reg [HIDDEN_CNT-1:-1] hiddreg;
  assign hidden = hiddreg[HIDDEN_CNT-1:0];
  reg [$clog2(HIDDEN_CNT+1)-1:0] cnt;
  wire reached_end;

  assign done = reached_end;

    function [7:0] n_negs(
        input [FEAT_CNT-1:0] mask
    );
    integer i,j;
    begin
    i = 0;
    for(j=0;j<FEAT_CNT;j=j+1)begin
       if(!mask[j]) i = i+1;  
    end
    n_negs = i; 
    end
    endfunction

    function [HIDDEN_CNT*8-1:0] fullnegs(
        input integer a
    );
    reg [HIDDEN_CNT*8-1:0] ng;
    integer j;
    begin
    for(j=0;j<HIDDEN_CNT;j=j+1)begin
       ng[j*8+:8] = n_negs(Weights[j*FEAT_CNT+:FEAT_CNT]);
    end
    fullnegs = ng;
    end
    endfunction

    localparam [HIDDEN_CNT*8-1:0] NEG_CNT = fullnegs(0);
  
  wire signed [FEAT_BITS:0] moment [FEAT_CNT-1:0];
  wire signed [FEAT_BITS:0] sfeat [FEAT_CNT-1:0];
  wire [FEAT_CNT-1:0] slice;
  assign slice = Weights[cnt*FEAT_CNT+:FEAT_CNT];
  genvar i,j;
  generate
    for (i=0;i<FEAT_CNT;i=i+1) begin
        assign sfeat[i] = {1'b0,features[i*FEAT_BITS+:FEAT_BITS]};
        assign moment[i] = {5{chosen[i]}} ^~ sfeat[i];
    end
  endgenerate
wire [HIDDEN_CNT-1:-1] first;
wire [HIDDEN_CNT-1:-1] seen;
wire [FEAT_CNT-1:0] slide [HIDDEN_CNT-1:0];
wire [FEAT_CNT-1:0] chosen;
assign chosen = slide[HIDDEN_CNT-1];

genvar x;
generate
assign first[-1] = hiddreg[-1];
assign seen[-1] = hiddreg[-1];
for(x=0;x<HIDDEN_CNT;x=x+1)begin
    assign first[x] = hiddreg[x] & ~(seen[x-1]);
    assign seen[x] = hiddreg[x] | seen[x-1];
end
    assign slide[0] = {FEAT_CNT{first[HIDDEN_CNT-1]}} & Weights[FEAT_CNT-1:0];
for(x=1;x<HIDDEN_CNT;x=x+1)begin
    assign slide[x] = ({FEAT_CNT{first[HIDDEN_CNT-x-1]}} & Weights[x*FEAT_CNT+:FEAT_CNT]) | slide[x-1];
end
endgenerate


  reg signed [FEAT_BITS+$clog2(FEAT_CNT+1)-1:0] soom;
  integer y;
  always @* begin
      soom = 0;
      for (y=0;y<FEAT_CNT;y=y+1)
          soom = soom + moment[y];
      soom = soom + NEG_CNT[cnt*8+:8];
  end

  assign reached_end = hiddreg[-1];

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
          hiddreg <= {1'b1,{HIDDEN_CNT{1'b0}}};
      end
      else if(!reached_end) begin
          cnt <= cnt + 1;
          hiddreg <= {soom >= 0,hiddreg[HIDDEN_CNT-1:0]};
      end
  end

  wire [FEAT_CNT-1:0] checkch;
  assign checkch =slice^chosen;

  initial begin
      /* $monitor("%b,%b",reached_end,end2); */
      /* $monitor("%b | %b | %b",slice,chosen,checkch); */
      /* $monitor("%b | %b | %b",hiddreg,first,seen); */

end
  
endmodule
