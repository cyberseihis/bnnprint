// BSD 3-Clause License
// 
// Copyright 2020 Lawrence T. Clark, Vinay Vashishtha, or Arizona State
// University
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// 
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from this
// software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A1 PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

// Verilog for library /home/ltclark/ASAP7/LIB2/Liberate_2/Verilog/asap7sc7p5t_AO_LVT_TT_201020 created by Liberate 18.1.0.293 on Tue Dec  1 18:30:44 MST 2020 for SDF version 2.1

`timescale 1ns/10ps



`celldefine
module DFFNRX1 (D, CP, RST_N, Q);
	output Q;
	input D, CP, RST_N;
    wire Q_bar;
    DFFNRXA dffxa (Q_bar,D,RST_N,Q,CP);
    assign Q = ~Q_bar;
endmodule
`endcelldefine

module DFFNRXA (Q_bar,R,RST_N,Q,CP);
    output Q_bar;
    input R,RST_N,Q,CP;
reg notifier;
	wire delayed_D, delayed_RST_N, delayed_Q, delayed_CP;

	// Function
	wire int_fwire_d, int_fwire_IQ_bar, xcr_0;

	not (int_fwire_d, delayed_D);
	altos_dff_sr_err (xcr_0, delayed_CP, int_fwire_d, delayed_Q, delayed_RST_N);
	altos_dff_sr_1 (int_fwire_IQ_bar, notifier, delayed_CP, int_fwire_d, delayed_Q, delayed_RST_N, xcr_0);
	buf (Q_bar, int_fwire_IQ_bar);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire adacond6, adacond7, adacond8;
	wire CP__bar, D__bar, RST_N__bar;
	wire Q__bar;


	// Additional timing gates
	not (Q__bar, Q);
	not (RST_N__bar, RST_N);
	and (adacond0, RST_N__bar, Q__bar);
	not (D__bar, R);
	and (adacond1, D__bar, Q__bar);
	and (adacond2, CP, Q__bar);
	not (CP__bar, CP);
	and (adacond3, CP__bar, Q__bar);
	and (adacond4, R, RST_N__bar);
	and (adacond5, CP, RST_N__bar);
	and (adacond6, CP__bar, RST_N__bar);
	and (adacond7, R, RST_N__bar, Q__bar);
	and (adacond8, D__bar, RST_N__bar, Q__bar);

	specify
		if ((CP & ~Q))
			(posedge RST_N => (Q_bar+:1'b0)) = 0;
		if ((~CP & R & ~Q))
			(posedge RST_N => (Q_bar+:1'b0)) = 0;
		if ((~CP & ~R & ~Q))
			(posedge RST_N => (Q_bar+:1'b0)) = 0;
		ifnone (posedge RST_N => (Q_bar+:1'b0)) = 0;
		if ((CP & RST_N))
			(negedge Q => (Q_bar+:1'b0)) = 0;
		if ((~CP & R & RST_N))
			(negedge Q => (Q_bar+:1'b0)) = 0;
		if ((~CP & ~R & RST_N))
			(negedge Q => (Q_bar+:1'b0)) = 0;
		ifnone (negedge Q => (Q_bar+:1'b0)) = 0;
		if ((CP & RST_N))
			(posedge Q => (Q_bar+:1'b1)) = 0;
		if ((CP & ~RST_N))
			(posedge Q => (Q_bar+:1'b1)) = 0;
		if ((~CP & R & RST_N))
			(posedge Q => (Q_bar+:1'b1)) = 0;
		if ((~CP & R & ~RST_N))
			(posedge Q => (Q_bar+:1'b1)) = 0;
		if ((~CP & ~R & RST_N))
			(posedge Q => (Q_bar+:1'b1)) = 0;
		if ((~CP & ~R & ~RST_N))
			(posedge Q => (Q_bar+:1'b1)) = 0;
		ifnone (posedge Q => (Q_bar+:1'b1)) = 0;
		(posedge CP => (Q_bar+:!R)) = 0;
		$setuphold (posedge CP &&& adacond0, posedge R &&& adacond0, 0, 0, notifier,,, delayed_CP, delayed_D);
		$setuphold (posedge CP &&& adacond0, negedge R &&& adacond0, 0, 0, notifier,,, delayed_CP, delayed_D);
		$setuphold (posedge CP, posedge R, 0, 0, notifier,,, delayed_CP, delayed_D);
		$setuphold (posedge CP, negedge R, 0, 0, notifier,,, delayed_CP, delayed_D);
		$setuphold (negedge Q &&& CP, negedge RST_N &&& CP, 0, 0, notifier,,, delayed_Q, delayed_RST_N);
		$setuphold (negedge Q &&& ~CP, negedge RST_N &&& ~CP, 0, 0, notifier,,, delayed_Q, delayed_RST_N);
		$setuphold (negedge Q, negedge RST_N, 0, 0, notifier,,, delayed_Q, delayed_RST_N);
		$setuphold (negedge RST_N &&& CP, negedge Q &&& CP, 0, 0, notifier,,, delayed_RST_N, delayed_Q);
		$setuphold (negedge RST_N &&& ~CP, negedge Q &&& ~CP, 0, 0, notifier,,, delayed_RST_N, delayed_Q);
		$setuphold (negedge RST_N, negedge Q, 0, 0, notifier,,, delayed_RST_N, delayed_Q);
		$recovery (negedge RST_N &&& adacond1, posedge CP &&& adacond1, 0, notifier);
		$recovery (negedge RST_N, posedge CP, 0, notifier);
		$hold (posedge CP &&& adacond1, negedge RST_N &&& adacond1, 0, notifier);
		$hold (posedge CP, negedge RST_N, 0, notifier);
		$recovery (negedge Q &&& adacond4, posedge CP &&& adacond4, 0, notifier);
		$recovery (negedge Q, posedge CP, 0, notifier);
		$hold (posedge CP &&& adacond4, negedge Q &&& adacond4, 0, notifier);
		$hold (posedge CP, negedge Q, 0, notifier);
		$width (posedge RST_N &&& adacond2, 0, 0, notifier);
		$width (posedge RST_N &&& adacond3, 0, 0, notifier);
		$width (posedge Q &&& adacond5, 0, 0, notifier);
		$width (posedge Q &&& adacond6, 0, 0, notifier);
		$width (posedge CP &&& adacond7, 0, 0, notifier);
		$width (negedge CP &&& adacond7, 0, 0, notifier);
		$width (posedge CP &&& adacond8, 0, 0, notifier);
		$width (negedge CP &&& adacond8, 0, 0, notifier);
	endspecify
endmodule


/* `celldefine */
/* module DFFNRX1 (D, CP, RST_N, Q, Q_bar); */
/*     output Q, Q_bar; */
/*     input D, CP, RST_N; */
/*     dflop dfflop (Q, D, ~CP, RST_N); */
/* endmodule */
/* `endcelldefine */
/**/
/* primitive dflop (Q, D, CP, RST_N); */
/*     output Q; */
/*     input D, CP, RST_N; */
/*     reg Q; */
/*      */
/*     table */
/*         ? ?    0 : ? : 0; */
/*         ? (??) 0 : ? : 0; */
/*         0 (10) 1 : ? : 0; */
/*         1 (10) 1 : ? : 1; */
/*         0 (1?) 1 : 0 : 0; */
/*         1 (1?) 1 : 1 : 1; */
/*         ? (?1) 1 : ? : -; */
/*         (??) ? 1 : ? : -; */
/*     endtable */
/**/
/* endprimitive */


