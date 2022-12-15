module compare1side (
input unsigned [30:0] a1,
input unsigned [30:0] a2,
input unsigned [30:0] a3,
input unsigned [30:0] a4,
input unsigned [30:0] a5,
input unsigned [30:0] a6,
input unsigned [30:0] a7,
input unsigned [30:0] a8,
input unsigned [30:0] a9,
input unsigned [30:0] a10,
input unsigned [30:0] a11,
input unsigned [30:0] a12,
input unsigned [30:0] a13,
input unsigned [30:0] a14,
input unsigned [30:0] a15,
input unsigned [30:0] a16,
input unsigned [30:0] a17,
input unsigned [30:0] a18,
input unsigned [30:0] a19,
input unsigned [30:0] a20,
input unsigned [30:0] a21,
input unsigned [30:0] a22,
input unsigned [30:0] a23,
input unsigned [30:0] a24,
input unsigned [30:0] a25,
output  out
);

assign out = $signed(a1+ a2+ a3+ a4+ a5+ a6+ a7+ a8+ a9+ a10+ a11+ a12+ a13- (a14+ a15+ a16+ a17+ a18+ a19+ a20+ a21+ a22+ a23+ a24+ a25)) < 555;

endmodule
