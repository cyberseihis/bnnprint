module xnorseqq #(
  parameter HIDDEN_CNT = 4,
  parameter CLASS_CNT = 4,
  parameter Weights = 0
  ) (
  input clk,
  input rst,
  input [HIDDEN_CNT-1:0] features,
  input enable,
  output [CLASS_CNT*$clog2(HIDDEN_CNT+1)-1:0] scores
  );
  
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  reg [$clog2(HIDDEN_CNT)-1:0] cnt;
  localparam [$clog2(HIDDEN_CNT)-1:0] last = HIDDEN_CNT-1;
  reg halt;
  wire [HIDDEN_CNT-1:0] features_n;

  assign features_n = ~features;
  
  genvar i,j;
  generate
      for(j=0;j<CLASS_CNT;j=j+1)begin
        localparam weight = Weights[j*HIDDEN_CNT+:HIDDEN_CNT];
        wire [HIDDEN_CNT-1:0] hybrid;
        for(i=0;i<HIDDEN_CNT;i=i+1)begin
            if(weight[i])
                assign hybrid[i] = features[i];
            else
                assign hybrid[i] = features_n[i];
        end
        binaccum #(.SIZE(HIDDEN_CNT)) popc (
            .data_in(hybrid[cnt]),
            .clk(clk),
            .halt(halt | (~enable)),
            .rst(rst),
            .acc(scores[j*SUM_BITS+:SUM_BITS])
        );
      end
  endgenerate

  wire reached_last;
  assign reached_last = cnt==last;
  

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
          halt <= 0;
      end
      else if (enable) begin
          if(!reached_last) begin
              cnt <= cnt + 1;
          end else begin
              halt <= 1;
          end
      end
  end
  
endmodule
