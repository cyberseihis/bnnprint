module first_layer_tnn #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] SPARSE_VALS = 0,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] MASK = 0,
  parameter [8*HIDDEN_CNT-1:0] NONZERO_CNT = 0
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [HIDDEN_CNT-1:0] out,
  output done
  );
  
  reg [$clog2(FEAT_CNT)-1:0] cnt;
  wire [HIDDEN_CNT-1:0] weight;
  wire [HIDDEN_CNT-1:0] iszero;
  wire [FEAT_BITS-1:0] in;
  wire reached_last;

  assign done = reached_last;
  
  genvar i;
  generate
    for (i=0;i<HIDDEN_CNT;i=i+1) begin
      accumulator_tnn #(.SIZE(NONZERO_CNT[8*i+:8]), .BITS(FEAT_BITS)) tacc1 (
        .sample(in),
        .clk(clk),
        .halt(reached_last),
        .rst(rst),
        .add_sub(weight[i]),
        .valid(iszero[i]),
        .out(out[i])
      );
    end
  endgenerate

  assign reached_last = cnt==FEAT_CNT-1;
  assign in = features[cnt*FEAT_BITS+:FEAT_BITS];
  assign weight = SPARSE_VALS[cnt*HIDDEN_CNT+:HIDDEN_CNT];
  assign iszero = MASK[cnt*HIDDEN_CNT+:HIDDEN_CNT];

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!reached_last) begin
          cnt <= cnt + 1;
      end
  end
  
endmodule
