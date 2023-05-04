module xnor_roclk #(
  parameter HIDDEN_CNT = 4,
  parameter CLASS_CNT = 4,
  parameter Weights = 0
  ) (
  input clk,
  input rst,
  input [HIDDEN_CNT-1:0] features,
  input enable,
  input [$clog2(HIDDEN_CNT)-1:0] cnt,
  output [$clog2(CLASS_CNT)-1:0] winner
  );
  
  reg [$clog2(CLASS_CNT)-1:0] challenger;
  assign winner = challenger;
  localparam SUM_BITS = $clog2(HIDDEN_CNT+1);
  
  wire [HIDDEN_CNT-1:0] slice;
  wire [HIDDEN_CNT-1:0] xfeats;
  assign slice = Weights[cnt*HIDDEN_CNT+:HIDDEN_CNT];
  assign xfeats = slice ^~ features;

  reg [$clog2(HIDDEN_CNT+1)-1:0] soom;
  reg [$clog2(HIDDEN_CNT+1)-1:0] sofar;
  integer y;
  always @* begin
      soom = 0;
      for (y=0;y<HIDDEN_CNT;y=y+1)
          soom = soom + xfeats[y];
  end
  wire reached_last;
  assign reached_last = cnt>=CLASS_CNT;
  
  wire dethrone;
  assign dethrone = soom > sofar;

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          sofar <= 0;
      end
      else if (enable && !reached_last) begin
          if (dethrone) begin
              sofar <= soom;
              challenger <= cnt;
          end
      end
  end
  
endmodule
