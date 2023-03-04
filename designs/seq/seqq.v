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
  
  reg [$clog2(N)-1:0] cnt;
  wire [N-1:0] weis;
  wire [B-1:0] in;
  wire put;
  wire as;
  
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

  assign put = cnt==N-1;
  assign as = weis[cnt];
  assign in = data[cnt*B+:B];

  always @(posedge clk or posedge rst) begin
      if(rst || cnt == N-1) begin
          cnt <= 0;
      end
      else begin
          cnt <= cnt + 1;
      end
  end
  
endmodule
