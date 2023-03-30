module tseqq #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 4,
  parameter [M*N-1:0] Wvals = 0,
  parameter [M*N-1:0] Wzero = 0,
  parameter [8*M-1:0] Wnnz = 0
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [M-1:0] out,
  output done
  );
  
  reg [$clog2(N)-1:0] cnt;
  /* wire [M*N-1:0] weis; */
  wire [M-1:0] weit;
  wire [M-1:0] iszero;
  wire [B-1:0] in;
  wire put;

  assign done = put;
  
  genvar i;
  generate
    for (i=0;i<M;i=i+1) begin
      taccum #(.N(Wnnz[8*i+:8]), .B(B),.Id(i)) tacc1 (
        .data_in(in),
        .clk(clk),
        .put(put),
        .rst(rst),
        .add_sub(weit[i]),
        .use_in(iszero[i]),
        .out(out[i])
      );
    end
  endgenerate

  assign put = cnt==N-1;
  assign in = data[cnt*B+:B];
  assign weit = Wvals[cnt*M+:M];
  assign iszero = Wzero[cnt*M+:M];

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!put) begin
          cnt <= cnt + 1;
      end
      /* else $display("Time = %t, mid = %b", $time, out); */
  end
  
endmodule
