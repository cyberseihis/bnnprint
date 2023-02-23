module maxreducer #(
  parameter N = 8,
  parameter K = 4
) (
  input [N*K-1:0] in,
  output [(N+1)/2*K-1:0] out
);

  // Generate multiple instances of the f module
  genvar i;
  generate
    for (i = 0; i < (N+1)/2; i = i + 1) begin : f_instances
      if (i == (N+1)/2 - 1 && N % 2 == 1) begin
        // If there is an odd number of elements, pass the last one through
        assign out[i*K +: K] = in[N*K-K +: K];
      end else begin
        max_module #(.K(K)) maxx (
          .a(in[i*2*K +: K]),
          .b(in[i*2*K+K +: K]), // add K to the starting index
          .max_out(out[i*K +: K])
        );
      end
    end
  endgenerate

endmodule

