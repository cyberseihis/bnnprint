module tbbnnseq;

  localparam N = 16;
  localparam M = 40;
  localparam B = 4;
  localparam C = 10;

  
  wire [B*N-1:0] data;
  reg rst;
  reg clk;
  
  assign data =  64'h8f4d96400498fe6f;
  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 bnnseq #(.N(N), .B(B), .M(M), .C(C)) dut (
    .data(data),
    .clk(clk),
    .rst(rst),
    .klass(klass)
  );
  
  always #5 clk <= ~clk;

  integer i;
  // Write output numbers to file
  initial begin
    $monitor("sums %h %0t",dut.sums,$time);
    $monitor("1done %h %0t",dut.layers.layer1.done,$time);
    rst <= 1;
    clk <= 0;
    #2
    rst <= 0;
    #3
    #((N+M-2)*10)
    #1
    thesums();
    $finish;
  end


  task thesums(); begin
    $write("[");
    for(i=0;i<C;i=i+1)
        $write(" %d,",dut.sums[i*SumL+:SumL]);
    $display("]");
  end
  endtask

endmodule
