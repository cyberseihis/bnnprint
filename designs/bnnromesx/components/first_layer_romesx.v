module first_layer_romesx #(
  parameter FEAT_CNT = 4,
  parameter FEAT_BITS = 4,
  parameter HIDDEN_CNT = 4,
  parameter [HIDDEN_CNT*FEAT_CNT-1:0] Weights = 0
  ) (
  input clk,
  input rst,
  input [FEAT_CNT*FEAT_BITS-1:0] features,
  output [HIDDEN_CNT-1:0] hidden,
  output done
  );
  
  reg [HIDDEN_CNT-1:0] hiddreg;
  assign hidden = hiddreg;
  localparam CNT_LEN = $clog2(HIDDEN_CNT+1);
  localparam CAP_HIDDEN = 2**$clog2(HIDDEN_CNT)-1;
  reg [CNT_LEN-1:0] cnt;
  wire reached_end;

  assign done = reached_end;

function [CNT_LEN-1:0] rol (
    input [CNT_LEN-1:0] rin
);
rol = {rin[CNT_LEN-2:0], rin[CNT_LEN-1] ^~ rin[CNT_LEN-2]};
endfunction

function [CNT_LEN-1:0] roln (
    input integer n
);
reg [CNT_LEN-1:0] x;
integer i;
begin
    x = 0;
    for(i=0;i<n;i=i+1)
        x = rol(x);
    roln = x;
end
endfunction


    function [7:0] n_negs(
        input [FEAT_CNT-1:0] mask
    );
    integer i,j;
    begin
    i = 0;
    for(j=0;j<FEAT_CNT;j=j+1)begin
       if(!mask[j]) i = i+1;  
    end
    n_negs = i; 
    end
    endfunction

    function [HIDDEN_CNT*8-1:0] fullnegs(
        input integer a
    );
    reg [HIDDEN_CNT*8-1:0] ng;
    integer j;
    begin
    for(j=0;j<HIDDEN_CNT;j=j+1)begin
       ng[j*8+:8] = n_negs(Weights[j*FEAT_CNT+:FEAT_CNT]);
    end
    fullnegs = ng;
    end
    endfunction

    localparam [HIDDEN_CNT*8-1:0] NEG_CNT = fullnegs(0);
    wire [7:0] NEG_CAP [CAP_HIDDEN-1:0];
  
  wire signed [FEAT_BITS:0] moment [FEAT_CNT-1:0];
  wire signed [FEAT_BITS:0] sfeat [FEAT_CNT-1:0];
  wire [FEAT_CNT-1:0] Mesaweight [CAP_HIDDEN-1:0];
  wire [FEAT_CNT-1:0] slice;
  assign slice = Mesaweight[cnt];
  //ALL 1s IS NOT REACHABLE
  //WARNING NOT FULL RANGE OF VALUES IS ACCESSIBLE PER LENGTH
  genvar i,j;
  generate
    for (i=0;i<FEAT_CNT;i=i+1) begin
        assign sfeat[i] = {1'b0,features[i*FEAT_BITS+:FEAT_BITS]};
        assign moment[i] = {5{slice[i]}} ^~ sfeat[i];
    end
    for (i=0;i<HIDDEN_CNT;i=i+1) begin
          assign NEG_CAP[roln(i)] = NEG_CNT[i*8+:8];
          assign Mesaweight[roln(i)] = Weights[i*FEAT_CNT+:FEAT_CNT];
    end
  endgenerate

  reg signed [FEAT_BITS+$clog2(FEAT_CNT+1)-1:0] soom;
  integer y;
  always @* begin
      soom = 0;
      for (y=0;y<FEAT_CNT;y=y+1)
          soom = soom + moment[y];
      soom = soom + NEG_CAP[cnt];

  end

  assign reached_end = cnt==HIDDEN_CNT;

  initial $monitor("%b | %b", cnt, slice);

  always @(posedge clk or posedge rst) begin
      if(rst) begin
          cnt <= 0;
      end
      else if(!reached_end) begin
          cnt <= {cnt[CNT_LEN-2:0], cnt[CNT_LEN-1] ^~ cnt[CNT_LEN-2]};
          hiddreg <= {soom >= 0,hiddreg[HIDDEN_CNT-1:1]};
      end
  end
  
endmodule
