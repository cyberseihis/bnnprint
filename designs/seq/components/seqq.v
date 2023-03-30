module seqq #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 4,
  parameter [M*N-1:0] Weights = 0
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [M-1:0] out,
  output done
  );
  
  reg [$clog2(N)-1:0] cnt;
  localparam [$clog2(N)-1:0] last = N-1;
  wire [M-1:0] weight;
  wire [B-1:0] in;
  wire reached_end;

  assign done = reached_end;
  
  genvar i;
  generate
    for (i=0;i<M;i=i+1) begin
      accum #(.N(N), .B(B)) acc1 (
        .data_in(in),
        .clk(clk),
        .halt(reached_end),
        .rst(rst),
        .add_sub(weight[i]),
        .out(out[i])
      );
    end
  endgenerate

  assign reached_end = cnt==last;
  assign in = data[cnt*B+:B];
  assign weight = Weights[cnt*M+:M];

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!reached_end) begin
          cnt <= cnt + 1;
      end
  end
  
endmodule
