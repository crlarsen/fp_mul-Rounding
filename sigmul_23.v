`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright: Chris Larsen, 2021 
// Engineer: Chris Larsen
// 
// Create Date: 03/25/2021 09:04:31 PM
// Design Name: 
// Module Name: sigmul_23
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 24-bit Significand Multiply Circuit
//              This code assumes that the most significant bits of both input
//              values will be 1 (one) because of the way the parent module
//              extracts significands for normal and subnormal numbers. The
//              the output of this module will only ever be used if the two 
//              IEEE 754 binary32 floating point numbers being multiplied are
//              both normal, or subnormal numbers. Logic in the parent module
//              doesn't need the output of this module if either of the input
//              values are NaNs, Infinities, or Zeroes.
//
//              The module uses 3:2 compression to avoid carry bit propagation
//              delay, when possible. Then the module uses a prefix adder to
//              perform addition, when addition can't be avoided.
//
//              3:2 compression modules which are unique to this significand size
//              can be found in this source code file. The 3:2 compression
//              modules which can be used for other IEEE 754 binary floating
//              point formats can be found in the file compress3_2.v.
// 
// Dependencies: Modules compress_1_ppp, compress_2_scs, compress_2_csc, compress_3_scs1,
//               compress_3_csc1, compress_3_scs2, compress_4_scs1,
//               compress_4_csc1, compress_5_scs1, hadder, fadder, and padder40.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module compress_5_ccc1_local(x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+20:15] x;
  input [NSIG+21:21] y;
  input [NSIG+23:23] z;
  output [NSIG+23:15] s;
  output [NSIG+22:22] c;
  
  assign s[20:15] = x[20:15];
  
  genvar i;
  generate
    for (i = 21; i < 23; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 23; i < NSIG+21; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  hadder Hj(y[NSIG+21], z[NSIG+21], s[NSIG+21], c[NSIG+22]);

  assign s[NSIG+23:NSIG+22] =  z[NSIG+23:NSIG+22];
endmodule

module compress_6_scc1_local(x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+23:0] x;
  input [NSIG+24:7] y;
  inout [NSIG+22:22] z;
  output [NSIG+24:0] s;
  output [NSIG+24:8] c;
  
  assign s[6:0] = x[6:0];
  
  genvar i;
  generate
    for (i = 7; i < 22; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 22; i < NSIG+23; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  hadder Hj(x[NSIG+23], y[NSIG+23], s[NSIG+23], c[NSIG+24]);
  
  assign s[NSIG+24] = y[NSIG+24];
endmodule

module sigmul_23(aSig, bSig, pSig);
  parameter NSIG = 23;
  input [NSIG:0] aSig, bSig;
  output [2*NSIG+1:0] pSig;
  
  wire [NSIG:0] pp[NSIG:0];genvar i;
  generate
    // Calculate the partial products for each bit in b:
    for (i = 0; i < NSIG; i = i + 1)
    begin
      assign pp[i] = aSig & {NSIG+1{bSig[i]}};
    end
    assign pp[NSIG] = aSig; // Save ourselves a few gates. We know that
                            // b[23] is always 1 so we know the product is
                            // always going to be `a' so there is no reason
                            // to perform the AND operation to get the
                            // partial product.
  endgenerate

  // Stage 1  
  wire [NSIG+2:0] s0_1;
  wire [NSIG+2:2] c0_1;

  compress_1_ppp #(NSIG) sc012(pp[0], pp[1], pp[2], s0_1, c0_1);

  wire [NSIG+5:3] s0_2;
  wire [NSIG+5:5] c0_2;

  compress_1_ppp #(NSIG) sc345(pp[3], pp[4], pp[5], s0_2, c0_2);

  wire [NSIG+8:6] s0_3;
  wire [NSIG+8:8] c0_3;

  compress_1_ppp #(NSIG) sc678(pp[6], pp[7], pp[8], s0_3, c0_3);
  
  wire [NSIG+11:9] s0_4;
  wire [NSIG+11:11] c0_4;

  compress_1_ppp #(NSIG) sc9AB(pp[9], pp[10], pp[11], s0_4, c0_4);

  wire [NSIG+14:12] s0_5;
  wire [NSIG+14:14] c0_5;

  compress_1_ppp #(NSIG) scCDE(pp[12], pp[13], pp[14], s0_5, c0_5);

  wire [NSIG+17:15] s0_6;
  wire [NSIG+17:17] c0_6;

  compress_1_ppp #(NSIG) scF_11(pp[15], pp[16], pp[17], s0_6, c0_6);  
  
  wire [NSIG+20:18] s0_7;
  wire [NSIG+20:20] c0_7;

  compress_1_ppp #(NSIG) sc12_14(pp[18], pp[19], pp[20], s0_7, c0_7);

  wire [NSIG+23:21] s0_8;
  wire [NSIG+23:23] c0_8;

  compress_1_ppp #(NSIG) sc15_17(pp[21], pp[22], pp[23], s0_8, c0_8);

  // Stage 2
  wire [NSIG+5:0]s1_1;
  wire [NSIG+3:3] c1_1;

  compress_2_scs #(NSIG) TS1_1(s0_1, c0_1, s0_2, s1_1, c1_1);

  wire [NSIG+8:5] s1_2;
  wire [NSIG+9:7] c1_2;

  compress_2_csc #(NSIG) TS1_2(c0_2, s0_3, c0_3, s1_2, c1_2);

  wire [NSIG+14:9] s1_3;
  wire [NSIG+12:12] c1_3;

  compress_2_scs #(NSIG) TS1_3(s0_4, c0_4, s0_5, s1_3, c1_3);

  wire [NSIG+17:14] s1_4;
  wire [NSIG+18:16] c1_4;

  compress_2_csc #(NSIG) TS1_4(c0_5, s0_6, c0_6, s1_4, c1_4);
  
  wire [NSIG+23:18] s1_5;
  wire [NSIG+21:21] c1_5;

  compress_2_scs #(NSIG) TS1_5(s0_7, c0_7, s0_8, s1_5, c1_5);
  
  // Stage 3
  wire [NSIG+8:0] s2_1;
  wire [NSIG+6:4] c2_1;
  
  compress_3_scs1 #(NSIG) TS2_1(s1_1, c1_1, s1_2, s2_1, c2_1);
  
  wire [NSIG+14:7] s2_2;
  wire [NSIG+13:10] c2_2;
  
  compress_3_csc1 #(NSIG) TS2_2(c1_2, s1_3, c1_3, s2_2, c2_2);
  
  wire [NSIG+23:14] s2_3;
  wire [NSIG+19:17] c2_3;
  
  compress_3_scs2 #(NSIG) TS2_3(s1_4, c1_4, s1_5, s2_3, c2_3);
  
  //Stage 4
  wire [NSIG+14:0] s3_1;
  wire [NSIG+9:5] c3_1;
  
  compress_4_scs1 #(NSIG) TS3_1(s2_1, c2_1, s2_2, s3_1, c3_1);
  
  wire [NSIG+23:10] s3_2;
  wire [NSIG+20:15] c3_2;
  
  compress_4_csc1 #(NSIG) TS3_2(c2_2, s2_3, c2_3, s3_2, c3_2);
  
  // Stage 5
  wire [NSIG+23:0] s4_1;
  wire [NSIG+15:6] c4_1;
  
  compress_5_scs1 #(NSIG) TS4_1(s3_1, c3_1, s3_2, s4_1, c4_1);
  
  wire [NSIG+23:15] s4_2;
  wire [NSIG+22:22] c4_2;
  
  compress_5_ccc1_local #(NSIG) TS4_2(c3_2, c1_5, c0_8, s4_2, c4_2);
  
  // Stage 6
  wire [NSIG+23:0] s5_1;
  wire [NSIG+24:7] c5_1;
  
  compress_6_scs1 #(NSIG) TS5_1(s4_1, c4_1, s4_2, s5_1, c5_1);
  
  // Stage 7
  wire [2*NSIG+1:0] s6_1;
  wire [2*NSIG+1:8] c6_1;
  
  compress_6_scc1_local #(NSIG) TS6_1(s5_1, c5_1, c4_2, s6_1, c6_1);
  
  wire cout;
  
  assign pSig[7:0] = s6_1[7:0];
  padder40 PA(s6_1[2*NSIG+1:8], c6_1, 1'b0, pSig[2*NSIG+1:8], cout);
endmodule
