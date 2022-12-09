module smallchangesum (
input [30:0] e,
input [30:0] d,
input [30:0] a1,
input [30:0] a2,
input [30:0] a3,
input [30:0] a4,
input [30:0] a5,
input [30:0] a6,
input [30:0] a7,
input [30:0] a8,
input [30:0] a9,
input [30:0] a10,
input [30:0] a11,
input [30:0] a12,
input [30:0] a13,
input [30:0] a14,
input [30:0] a15,
input [30:0] a16,
input [30:0] a17,
input [30:0] a18,
input [30:0] a19,
input [30:0] a20,
input [30:0] a21,
input [30:0] a22,
input [30:0] a23,
input [30:0] a24,
input [30:0] a25,
output [35:0] out,
output [35:0] out2
);

assign out = a1+ a2+ a3+ a4+ a5+ a6+ a7+ a8+ a9+ a10+ a11+ e+ a12+ a13+ a14+ a15+ a16+ a17+ a18+ a19+ a20+ a21+ a22+ a23+ a24+ a25;
assign out2 = a24+ a2+ a15+ a7+ a9+ a19+ a3+ a16+ a18+ a14+ d+ a23+ a1+ a20+ a17+ a25+ a12+ a13+ a8+ a21+ a10+ a4+ a22+ a6+ a5+ a11;

endmodule
