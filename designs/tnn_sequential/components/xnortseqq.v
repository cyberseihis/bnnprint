module xnortseqq #(
  parameter N = 4,
  parameter M = 4,
  // CSR of weight martix
  parameter [((M+1)*8)-1:0] Wrow = 40'h0403020100, // Column of non-zeros // Start indices per row
  parameter [7:0] Wnnz = Wrow[M*8+:8],
  parameter [Wnnz-1:0] Wvals = 0,  // Bits of not-zeroes
  parameter [(8*Wnnz)-1:0] Wcol = 0, // Column of non-zeros
  parameter [M*8-1:0] Delta = 32'h01010101,
  parameter [7:0] maxlen = 8'h01,
  parameter SumL = 2
  ) (
  input clk,
  input rst,
  input [N-1:0] data,
  input enable,
  /* output [M-1:0] out */
  output [M*(SumL+2)-1:0] soums
  );
  
  localparam SoumL = SumL + 2;
  /* initial $display("SoumL %h, %h, %d",Delta,maxlen,SoumL); */
  wire [N-1:0] data_n;
  reg [$clog2(N)-1:0] cnt;
  // (sums with correction term)
  wire [M*SumL-1:0] sums;

  assign data_n = ~data;
  
genvar i,j;

  generate
      for(j=0;j<M;j=j+1)begin
        localparam Len = Delta[j*8+:8];
        if (Len!=0) begin
        localparam First = Wrow[j*8+:8];
        localparam [Len-1:0] Valz = Wvals[First+:Len];
        // if has
        wire [Len-1:0] Vec;
        for(i=0;i<Len;i=i+1)begin
            if(Valz[i])
                assign Vec[i] = data[Wcol[(First+i)*8+:8]];
            else
                assign Vec[i] = data_n[Wcol[(First+i)*8+:8]];
        end
        /* initial begin */
        /*     # 10 */
        /*     $display("Vec %d %d %b",j,Len,Vec); */
        /* end */
        localparam acclen = $clog2(Len+1);
        teraccum #(.N(Len), .Total(N)) popc (
            .data_in(Vec[cnt]),
            .clk(clk),
            .ena(enable),
            .cnt(cnt),
            .rst(rst),
            .acc(sums[j*SumL+:acclen])
        );
        if(SumL>acclen)
            assign sums[j*SumL+SumL-1:j*SumL+acclen] = 0;
        assign soums[j*SoumL+:SoumL] = 2*sums[j*SumL+:SumL]+maxlen-Len;
    end else begin
        assign soums[j*SoumL+:SoumL] = maxlen;
      end
      end
  endgenerate

  assign off = cnt==N-1;

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if (enable) begin
          if(!off) begin
              cnt <= cnt + 1;
          end
      end
  end

endmodule
