module seqq #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 1
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output out
  );
  
  reg [$clog2(N+1)-1:0] cnt;
  wire [N-1:0] weis;
  wire [B-1:0] in;
  wire put;
  wire as;
  wire [$clog2(N+1)-1:0]icnt;
  
  assign weis =
      `include "weis.wei"
      ;

  // Instantiate module under test
  accum #(.N(N), .B(B)) acc1 (
    .data_in(in),
    .clk(clk),
    .put(put),
    .rst(rst),
    .add_sub(as),
    .out(out)
  );

  assign put = cnt==N;
  assign icnt = put?0:cnt;
  assign as = weis[icnt];
  assign in = data[icnt*B+:B];

  always @(posedge clk or posedge rst) begin
      if(rst || cnt == N) begin
          cnt <= 0;
      end
      else begin
          cnt <= cnt + 1;
      end
  end
  
endmodule
