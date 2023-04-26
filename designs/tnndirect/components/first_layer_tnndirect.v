module first_layer_tnndirect #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] SPARSE_VALS = 0,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] MASK = 0,
  parameter [8*HIDDEN_CNT-1:0] NONZERO_CNT = 0
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [HIDDEN_CNT-1:0] out,
  output done
  );
  
  reg [$clog2(FEAT_CNT)-1:0] cnt;
  wire [FEAT_BITS-1:0] in;
  wire reached_last;

  assign done = reached_last;
  
    // position of 1 in mr to # of 1s before it
    // aka index in sparce array
    function integer nth(
        input [FEAT_CNT-1:0] mask,
        input integer a
    );
    integer i,j;
    begin
    i = -1;
    for(j=0;j<=a;j=j+1)begin
       if(mask[j]) i = i+1;  
    end
    nth = i; 
    end
    endfunction


    function integer onez(input [FEAT_CNT-1:0] mask);
        onez = nth(mask,FEAT_CNT-1) + 1;
    endfunction

    function [7:0] nnz_cnt(input integer y);
        nnz_cnt = onez(MASK[y*FEAT_CNT+:FEAT_CNT]);
    endfunction

    integer y;
    /* initial begin */
    /*     $display("g %h", NONZERO_CNT); */
    /*     for(y=0;y<HIDDEN_CNT;y=y+1) */
    /*         $display("d %h", nnz_cnt(y)); */
    /**/
    /* end */

  genvar i,j;
  generate
    for (i=0;i<HIDDEN_CNT;i=i+1) begin
    wire signed [(FEAT_BITS+1)-1:0] olaf [nnz_cnt(i)-1:0];
    localparam [FEAT_CNT-1:0] veil = MASK[i*FEAT_CNT+:FEAT_CNT];
        for(j=0;j<FEAT_CNT;j=j+1) begin
            if(veil[j])
                assign olaf[nth(veil,j)] = features[j*FEAT_BITS+:FEAT_BITS];
        end
        if(i==0) initial begin
            #10
            $display("veil %b",veil);
            $display("feat %h",features);
            for(y=0;y<nnz_cnt(i);y=y+1)
                $write("olaf %h ", olaf[y]);
        end
      accumulator_tnndirect #(.SIZE(NONZERO_CNT[8*i+:8]), .BITS(FEAT_BITS)) tacc1 (
        .sample(olaf[cnt]),
        .clk(clk),
        .halt(reached_last),
        .rst(rst),
        .out(out[i])
      );
    end
  endgenerate

  assign reached_last = cnt==FEAT_CNT-1;
  assign in = features[cnt*FEAT_BITS+:FEAT_BITS];
  assign weight = SPARSE_VALS[cnt*HIDDEN_CNT+:HIDDEN_CNT];
  assign iszero = MASK[cnt*HIDDEN_CNT+:HIDDEN_CNT];

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!reached_last) begin
          cnt <= cnt + 1;
      end
  end
  
endmodule
