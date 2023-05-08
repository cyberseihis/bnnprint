module xnor_rolx #(
  parameter HIDDEN_CNT = 4,
  parameter CLASS_CNT = 4,
  parameter Weights = 0
  ) (
  input clk,
  input rst,
  input [HIDDEN_CNT-1:0] features,
  input enable,
  output [$clog2(CLASS_CNT)-1:0] winner
  );
  
  reg [$clog2(CLASS_CNT)-1:0] challenger;
  assign winner = challenger;
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  reg [$clog2(CLASS_CNT+1)-1:0] cnt;
  wire [HIDDEN_CNT-1:0] features_n;

  assign features_n = ~features;
  
  wire [HIDDEN_CNT-1:0] hybrid [CLASS_CNT-1:0];
  genvar i,j;
  generate
      for(j=0;j<CLASS_CNT;j=j+1)begin
        localparam weight = Weights[j*HIDDEN_CNT+:HIDDEN_CNT];
        for(i=0;i<HIDDEN_CNT;i=i+1)begin
            if(weight[i])
                assign hybrid[j][i] = features[i];
            else
                assign hybrid[j][i] = features_n[i];
        end
      end
  endgenerate

  reg [$clog2(HIDDEN_CNT+1)-1:0] soom;
  reg [$clog2(HIDDEN_CNT+1)-1:0] sofar;
  integer y;
  always @* begin
      soom = 0;
      for (y=0;y<HIDDEN_CNT;y=y+1)
          soom = soom + hybrid[cnt][y];
  end
  wire reached_last;
  assign reached_last = cnt==CLASS_CNT;
  
  wire dethrone;
  assign dethrone = soom > sofar;

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
          sofar <= 0;
      end
      else if (enable && !reached_last) begin
          cnt <= cnt + 1;
          if (dethrone) begin
              sofar <= soom;
              challenger <= cnt;
          end
      end
  end
  
endmodule
