










module winequality-red_bnn_seq #(

parameter N = 11,
parameter M = 40,
parameter B = 4,
parameter C = 6,
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
  
  


  localparam Weights = 440'b00011110010011110000111100010100111000010000110101100011110011000000011001011011000110010110110111010110011000110001110110100111000001001101111011101010000000001000011011010011100011101100011111111010000000011001000100111100110110101011110101100100010110110110011000100101100111011110000011011100101110000011110000111010110111111100111101100111101011000111001100000010010111011010011110010001010111110001011101111001011001010011001000111111 ;
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
  
  


  localparam Weights = 240'b100111000010000011101100000011110100010010111100101110000001110110000001011000111100000001001000010001000110110001110101101000110100101010100111101111110101000101110001001011110010011111110011011101100111101000101010111101111010101011110101 ;
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
