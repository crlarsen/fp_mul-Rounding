`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 06/05/2019 07:36:52 PM
// Design Name:
// Module Name: padder16
// Project Name:
// Target Devices:
// Tool Versions:
// Description: Integer Prefix Adder with Carry In/Carry Out
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module padder16(A, B, Cin, S, Cout);
  parameter N = 16;
  input [N-1:0] A, B;
  input Cin;
  output [N-1:0] S;
  output Cout;

  // P[i] is an alias for Pi:i, likewise G[i] is an alias for Gi:i
  wire [N-2:-1] P, G;

  assign P = {A[N-2:0] | B[N-2:0], 1'b0};
  assign G = {A[N-2:0] & B[N-2:0], Cin};

  Sum s0(G[-1], A[0], B[0], S[0]);

  wire \G0:-1 ;

  Gij \0:-1 (P[0], G[0], G[-1], \G0:-1 );

  Sum s1(\G0:-1 , A[1], B[1], S[1]);

  wire \G1:-1 ;

  Gij \1:-1 (P[1], G[1], \G0:-1 , \G1:-1 );

  Sum s2(\G1:-1 , A[2], B[2], S[2]);

  wire \P2:1 , \G2:1 ;

  PijGij \2:1 (P[2], P[1], G[2], G[1], \P2:1 , \G2:1 );

  wire \G2:-1 ;

  Gij \2:-1 (\P2:1 , \G2:1 , \G0:-1 , \G2:-1 );

  Sum s3(\G2:-1 , A[3], B[3], S[3]);

  wire \G3:-1 ;

  Gij \3:-1 (P[3], G[3], \G2:-1 , \G3:-1 );

  Sum s4(\G3:-1 , A[4], B[4], S[4]);

  wire \P4:3 , \G4:3 ;

  PijGij \4:3 (P[4], P[3], G[4], G[3], \P4:3 , \G4:3 );

  wire \G4:-1 ;

  Gij \4:-1 (\P4:3 , \G4:3 , \G2:-1 , \G4:-1 );

  Sum s5(\G4:-1 , A[5], B[5], S[5]);

  wire \P5:3 , \G5:3 ;

  PijGij \5:3 (P[5], \P4:3 , G[5], \G4:3 , \P5:3 , \G5:3 );

  wire \G5:-1 ;

  Gij \5:-1 (\P5:3 , \G5:3 , \G2:-1 , \G5:-1 );

  Sum s6(\G5:-1 , A[6], B[6], S[6]);

  wire \P6:5 , \G6:5 ;

  PijGij \6:5 (P[6], P[5], G[6], G[5], \P6:5 , \G6:5 );

  wire \P6:3 , \G6:3 ;

  PijGij \6:3 (\P6:5 , \P4:3 , \G6:5 , \G4:3 , \P6:3 , \G6:3 );

  wire \G6:-1 ;

  Gij \6:-1 (\P6:3 , \G6:3 , \G2:-1 , \G6:-1 );

  Sum s7(\G6:-1 , A[7], B[7], S[7]);

  wire \G7:-1 ;

  Gij \7:-1 (P[7], G[7], \G6:-1 , \G7:-1 );

  Sum s8(\G7:-1 , A[8], B[8], S[8]);

  wire \P8:7 , \G8:7 ;

  PijGij \8:7 (P[8], P[7], G[8], G[7], \P8:7 , \G8:7 );

  wire \G8:-1 ;

  Gij \8:-1 (\P8:7 , \G8:7 , \G6:-1 , \G8:-1 );

  Sum s9(\G8:-1 , A[9], B[9], S[9]);

  wire \P9:7 , \G9:7 ;

  PijGij \9:7 (P[9], \P8:7 , G[9], \G8:7 , \P9:7 , \G9:7 );

  wire \G9:-1 ;

  Gij \9:-1 (\P9:7 , \G9:7 , \G6:-1 , \G9:-1 );

  Sum s10(\G9:-1 , A[10], B[10], S[10]);

  wire \P10:9 , \G10:9 ;

  PijGij \10:9 (P[10], P[9], G[10], G[9], \P10:9 , \G10:9 );

  wire \P10:7 , \G10:7 ;

  PijGij \10:7 (\P10:9 , \P8:7 , \G10:9 , \G8:7 , \P10:7 , \G10:7 );

  wire \G10:-1 ;

  Gij \10:-1 (\P10:7 , \G10:7 , \G6:-1 , \G10:-1 );

  Sum s11(\G10:-1 , A[11], B[11], S[11]);

  wire \P11:7 , \G11:7 ;

  PijGij \11:7 (P[11], \P10:7 , G[11], \G10:7 , \P11:7 , \G11:7 );

  wire \G11:-1 ;

  Gij \11:-1 (\P11:7 , \G11:7 , \G6:-1 , \G11:-1 );

  Sum s12(\G11:-1 , A[12], B[12], S[12]);

  wire \P12:11 , \G12:11 ;

  PijGij \12:11 (P[12], P[11], G[12], G[11], \P12:11 , \G12:11 );

  wire \P12:7 , \G12:7 ;

  PijGij \12:7 (\P12:11 , \P10:7 , \G12:11 , \G10:7 , \P12:7 , \G12:7 );

  wire \G12:-1 ;

  Gij \12:-1 (\P12:7 , \G12:7 , \G6:-1 , \G12:-1 );

  Sum s13(\G12:-1 , A[13], B[13], S[13]);

  wire \P13:11 , \G13:11 ;

  PijGij \13:11 (P[13], \P12:11 , G[13], \G12:11 , \P13:11 , \G13:11 );

  wire \P13:7 , \G13:7 ;

  PijGij \13:7 (\P13:11 , \P10:7 , \G13:11 , \G10:7 , \P13:7 , \G13:7 );

  wire \G13:-1 ;

  Gij \13:-1 (\P13:7 , \G13:7 , \G6:-1 , \G13:-1 );

  Sum s14(\G13:-1 , A[14], B[14], S[14]);

  wire \P14:13 , \G14:13 ;

  PijGij \14:13 (P[14], P[13], G[14], G[13], \P14:13 , \G14:13 );

  wire \P14:11 , \G14:11 ;

  PijGij \14:11 (\P14:13 , \P12:11 , \G14:13 , \G12:11 , \P14:11 , \G14:11 );

  wire \P14:7 , \G14:7 ;

  PijGij \14:7 (\P14:11 , \P10:7 , \G14:11 , \G10:7 , \P14:7 , \G14:7 );

  wire \G14:-1 ;

  Gij \14:-1 (\P14:7 , \G14:7 , \G6:-1 , \G14:-1 );

  Sum s15(\G14:-1 , A[15], B[15], S[15]);

  assign Cout = (\G14:-1 & A[15]) | (\G14:-1 & B[15]) | (A[15] & B[15]);

endmodule
