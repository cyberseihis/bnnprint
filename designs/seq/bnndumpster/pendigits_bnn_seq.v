










module pendigits_bnn_seq #(

parameter N = 16,
parameter M = 40,
parameter B = 4,
parameter C = 10,
parameter Ts = 5


  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [$clog2(C)-1:0] klass
  );
  
  localparam SumL = $clog2(M+1);
  wire [SumL*C-1:0] sums;

  seqlego #(.N(N),.B(B),.M(M),.C(C)) layers (
    .clk(clk),
    .rst(rst),
    .data(data),
    .out(sums)
  );

  argmax #(.N(C),.I($clog2(C)),.K(SumL)) result (
     .inx(sums),
     .outimax(klass)
  );

endmodule
module accum #(parameter N = 4, parameter B = 8)(
    input clk,             // Clock input
    input rst,             // Reset input
    input put,
    input unsigned [B-1:0] data_in,  // Input data
    input add_sub,         // Add/subtract control input
    output out
);
reg signed [B+N-1:0] acc;
wire signed [B+N-1:0] next_acc;
assign next_acc = add_sub ? acc + data_in:acc - data_in;
assign out = next_acc >= 0;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!put) begin
        acc <= next_acc;
    end //else $display(next_acc);
end

endmodule
module binaccum #(
    parameter N = 4 // Number of elements to add
)(
    input clk,             // Clock input
    input rst,             // Reset input
    input put,
    input unsigned data_in,  // Input data
    output reg unsigned [$clog2(N+1)-1:0] acc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= 0;
    end else if (!put) begin
        acc <= acc+data_in;
    end
end

endmodule
module seqlego #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 4,
  parameter C = 4
  ) (
  input clk,
  input rst,
  input [N*B-1:0] data,
  output [SumL*C-1:0] out
  );
  
  localparam SumL = $clog2(M+1);
  wire [M-1:0] midd;
  wire nxt;

  seqq #(.N(N),.B(B),.M(M)) layer1 (
    .clk(clk),
    .rst(rst),
    .data(data),
    .out(midd),
    .done(nxt)
  );

 xnorseqq #(.N(M),.M(C)) layer2 (
    .clk(clk),
    .rst(rst),
    .enable(nxt),
    .data(midd),
    .sums(out)
 );
  
endmodule
module seqq #(
  parameter N = 4,
  parameter B = 4,
  parameter M = 4
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
  wire [B-1:0] in;
  wire put;

  assign done = put;
  
  


  localparam Weights = 640'b0001000011111110110111111111000000010111110001101101011010000000001100111000010100010010101011010001010101000100000101000101101111100011110100100110101011001010011010110011010011110001111010111111001000111101100011110001000111010100011100011011110000011001011010010000101111111011001110000000100100101101110001001111101011101011010000010010111010011111011011001001110001111001101111011110010101010011010100110100010000001110111110000000101011001100001110001010110010110110010100010011000000001010011110110101100000110111100000100001111000100111100100101100111001101100001100011110110000100110111100010000001000101110001101111001101010011110 ;
  genvar i;
  generate
    for (i=0;i<M;i=i+1) begin
      accum #(.N(N), .B(B)) acc1 (
        .data_in(in),
        .clk(clk),
        .put(put),
        .rst(rst),
        .add_sub(weit[i]),
        .out(out[i])
      );
    end
  endgenerate

  assign put = cnt==N-1;
  assign in = data[cnt*B+:B];
  assign weit = Weights[cnt*M+:M];

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
module xnorseqq #(
  parameter N = 4,
  parameter M = 4
  ) (
  input clk,
  input rst,
  input [N-1:0] data,
  input enable,
  /* output [M-1:0] out */
  output [M*SumL-1:0] sums
  );
  
  


  localparam Weights = 400'b1000001001011000001111101001101100001110001111001010000101111101010001111111000101111100001100010101000001100011101000110111111101010100011110011110101101101010110100000100000110101110001101100001000100001011111111100000010110110100110100100001000011110110000000101111000000001110011011100010000111100001101000101011101000000000000011110011011101011110110111100000110001101000011011011111010000010000 ;
  localparam SumL = $clog2(N+1);
  reg [$clog2(N)-1:0] cnt;
  reg put;
  wire [N-1:0] data_n;

  assign data_n = ~data;
  
  /* initial */
  /*     $displayb(Weights); */

  genvar j;
  genvar i;
  generate
      for(j=0;j<M;j=j+1)begin
        localparam weit = Weights[j*N+:N];
        wire [N-1:0] sels;
        /* initial */
        /*     $display("glitter %d %b",j,weit); */
        for(i=0;i<N;i=i+1)begin
            if(weit[i])
                assign sels[i] = data[i];
            else
                assign sels[i] = data_n[i];
        end
        binaccum #(.N(N)) popc (
            .data_in(sels[cnt]),
            .clk(clk),
            .put(put | (~enable)),
            .rst(rst),
            .acc(sums[j*SumL+:SumL])
        );
      end
  endgenerate

  assign off = cnt==N-1;

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
          put <= 0;
      end
      else if (enable) begin
          if(!off) begin
              cnt <= cnt + 1;
          end else begin
              put <= 1;
          end
      end
  end
  
endmodule
