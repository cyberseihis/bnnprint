module first_layer_rolin #(
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
  
  reg [HIDDEN_CNT-1:0] hiddreg;
  assign hidden = hiddreg;
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
  
  wire [FEAT_CNT*(FEAT_BITS+1)-1:0] hybrid [HIDDEN_CNT-1:0];
  wire signed [FEAT_BITS:0] moment [FEAT_CNT-1:0];
  wire [FEAT_CNT*(FEAT_BITS+1)-1:0] slice;
  assign slice = hybrid[cnt];
  genvar i,j;
  generate
    for (i=0;i<HIDDEN_CNT;i=i+1) begin
        localparam weight = Weights[i*FEAT_CNT+:FEAT_CNT];
        wire [FEAT_BITS:0] custom [FEAT_CNT-1:0];
        for(j=0;j<FEAT_CNT;j=j+1)begin
            if(weight[j])
                assign custom[j] = {1'b0,features[j*FEAT_BITS+:FEAT_BITS]};
            else
                assign custom[j] = ~{1'b0,features[j*FEAT_BITS+:FEAT_BITS]};
            assign hybrid[i][j*(FEAT_BITS+1)+:FEAT_BITS+1] = custom[j];
        end
    end
    for (i=0;i<FEAT_CNT;i=i+1) begin
        assign moment[i] = slice[i*(FEAT_BITS+1)+:(FEAT_BITS+1)];
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

  assign reached_end = cnt==HIDDEN_CNT;

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!reached_end) begin
          cnt <= cnt + 1;
          hiddreg[cnt] <= soom >= 0;
      end
  end
  
endmodule
