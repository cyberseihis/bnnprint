module first_layer #(
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
  
  reg [$clog2(FEAT_CNT)-1:0] cnt;
  localparam [$clog2(FEAT_CNT)-1:0] last = FEAT_CNT-1;
  wire [HIDDEN_CNT-1:0] weight;
  reg [HIDDEN_CNT*FEAT_CNT-1:0] shift_weights;
  wire [FEAT_BITS-1:0] sample;
  wire reached_end;

  assign done = reached_end;
  
  genvar i;
  generate
    for (i=0;i<HIDDEN_CNT;i=i+1) begin
      accumulator #(.SIZE(FEAT_CNT), .BITS(FEAT_BITS)) acc1 (
        .data_in(sample),
        .clk(clk),
        .halt(reached_end),
        .rst(rst),
        .add_sub(weight[i]),
        .acc_out(hidden[i])
      );
    end
  endgenerate

  assign reached_end = cnt==last;
  assign sample = features[cnt*FEAT_BITS+:FEAT_BITS];
  assign weight = shift_weights[0+:HIDDEN_CNT];

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          shift_weights <= Weights;
          cnt <= 0;
      end
      else if(!reached_end) begin
          shift_weights <= shift_weights >> HIDDEN_CNT;
          cnt <= cnt + 1;
      end
  end
  
endmodule
