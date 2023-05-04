module first_layer_tnnzew #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] SPARSE_VALS = 0,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] MASK = 0,
  parameter [8*HIDDEN_CNT-1:0] NONZERO_CNT = 0,
  parameter [8*HIDDEN_CNT-1:0] WIDTHS = 0
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [HIDDEN_CNT-1:0] out,
  output done
  );
  
  
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

    function [7:0] maxlen(input integer y);
        integer i;
        reg [7:0] mx;
        begin
        mx = 0;
        for(i=0;i<HIDDEN_CNT;i=i+1) begin
           if(nnz_cnt(i)>mx) mx = nnz_cnt(i);
        end
        maxlen = mx;
        end
    endfunction

    localparam MAXLEN = maxlen(0);

    integer y;

  reg [$clog2(FEAT_CNT)-1:0] cnt;
  wire reached_last;
  assign done = reached_last;


  genvar i,j;
  generate
  for (i=0;i<HIDDEN_CNT;i=i+1) begin
    wire signed [FEAT_BITS:0] olaf [FEAT_CNT-1:0];
    wire signed [FEAT_BITS:0] sample;
    localparam [FEAT_CNT-1:0] veil = MASK[i*FEAT_CNT+:FEAT_CNT];
    localparam [FEAT_CNT-1:0] moreless = SPARSE_VALS[i*FEAT_CNT+:FEAT_CNT];
    assign sample = olaf[cnt];
        for(j=0;j<FEAT_CNT;j=j+1) begin
            if(!veil[j])
                assign olaf[j] = 0;
            else if(moreless[j])
                assign olaf[j] = features[j*FEAT_BITS+:FEAT_BITS];
            else
                assign olaf[j] = -features[j*FEAT_BITS+:FEAT_BITS];
        end
        /* if(i==0) initial begin */
        /*     $monitor("s %d %d",cnt, sample); */
        /* end */
        /* if(i==0) initial begin */
        /*     #1 */
        /*     $display("v %b",moreless); */
        /*     $display("m %b",veil); */
        /*     $display("f %h",features); */
        /*     for(y=0;y<FEAT_CNT;y=y+1) */
        /*         $write("%d, ",olaf[y]); */
        /*     $display("k"); */
        /* end */
      accumulator_tnnzew #(.SIZE(WIDTHS[i*8+:8]), .BITS(FEAT_BITS)) tacc (
        .sample(sample),
        .clk(clk),
        .halt(reached_last),
        .rst(rst),
        .out(out[i])
      );
    end
  endgenerate

  /* initial $monitor("mid %b",out); */

  assign reached_last = cnt==FEAT_CNT-1;

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!reached_last) begin
          cnt <= cnt + 1;
      end
  end
  
endmodule