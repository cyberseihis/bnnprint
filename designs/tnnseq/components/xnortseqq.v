module xnortseqq #(
  parameter N = 4,
  parameter M = 4,
  // CSR of weight martix
  parameter [Wnnz-1:0] Wvals = 0,  // Bits of not-zeroes
  parameter [(8*Wnnz)-1:0] Wcol = 0, // Column of non-zeros
  parameter [((M+1)*8)-1:0] Wrow = 40'h0403020100 // Column of non-zeros // Start indices per row
  ) (
  input clk,
  input rst,
  input [N-1:0] data,
  input enable,
  /* output [M-1:0] out */
  output [M*SoumL-1:0] soums
  );
  
  localparam [7:0] Wnnz = Wrow[M*8+:8];
  /* localparam SumL = $clog2(N+1); */
  localparam SumL = 8;
  // Find length of soums(sums with correction term)
  localparam SoumL = 8;
  wire [N-1:0] data_n;
  reg [$clog2(N)-1:0] cnt;
  // (sums with correction term)
  wire [M*SumL-1:0] sums;

  assign data_n = ~data;
  
  /* parameter [(M*8)-1:0] Delta = {Wnnz,Wrow[M*8-1:8]} - Wrow; */
  parameter [(M*8)-1:0] Delta = Wrow[8+:M*8] - Wrow[0+:M*8];
  initial begin
      $display("Delta %h",Delta);
      $display("ROW %h",Wrow);
  end
  genvar i,j;
  wire [7:0] xd [M-1:0];
  wire [7:0] maxlen;
  assign xd[0]=Delta[0+:8];
  for (i=1; i<M;i=i+1) begin
      assign xd[i]=xd[i-1]>Delta[i*8+:8]?xd[i-1]:Delta[i*8+:8];
  end
  assign maxlen = xd[M-1];
  generate
      for(j=0;j<M;j=j+1)begin
        localparam Len = $unsigned(Delta[j*8+:8]);
        if (Len!=0) begin
        localparam First = $unsigned(Wrow[j*8+:8]);
        localparam Valz = Wvals[First+:Len];
        // if has
        wire [Len-1:0] Vec;
        for(i=0;i<Len;i=i+1)begin
            if(Valz[i])
                assign Vec[i] = data[Wcol[(First+i)*8+:8]];
            else
                assign Vec[i] = data_n[Wcol[(First+i)*8+:8]];
        end
        initial begin
            # 10
            $display("Vec %d %d %b",j,Len,Vec);
        end
        teraccum #(.N(Len), .Total(N)) popc (
            .data_in(Vec[cnt]),
            .clk(clk),
            .ena(enable),
            .cnt(cnt),
            .rst(rst),
            .acc(sums[j*SumL+:SumL])
        );
        assign soums[j*SumL+:SumL] = 2*sums[j*SumL+:SumL]+maxlen-Len;
    end else begin
        assign soums[j*SumL+:SumL] = maxlen;
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
