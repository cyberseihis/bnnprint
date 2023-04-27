module xnor_layer_tnn #(
  parameter HIDDEN_CNT = 4,
  parameter CLASS_CNT = 4,
  // CSR of weight martix
  parameter [((CLASS_CNT+1)*8)-1:0] ROW_PTRS = 40'h0403020100, // Column of non-zeros // Start indices per row
  parameter [7:0] NONZERO_CNT = ROW_PTRS[CLASS_CNT*8+:8],
  parameter [NONZERO_CNT-1:0] SPARSE_VALS = 0,  // Bits of not-zeroes
  parameter [(8*NONZERO_CNT)-1:0] COL_INDICES = 0, // Column of non-zeros
  parameter [CLASS_CNT*8-1:0] ROW_DELTA = 32'h01010101,
  parameter [7:0] MAXLEN = 8'h01,
  parameter SUM_BITS = 2
  ) (
  input clk,
  input rst,
  input [HIDDEN_CNT-1:0] features,
  input enable,
  output [CLASS_CNT*(SUM_BITS+2)-1:0] scores
  );
  
  localparam SCORE_BITS = SUM_BITS + 2;
  wire [HIDDEN_CNT-1:0] features_n;
  reg [$clog2(HIDDEN_CNT)-1:0] cnt;
  // (sums with correction term)
  wire [CLASS_CNT*SUM_BITS-1:0] sums;
  wire off;

  assign features_n = ~features;
  
genvar i,j;

  generate
      for(j=0;j<CLASS_CNT;j=j+1)begin
        localparam Len = ROW_DELTA[j*8+:8];
        if (Len!=0) begin
        localparam First = ROW_PTRS[j*8+:8];
        localparam [Len-1:0] Valz = SPARSE_VALS[First+:Len];
        wire [Len-1:0] hybrid;
        for(i=0;i<Len;i=i+1)begin
            if(Valz[i])
                assign hybrid[i] = features[COL_INDICES[(First+i)*8+:8]];
            else
                assign hybrid[i] = features_n[COL_INDICES[(First+i)*8+:8]];
        end
        localparam acclen = $clog2(Len+1);
        popcount_tnn #(.SIZE(Len), .TOTAL(HIDDEN_CNT)) popc (
            .sample(hybrid[cnt]),
            .clk(clk),
            .enable(enable),
            .cnt(cnt),
            .rst(rst),
            .acc(sums[j*SUM_BITS+:acclen])
        );
        if(SUM_BITS>acclen)
            assign sums[j*SUM_BITS+SUM_BITS-1:j*SUM_BITS+acclen] = 0;
        assign scores[j*SCORE_BITS+:SCORE_BITS] = 2*sums[j*SUM_BITS+:SUM_BITS]+MAXLEN-Len;
    end else begin
        assign scores[j*SCORE_BITS+:SCORE_BITS] = MAXLEN;
      end
      end
  endgenerate

  assign off = cnt==HIDDEN_CNT-1;

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
