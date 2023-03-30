`timescale 1us/1ns









module tbHar_bs #(

parameter N = 12,
parameter M = 40,
parameter B = 4,
parameter C = 6,
parameter Ts = 5


)();

  
  reg [B*N-1:0] data;
  wire [B*N-1:0] testcases [Ts-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;


assign testcases[0] = 48'hb9811498a121;
assign testcases[1] = 48'hb9700187a110;
assign testcases[2] = 48'hb9700088a000;
assign testcases[3] = 48'hb9700088a000;
assign testcases[4] = 48'hb97000889000;


  
  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 Har_bs #() dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .klass(klass)
  );
  
  always #halfT clk <= ~clk;

  integer i;
  initial begin
    /* $monitor("sums %h %0t",dut.sums,$time); */
    /* $monitor("1done %h %0t",dut.layers.layer1.done,$time); */
    $write("["); //"
    for(i=0;i<Ts;i=i+1)
        runtestcase(i);
    $display("]");
    $finish;
  end

  localparam [$clog2(C)-1:0] maxklass = C-1;

  task runtestcase(input integer i); begin
    data <= testcases[i];
    rst <= 1;
    clk <= 0;
    #period
    rst <= 0;
    #period
    #((N+M-1)*period)
    $write("%d, ",(maxklass-klass));
  end
  endtask

  task thesums(); begin
    $write("[");
    for(i=0;i<C;i=i+1)
        $write("%d, ",dut.sums[i*SumL+:SumL]);
    $display("]");
  end
  endtask

endmodule
