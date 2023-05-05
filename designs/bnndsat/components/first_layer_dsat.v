module first_layer_dsat #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] Weights = 0,
  parameter [HIDDEN_CNT*8-1:0] WIDTHS = -1
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [HIDDEN_CNT-1:0] hidden,
  output done
  );
  
  reg [$clog2(FEAT_CNT)-1:0] cnt;
  localparam [$clog2(FEAT_CNT)-1:0] last = FEAT_CNT-1;
  wire reached_end;

  assign done = reached_end;
  
  genvar i,j;
  generate
    for (i=0;i<HIDDEN_CNT;i=i+1) begin
        localparam weight = Weights[i*FEAT_CNT+:FEAT_CNT];
        wire signed [FEAT_BITS:0] hybrid [FEAT_CNT-1:0];
        wire signed [FEAT_BITS:0] sample;
        for(j=0;j<FEAT_CNT;j=j+1)begin
            if(weight[j])
                assign hybrid[j] = features[j*FEAT_BITS+:FEAT_BITS];
            else
                assign hybrid[j] = -(features[j*FEAT_BITS+:FEAT_BITS]);
        end
      assign sample = hybrid[cnt];
    localparam widf = WIDTHS[i*8+:8];
reg signed [widf-1:0] acc; // THAT -1 IS ILLEGAL
wire signed [widf-1:0] next_acc;
assign next_acc = acc + sample;
assign hidden[i] = next_acc >= 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!reached_end) begin
        acc <= next_acc;
    end //else $display(next_acc);
end
    end
  endgenerate

  assign reached_end = cnt==last;

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!reached_end) begin
          cnt <= cnt + 1;
      end
  end
  
endmodule
