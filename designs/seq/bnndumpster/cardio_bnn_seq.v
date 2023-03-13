










module cardio_bnn_seq #(

parameter N = 19,
parameter M = 40,
parameter B = 4,
parameter C = 3,
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
  
  


  localparam Weights = 760'b1011011011110011000110010101010010110000110010001000101011100100100111011000001000000101010011011001001000101001011001011100110110001010111001000001110110010110001111100101110100100001011010001100100011011011101001001110000110110100100111010010000101000100000001000111011100110101110010011001101101011100110110111010010110001111111111100100010000111101100000110011001001010100000000111110000000001101010110001011001011000101101110011001010100011010000100000111000010100000111001101011001111010010001101000101000110011001010011001001001110110010100101000101001111111010010000100010001000010111101000001100000110000010101011100100100000110010101011011001100111100101100011111101001011011000100000011100110110001010100101100001011001110001010110101010100100011100 ;
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
  
  


  localparam Weights = 120'b110011011000011011101100100111001101001011100101100101101110110011011000110100111001110001000100110000001111100000010101 ;
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
