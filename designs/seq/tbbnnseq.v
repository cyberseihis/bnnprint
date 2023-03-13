module tbbnnseq;

  localparam N = 16;
  localparam M = 40;
  localparam B = 4;
  localparam C = 10;
  localparam Ts = 5;

  
  reg [B*N-1:0] data;
  wire [B*N-1:0] testcases [Ts];
  reg rst;
  reg clk;
  localparam period=10;
  localparam halfT=period/2;

  
  assign testcases[0] =  64'h8f4d96400498fe6f;
  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 bnnseq #(.N(N), .B(B), .M(M), .C(C)) dut (
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
    runtestcase(0);
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
