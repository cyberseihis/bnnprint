










module winequality-white_bnn_seq #(

parameter N = 11,
parameter M = 40,
parameter B = 4,
parameter C = 7,
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
  
  


  localparam Weights = 440'b01011011001001010110011000111111100001101110011110111101111010000011000010100110111100010000110010110011100101010111010001001000111000101011010101001110010111011110101100111011111000110011011010110110011111001000001111001101001001101000010110100001111111101110001001001000111100001010010111011000101010001111011111100101110010110001011100100001001001110010100011000000000001001011010100011010101110001001110001001010111111100000111001011000 ;
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
  
  


  localparam Weights = 280'b0110101101111010110110010101001100000000111001110111011111111000110100011011000011101011011100101111000011010111101100001100101101000010001100000101011110110000111010110111001011111000110101111101100011101011011100101111110011000111101100011110001101010011010011001100000001110011 ;
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
