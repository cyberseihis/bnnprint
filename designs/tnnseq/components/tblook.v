module tblook ();

parameter N = 11;
parameter M = 40;
parameter B = 4;
parameter C = 7;
parameter Ts = 5;


parameter Wvals = 440'b00010001000000000100111010000100000100000000001110011010101111111000000011011110011000101001111010100011100000001001001001001010001000101010000001010010101000001100001001010100100000010001001010100000000110000010100011001001000001110110000101000110111100011011000110010000000101011100001001001000101001010000001111000000001000000001010000000111000000000001000001101000000000101000000000010010000110000110100001000000100010110100010100000001;
parameter Wzero = 440'b10011001110000000100111010000101000100011001101110011010111111111100011111111110011001101001111010110011101101001011101001001110011000111011011011110110101101001111101101010110110110010101001010110101001110011011110011011011100001110110110101110111111100111011101110010000001111011111011101101011111011011100011111011001101000001101010101100111000001000001000111101010100110101001010000010110000111000110100101011110101011111110110100000011;
parameter Wnnz = 320'h06070806070407070707040806050804090607070707080808050305010906050503060906060307;
  
  parameter WvalsX = 79'b0100000010110010011000100000110000101111111100111011000110111010101011011001010;
  parameter WcolX = 632'h2625232221201e1b1817141211100d0c0605040201211f17100d0b211c1615100c0825211f1817100f0125242119181412092625221f1e1c1817161413100b0a07261c171412100f0b0a0907060401;
 parameter WrowX = 56'h3a342d251d0e00;
 parameter WnnzX = 8'h4f;

  wire [B*N-1:0] data;
  wire [B*N-1:0] testcases [Ts-1:0];
  reg rst;
  reg clk;
  parameter Nsperiod=50000;
  localparam period=Nsperiod/500;
  localparam halfT=period/2;

assign data = 44'h53352264442;

  localparam SumL = $clog2(M+1);
  wire [$clog2(C)-1:0] klass;

  // Instantiate module under test
 seqtenlego #(
    .N(N),
    .M(M),
    .B(B),
    .C(C),
    .Wvals(Wvals),
    .Wzero(Wzero),
    .Wnnz(Wnnz),
    .WnnzX(WnnzX),
    .WvalsX(WvalsX),
    .WcolX(WcolX),
    .WrowX(WrowX)
 ) dut (
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
    for(i=0;i<1;i=i+1)
        runtestcase(i);
    $finish;
  end

  task runtestcase(input integer i); begin
    /* data <= testcases[i]; */
    rst <= 1;
    clk <= 0;
    #period
    rst <= 0;
    #period
    #((N+M-1)*period)
    /* thesums(); */
    $display("mid %b",dut.revmidd);
    $display("sums %h",dut.out);
    $display("klass %d",data,(C-1-klass));
    /* $display("%h %d",data,(C-1-klass)); */
  end
  endtask

  task thesums(); begin
    $write("[");
    for(i=0;i<C;i=i+1)
        $write("%d, ",dut.out[i*SumL+:SumL]);
    $display("]");
  end
  endtask

endmodule
