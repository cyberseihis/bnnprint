








module tbwinequality-red_bnn_seq #(

parameter N = 11,
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


assign testcases[0] = 44'h46012229a22;
assign testcases[1] = 44'h58022538633;
assign testcases[2] = 44'h57122338733;
assign testcases[3] = 44'h92912439523;
assign testcases[4] = 44'h46012229a22;


  
  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 winequality-red_bnn_seq #() dut (
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
        $write(" %d,",dut.sums[i*SumL+:SumL]);
    $display("]");
  end
  endtask

endmodule
