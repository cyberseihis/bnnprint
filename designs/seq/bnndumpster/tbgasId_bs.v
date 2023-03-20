








module tbgasId_bs #(

parameter N = 128,
parameter M = 40,
parameter B = 4,
parameter C = 6,
parameter Ts = 5


)();

  
  reg [B*N-1:0] data;
  wire [B*N-1:0] testcases [Ts-1:0];
  reg rst;
  reg clk;
  localparam period=10;
  localparam halfT=period/2;


assign testcases[0] = 512'h10000fef10000fff41000fff50000fff20000fff30000fff30000fef30000fef10000fff10000fff21000fff21000fff21000fff21100fff21000fef21000fef;
assign testcases[1] = 512'h10100fef10100fff41000fff50000fff20000fff30000fff30000fef40000fef10100fff10110fff21100fef21000fef22100fff22100fff21000fef21000fef;
assign testcases[2] = 512'h10110fef20100fff51000fff50000fff30000fff40000eff40100fef40100fef10110fff10111fef31110fef32100fef32100eff32100eff22100fef22100fef;
assign testcases[3] = 512'h10111fef20110fff51100fff50000fff30000fff40000eff40100fef40100fef10111fff10111fef31110fef32110fef32200eff32200eff22110fef22100fef;
assign testcases[4] = 512'h20110fef20110eff52100fff51000fff30000fff40000eff40100fef40100fef20111eef20111eef32110fef32110fef33200eff43200dff22110fef32100fef;


  
  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 gasId_bs #() dut (
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
    for(i=0;i<Ts;i=i+1)
        runtestcase(i);
    $finish;
  end

  task runtestcase(input integer i); begin
    data <= testcases[i];
    rst <= 1;
    clk <= 0;
    #2
    rst <= 0;
    #(period-2)
    #((N+M-1)*period)
    $display("%h %d",data,(C-1-klass));
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