// type:  
//`timescale 1ns/10ps
//`celldefine
//module DFFX1 (Q, R, CP);
//	output Q;
//	input R, CP;
//	reg notifier;
//	wire delayed_D, delayed_CP;
//
//	// Function
//	wire int_fwire_CP, int_fwire_IQ, xcr_0;
//
//	not (int_fwire_CP, delayed_CP);
//	altos_dff_err (xcr_0, int_fwire_CP, delayed_D);
//	altos_dff (int_fwire_IQ, notifier, int_fwire_CP, delayed_D, xcr_0);
//	buf (Q, int_fwire_IQ);
//
//	// Timing
//	specify
//		(negedge CP => (Q+:R)) = 0;
//		$setuphold (negedge CP, posedge R, 0, 0, notifier,,, delayed_CP, delayed_D);
//		$setuphold (negedge CP, negedge R, 0, 0, notifier,,, delayed_CP, delayed_D);
//		$width (posedge CP &&& R, 0, 0, notifier);
//		$width (negedge CP &&& R, 0, 0, notifier);
//		$width (posedge CP &&& ~R, 0, 0, notifier);
//		$width (negedge CP &&& ~R, 0, 0, notifier);
//	endspecify
//endmodule
//`endcelldefine


// type:  (from tsmc) !!
`timescale 1ns/10ps
`celldefine
module DFFX1 (R, CP, Q_bar, Q);
    input R, CP, Q_bar;
    output Q;
    reg notifier;
    `ifdef NTC
        `ifdef RECREM
            wire Q_bar_d;
            buf (Q_bar_i, Q_bar_d);
        `else 
            buf (Q_bar_i, Q_bar);
        `endif 
        wire D_d, CP_d;
        pullup (SDN);
        tsmc_dff (Q_buf, D_d, CP_d, Q_bar_i, SDN, notifier);
        buf (Q, Q_buf);
    `else 
        buf (Q_bar_i, Q_bar);
        pullup (SDN);
        tsmc_dff (Q_buf, R, CP, Q_bar_i, SDN, notifier);
        buf (Q, Q_buf);
    `endif 

  `ifdef TETRAMAX
  `else
    tsmc_xbuf (Q_bar_SDFCHK, Q_bar, 1'b1);
    tsmc_xbuf (D_SDFCHK, R, 1'b1);
    tsmc_xbuf (CP_D_SDFCHK, CP_D, 1'b1);
    tsmc_xbuf (CP_nD_SDFCHK, CP_nD, 1'b1);
    tsmc_xbuf (nCP_D_SDFCHK, nCP_D, 1'b1);
    tsmc_xbuf (nCP_nD_SDFCHK, nCP_nD, 1'b1);
    tsmc_xbuf (Q_bar_D_SDFCHK, Q_bar_D, 1'b1);
    tsmc_xbuf (Q_bar_nD_SDFCHK, Q_bar_nD, 1'b1);
  `endif

    not (nD, R);
    not (nCP, CP);
    and (CP_D, CP, R);
    and (CP_nD, CP, nD);
    and (nCP_D, nCP, R);
    and (nCP_nD, nCP, nD);
    and (Q_bar_D, Q_bar, R);
    and (Q_bar_nD, Q_bar, nD);

  // Timing logics defined for default constraint check
  buf  (CP_check, Q_bar_i);
  buf  (D_check, Q_bar_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (CP_DEFCHK, CP_check, 1'b1);
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (CP == 1'b1 && R == 1'b1)
    (negedge Q_bar => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && R == 1'b0)
    (negedge Q_bar => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && R == 1'b1)
    (negedge Q_bar => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && R == 1'b0)
    (negedge Q_bar => (Q+:1'b0)) = (0, 0);
    (posedge CP => (Q+:R)) = (0, 0);
    $width (negedge Q_bar &&& CP_D_SDFCHK, 0, 0, notifier);
    $width (negedge Q_bar &&& CP_nD_SDFCHK, 0, 0, notifier);
    $width (negedge Q_bar &&& nCP_D_SDFCHK, 0, 0, notifier);
    $width (negedge Q_bar &&& nCP_nD_SDFCHK, 0, 0, notifier);
    $width (posedge CP &&& Q_bar_D_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& Q_bar_D_SDFCHK, 0, 0, notifier);
    $width (posedge CP &&& Q_bar_nD_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& Q_bar_nD_SDFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge CP &&& Q_bar_SDFCHK, posedge R , 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& Q_bar_SDFCHK, negedge R , 0, 0, notifier,,, CP_d, D_d);
      $recrem (posedge Q_bar &&& D_SDFCHK, posedge CP &&& D_SDFCHK, 0,0, notifier, , , Q_bar_d, CP_d);
    `else
      $setuphold (posedge CP &&& Q_bar_SDFCHK, posedge R , 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& Q_bar_SDFCHK, negedge R , 0, 0, notifier,,, CP_d, D_d);
      $recovery (posedge Q_bar &&& D_SDFCHK, posedge CP &&& D_SDFCHK, 0, notifier);
      $hold (posedge CP &&& D_SDFCHK, posedge Q_bar , 0, notifier);
    `endif
  `else
    $setuphold (posedge CP &&& Q_bar_SDFCHK, posedge R , 0, 0, notifier);
    $setuphold (posedge CP &&& Q_bar_SDFCHK, negedge R , 0, 0, notifier);
    $recovery (posedge Q_bar &&& D_SDFCHK, posedge CP &&& D_SDFCHK, 0, notifier);
    $hold (posedge CP &&& D_SDFCHK, posedge Q_bar , 0, notifier);
  `endif
  endspecify
  `endif
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module INVX1 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine



// type:  
//`timescale 1ns/10ps
//`celldefine
//module LATCHX1 (Q, R, CP);
//	output Q;
//	input R, CP;
//	reg notifier;
//	wire delayed_D, delayed_CP;
//
//	// Function
//	wire int_fwire_IQ;
//
//	altos_latch (int_fwire_IQ, notifier, delayed_CP, delayed_D);
//	buf (Q, int_fwire_IQ);
//
//	// Timing
//	specify
//		(R => Q) = 0;
//		(posedge CP => (Q+:R)) = 0;
//		$setuphold (negedge CP, posedge R, 0, 0, notifier,,, delayed_CP, delayed_D);
//		$setuphold (negedge CP, negedge R, 0, 0, notifier,,, delayed_CP, delayed_D);
//		$width (posedge CP &&& R, 0, 0, notifier);
//		$width (posedge CP &&& ~R, 0, 0, notifier);
//	endspecify
//endmodule
//`endcelldefine

// type:  (from tsmc) !!
`timescale 1ns/10ps
`celldefine
module LATCHX1 (R, S, Q_bar, Q);
    input R, S, Q_bar;
    output Q;
    reg notifier;
    `ifdef NTC
        `ifdef RECREM
            wire Q_bar_d;
            buf (Q_bar_i, Q_bar_d);
        `else 
            buf (Q_bar_i, Q_bar);
        `endif 
        wire D_d, E_d;
        pullup (SDN);
        tsmc_dla (Q_buf, D_d, E_d, Q_bar_i, SDN, notifier);
        buf (Q, Q_buf);
    `else 
        buf (Q_bar_i, Q_bar);
        pullup (SDN);
        tsmc_dla (Q_buf, R, S, Q_bar_i, SDN, notifier);
        buf (Q, Q_buf);
    `endif 

  `ifdef TETRAMAX
  `else
    tsmc_xbuf (Q_bar_SDFCHK, Q_bar, 1'b1);
    tsmc_xbuf (D_SDFCHK, R, 1'b1);
    tsmc_xbuf (D_nE_SDFCHK, D_nE, 1'b1);
    tsmc_xbuf (nD_nE_SDFCHK, nD_nE, 1'b1);
    tsmc_xbuf (Q_bar_D_SDFCHK, Q_bar_D, 1'b1);
    tsmc_xbuf (Q_bar_nD_SDFCHK, Q_bar_nD, 1'b1);
  `endif

    not (nD, R);
    not (nE, S);
    and (D_nE, R, nE);
    and (nD_nE, nD, nE);
    and (Q_bar_D, Q_bar, R);
    and (Q_bar_nD, Q_bar, nD);

  // Timing logics defined for default constraint check
  buf  (D_check, Q_bar_i);
  `ifdef TETRAMAX
  `else
    tsmc_xbuf (D_DEFCHK, D_check, 1'b1);
  `endif

  `ifdef TETRAMAX
  `else
  specify
    if (R == 1'b1 && S == 1'b1)
    (negedge Q_bar => (Q+:1'b0)) = (0, 0);
    if (R == 1'b1 && S == 1'b0)
    (negedge Q_bar => (Q+:1'b0)) = (0, 0);
    if (R == 1'b0 && S == 1'b0)
    (negedge Q_bar => (Q+:1'b0)) = (0, 0);
    (R => Q) = (0, 0);
    (posedge S => (Q+:R)) = (0, 0);
    $width (negedge Q_bar &&& D_nE_SDFCHK, 0, 0, notifier);
    $width (negedge Q_bar &&& nD_nE_SDFCHK, 0, 0, notifier);
    $width (posedge S &&& Q_bar_D_SDFCHK, 0, 0, notifier);
    $width (posedge S &&& Q_bar_nD_SDFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (negedge S &&& Q_bar_SDFCHK, posedge R , 0, 0, notifier,,, E_d, D_d);
      $setuphold (negedge S &&& Q_bar_SDFCHK, negedge R , 0, 0, notifier,,, E_d, D_d);
      $recrem (posedge Q_bar &&& D_SDFCHK, negedge S &&& D_SDFCHK, 0,0, notifier, , , Q_bar_d, E_d);
    `else
      $setuphold (negedge S &&& Q_bar_SDFCHK, posedge R , 0, 0, notifier,,, E_d, D_d);
      $setuphold (negedge S &&& Q_bar_SDFCHK, negedge R , 0, 0, notifier,,, E_d, D_d);
      $recovery (posedge Q_bar &&& D_SDFCHK, negedge S &&& D_SDFCHK, 0, notifier);
      $hold (negedge S &&& D_SDFCHK, posedge Q_bar , 0, notifier);
    `endif
  `else
    $setuphold (negedge S &&& Q_bar_SDFCHK, posedge R , 0, 0, notifier);
    $setuphold (negedge S &&& Q_bar_SDFCHK, negedge R , 0, 0, notifier);
    $recovery (posedge Q_bar &&& D_SDFCHK, negedge S &&& D_SDFCHK, 0, notifier);
    $hold (negedge S &&& D_SDFCHK, posedge Q_bar , 0, notifier);
  `endif
  endspecify
  `endif
endmodule
`endcelldefine



// type:  
`timescale 1ns/10ps
`celldefine
module NAND2X1 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A__bar, B__bar;

	not (B__bar, A2);
	not (A__bar, A1);
	or (Y, A__bar, B__bar);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module NOR2X1 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A__bar, B__bar;

	not (B__bar, A2);
	not (A__bar, A1);
	and (Y, A__bar, B__bar);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine


//// type:  
//`timescale 1ns/10ps
//`celldefine
//module TSBUF (Y, A1);
//	output Y;
//	input A1;
//
//	// Function
//	buf (Y, A1);
//
//	// Timing
//	specify
//		(A1 => Y) = 0;
//	endspecify
//endmodule
//`endcelldefine

`celldefine
module TSBUF (I, OE, Y);
    input I, OE;
    output Y;
    bufif1 (Y, I, OE);

  specify
    (I => Y) = (0, 0);
    (OE => Y) = (0, 0);
  endspecify
endmodule
`endcelldefine



// type:  
`timescale 1ns/10ps
`celldefine
module AND2X1 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	and (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine


// type:  
`timescale 1ns/10ps
`celldefine
module OR2X1 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	or (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module XNOR2X1 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	not (B__bar, A2);
	not (A__bar, A1);
	and (int_fwire_0, A__bar, B__bar);
	and (int_fwire_1, A1, A2);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		if (A2)
			(A1 => Y) = 0;
		if (~A2)
			(A1 => Y) = 0;
		if (A1)
			(A2 => Y) = 0;
		if (~A1)
			(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine


// type:  
`timescale 1ns/10ps
`celldefine
module XOR2X1 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	not (A__bar, A1);
	and (int_fwire_0, A__bar, A2);
	not (B__bar, A2);
	and (int_fwire_1, A1, B__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		if (~A2)
			(A1 => Y) = 0;
		if (A2)
			(A1 => Y) = 0;
		if (~A1)
			(A2 => Y) = 0;
		if (A1)
			(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine




`ifdef _udp_def_altos_latch_
`else
`define _udp_def_altos_latch_
primitive altos_latch (q, v, CP, R);
	output q;
	reg q;
	input v, CP, R;

	table
		* ? ? : ? : x;
		? 1 0 : ? : 0;
		? 1 1 : ? : 1;
		? x 0 : 0 : -;
		? x 1 : 1 : -;
		? 0 ? : ? : -;
	endtable
endprimitive
`endif


`ifdef _udp_def_altos_dff_err_
`else
`define _udp_def_altos_dff_err_
primitive altos_dff_err (q, CP, R);
	output q;
	reg q;
	input CP, R;

	table
		(0x) ? : ? : 0;
		(1x) ? : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_
`else
`define _udp_def_altos_dff_
primitive altos_dff (q, v, clk, d, xcr);
	output q;
	reg q;
	input v, clk, d, xcr;

	table
		*  ?   ? ? : ? : x;
		? (x1) 0 0 : ? : 0;
		? (x1) 1 0 : ? : 1;
		? (x1) 0 1 : 0 : 0;
		? (x1) 1 1 : 1 : 1;
		? (x1) ? x : ? : -;
		? (bx) 0 ? : 0 : -;
		? (bx) 1 ? : 1 : -;
		? (x0) b ? : ? : -;
		? (x0) ? x : ? : -;
		? (01) 0 ? : ? : 0;
		? (01) 1 ? : ? : 1;
		? (10) ? ? : ? : -;
		?  b   * ? : ? : -;
		?  ?   ? * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_err_
`else
`define _udp_def_altos_dff_sr_err_
primitive altos_dff_sr_err (q, CP, R, s, r);
	output q;
	reg q;
	input CP, R, s, r;

	table
		 ?   1 (0x)  ?   : ? : -;
		 ?   0  ?   (0x) : ? : -;
		 ?   0  ?   (x0) : ? : -;
		(0x) ?  0    0   : ? : 0;
		(0x) 1  x    0   : ? : 0;
		(0x) 0  0    x   : ? : 0;
		(1x) ?  0    0   : ? : 1;
		(1x) 1  x    0   : ? : 1;
		(1x) 0  0    x   : ? : 1;
	endtable
endprimitive
`endif


`ifdef _udp_def_altos_dff_sr_1
`else
`define _udp_def_altos_dff_sr_1
primitive altos_dff_sr_1 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;

	table
	//	v,  clk, d, s, r : q' : q;

		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   0   1   ? : ? : 0;
		?  ?   ?   1   ?   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif


/////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

