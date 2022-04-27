`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2021 08:36:04 AM
// Design Name: 
// Module Name: sigmul_52
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module compress_2_cpp_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+50:50] x;
  input [NSIG+51:51] y;
  input [NSIG+52:52] z;
  output [NSIG+52:50] s;
  output [NSIG+52:52] c;
  
  assign s[50] = x[50];
  
  hadder H51(x[51], y[51], s[51], c[52]);
  
  genvar i;
  generate
    for (i = 52; i < NSIG+51; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  hadder H(y[NSIG+51], z[NSIG+51], s[NSIG+51], c[NSIG+52]);
  
  assign s[NSIG+52] = z[NSIG+52];
endmodule

module compress_3_csc3_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+48:48] x;
  input [NSIG+52:50] y;
  input [NSIG+52:52] z;
  output [NSIG+52:48] s;
  output [NSIG+53:51] c;
  
  assign s[49:48] = x[49:48];
  
  genvar i;
  generate
    for (i = 50; i < 52; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end

    for (i = 52; i < NSIG+49; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end

    for (i = NSIG+49; i < NSIG+53; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
endmodule

module compress_4_scs3_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+50:41] x;
  input [NSIG+46:44] y;
  input [NSIG+52:48] z;
  output [NSIG+52:41] s;
  output [NSIG+51:45] c;
  
  assign s[43:41] = x[43:41];
  
  genvar i;
  generate
    for (i = 44; i < 48; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end

    for (i = 48; i < NSIG+47; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end

    for (i = NSIG+47; i < NSIG+51; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+52:NSIG+51] = z[NSIG+52:NSIG+51];
endmodule

module compress_5_scs2_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+41:31] x;
  input [NSIG+41:35] y;
  input [NSIG+52:41] z;
  output [NSIG+52:31] s;
  output [NSIG+42:36] c;
  
  assign s[34:31] = x[34:31];
  
  genvar i;
  generate
    for (i = 35; i < 41; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
      
    for (i = 41; i < NSIG+42; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+52:NSIG+42] = z[NSIG+52:NSIG+42];
endmodule

module compress_5_csc2_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+29:22] x;
  input [NSIG+52:31] y;
  input [NSIG+42:36] z;
  output [NSIG+52:22] s;
  output [NSIG+43:32] c;
  
  assign s[30:22] = x[30:22];
  
  genvar i;
  generate
    for (i = 31; i < 36; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
      
    for (i = 36; i < NSIG+30; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
      
    for (i = NSIG+30; i < NSIG+43; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+52:NSIG+43] = y[NSIG+52:NSIG+43];
endmodule

module compress_6_scs1_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+35:0] x;
  input [NSIG+24:7] y;
  input [NSIG+52:22] z;
  output [NSIG+52:0] s;
  output [NSIG+36:8] c;
  
  assign s[6:0] = x[6:0];
  
  genvar i;
  generate
    for (i = 7; i < 22; i = i + 1)
     begin
       hadder Hi(x[i], y[i], s[i], c[i+1]);
     end
     
    for (i = 22; i < NSIG+25; i = i + 1)
     begin
       fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
     end

    for (i = NSIG+25; i < NSIG+36; i = i + 1)
     begin
       hadder Hj(x[i], z[i], s[i], c[i+1]);
     end
  endgenerate
  
  assign s[NSIG+52:NSIG+36] = z[NSIG+52:NSIG+36];
endmodule

module compress_6_ccc_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+43:32] x;
  input [NSIG+51:45] y;
  input [NSIG+53:51] z;
  output [NSIG+53:32] s;
  output [NSIG+52:46] c;
  
  assign s[44:32] = x[44:32];
  
  genvar i;
  generate
    for (i = 45; i < 51; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
      
    for (i = 51; i < NSIG+44; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
      
    for (i = NSIG+44; i < NSIG+52; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
      
  assign s[NSIG+53:NSIG+52] = z[NSIG+53:NSIG+52];
endmodule

module compress_7_scs1_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+52:0] x;
  input [NSIG+36:8] y;
  input [NSIG+53:32] z;
  output [NSIG+53:0] s;
  output [NSIG+53:9] c;
  
  assign s[7:0] = x[7:0];
  
  genvar i;
  generate
    for (i = 8; i < 32; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
      
    for (i = 32; i < NSIG+37; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
      
    for (i = NSIG+37; i < NSIG+53; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+53] = z[NSIG+53];
endmodule

module compress_8_scc_local(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+53:0] x;
  input [NSIG+53:9] y;
  input [NSIG+52:46] z;
  output [NSIG+53:0] s;
  output [NSIG+54:10] c;
  
  assign s[8:0] = x[8:0];
  
  genvar i;
  generate
    for (i = 9; i < 46; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
      
    for (i = 46; i < NSIG+53; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  hadder Hj(x[NSIG+53], y[NSIG+53], s[NSIG+53], c[NSIG+54]);
endmodule

module sigmul_52(a, b, p);
  parameter NSIG = 52;
  input [NSIG:0] a, b;
  output [2*NSIG+1:0] p;
  
  wire [NSIG:0] pp[NSIG:0]; // Partial products
  
  genvar i;
  generate
    for (i = 0; i < NSIG; i = i + 1)
    begin
      assign pp[i] = a & {NSIG+1{b[i]}};
    end
    assign pp[NSIG] = a;
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

  wire [NSIG+26:24] s0_9;
  wire [NSIG+26:26] c0_9;

  compress_1_ppp #(NSIG) sc18_1A(pp[24], pp[25], pp[26], s0_9, c0_9);

  wire [NSIG+29:27] s0_A;
  wire [NSIG+29:29] c0_A;

  compress_1_ppp #(NSIG) sc1B_1D(pp[27], pp[28], pp[29], s0_A, c0_A);

  wire [NSIG+32:30] s0_B;
  wire [NSIG+32:32] c0_B;

  compress_1_ppp #(NSIG) sc1E_21(pp[30], pp[31], pp[32], s0_B, c0_B);

  wire [NSIG+35:33] s0_C;
  wire [NSIG+35:35] c0_C;

  compress_1_ppp #(NSIG) sc22_24(pp[33], pp[34], pp[35], s0_C, c0_C);

  wire [NSIG+38:36] s0_D;
  wire [NSIG+38:38] c0_D;

  compress_1_ppp #(NSIG) sc25_27(pp[36], pp[37], pp[38], s0_D, c0_D);

  wire [NSIG+41:39] s0_E;
  wire [NSIG+41:41] c0_E;

  compress_1_ppp #(NSIG) sc28_2A(pp[39], pp[40], pp[41], s0_E, c0_E);

  wire [NSIG+44:42] s0_F;
  wire [NSIG+44:44] c0_F;

  compress_1_ppp #(NSIG) sc2B_2D(pp[42], pp[43], pp[44], s0_F, c0_F);

  wire [NSIG+47:45] s0_G;
  wire [NSIG+47:47] c0_G;

  compress_1_ppp #(NSIG) sc2E_30(pp[45], pp[46], pp[47], s0_G, c0_G);

  wire [NSIG+50:48] s0_H;
  wire [NSIG+50:50] c0_H;

  compress_1_ppp #(NSIG) sc31_33(pp[48], pp[49], pp[50], s0_H, c0_H);

  // Stage 2
  wire [NSIG+5:0] s1_1;
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

  wire [NSIG+26:23] s1_6;
  wire [NSIG+27:25] c1_6;

  compress_2_csc #(NSIG) TS1_6(c0_8, s0_9, c0_9, s1_6, c1_6);

  wire [NSIG+32:27] s1_7;
  wire [NSIG+30:30] c1_7;

  compress_2_scs #(NSIG) TS1_7(s0_A, c0_A, s0_B, s1_7, c1_7);

  wire [NSIG+35:32] s1_8;
  wire [NSIG+36:34] c1_8;

  compress_2_csc #(NSIG) TS1_8(c0_B, s0_C, c0_C, s1_8, c1_8);

  wire [NSIG+41:36] s1_9;
  wire [NSIG+39:39] c1_9;

  compress_2_scs #(NSIG) TS1_9(s0_D, c0_D, s0_E, s1_9, c1_9);

  wire [NSIG+44:41] s1_A;
  wire [NSIG+45:43] c1_A;

  compress_2_csc #(NSIG) TS1_A(c0_E, s0_F, c0_F, s1_A, c1_A);

  wire [NSIG+50:45] s1_B;
  wire [NSIG+48:48] c1_B;

  compress_2_scs #(NSIG) TS1_B(s0_G, c0_G, s0_H, s1_B, c1_B);

  wire [NSIG+52:50] s1_C;
  wire [NSIG+52:52] c1_C;

  compress_2_cpp_local TS1_C(c0_H, pp[51], pp[52], s1_C, c1_C);
  
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

  wire [NSIG+27:21] s2_4;
  wire [NSIG+27:24] c2_4;

  compress_3_csc2 #(NSIG) TS2_4(c1_5, s1_6, c1_6, s2_4, c2_4);

  wire [NSIG+35:27] s2_5;
  wire [NSIG+33:31] c2_5;
  
  compress_3_scs1 #(NSIG) TS2_5(s1_7, c1_7, s1_8, s2_5, c2_5);

  wire [NSIG+41:34] s2_6;
  wire [NSIG+40:37] c2_6;

  compress_3_csc1 #(NSIG) TS2_6(c1_8, s1_9, c1_9, s2_6, c2_6);

  wire [NSIG+50:41] s2_7;
  wire [NSIG+46:44] c2_7;

  compress_3_scs2 #(NSIG) TS2_7(s1_A, c1_A, s1_B, s2_7, c2_7);

  wire [NSIG+52:48] s2_8;
  wire [NSIG+53:51] c2_8;

  compress_3_csc3_local #(NSIG) TS2_8(c1_B, s1_C, c1_C, s2_8, c2_8);

  //Stage 4
  wire [NSIG+14:0] s3_1;
  wire [NSIG+9:5] c3_1;

  compress_4_scs1 #(NSIG) TS3_1(s2_1, c2_1, s2_2, s3_1, c3_1);

  wire [NSIG+23:10] s3_2;
  wire [NSIG+20:15] c3_2;

  compress_4_csc1 #(NSIG) TS3_2(c2_2, s2_3, c2_3, s3_2, c3_2);

  wire [NSIG+35:21] s3_3;
  wire [NSIG+28:25] c3_3;

  compress_4_scs2 #(NSIG) TS3_3(s2_4, c2_4, s2_5, s3_3, c3_3);

  wire [NSIG+41:31] s3_4;
  wire [NSIG+41:35] c3_4;

  compress_4_csc2 #(NSIG) TS3_4(c2_5, s2_6, c2_6, s3_4, c3_4);

  wire [NSIG+52:41] s3_5;
  wire [NSIG+51:45] c3_5;

  compress_4_scs3_local #(NSIG) TS3_5(s2_7, c2_7, s2_8, s3_5, c3_5);

  // Stage 5
  wire [NSIG+23:0] s4_1;
  wire [NSIG+15:6] c4_1;

  compress_5_scs1 #(NSIG) TS4_1(s3_1, c3_1, s3_2, s4_1, c4_1);

  wire [NSIG+35:15] s4_2;
  wire [NSIG+29:22] c4_2;

  compress_5_csc1 #(NSIG) TS4_2(c3_2, s3_3, c3_3, s4_2, c4_2);

  wire [NSIG+52:31] s4_3;
  wire [NSIG+42:36] c4_3;

  compress_5_scs2_local #(NSIG) TS4_3(s3_4, c3_4, s3_5, s4_3, c4_3);

  // Stage 6
  wire [NSIG+35:0] s5_1;
  wire [NSIG+24:7] c5_1;

  compress_6_scs1 #(NSIG) TS5_1(s4_1, c4_1, s4_2, s5_1, c5_1);
  
  wire [NSIG+52:22] s5_2;
  wire [NSIG+43:32] c5_2;

  compress_5_csc2_local #(NSIG) TS5_2(c4_2, s4_3, c4_3, s5_2, c5_2);

  // Stage 7
  wire [NSIG+52:0] s6_1;
  wire [NSIG+36:8] c6_1;

  compress_6_scs1_local #(NSIG) TS6_1(s5_1, c5_1, s5_2, s6_1, c6_1);
  
  wire [NSIG+53:32] s6_2;
  wire [NSIG+52:46] c6_2;

  compress_6_ccc_local #(NSIG) TS6_2(c5_2, c3_5, c2_8, s6_2, c6_2);

  // Stage 8
  wire [NSIG+53:0] s7_1;
  wire [NSIG+53:9] c7_1;

  compress_7_scs1_local #(NSIG) TS7_1(s6_1, c6_1, s6_2, s7_1, c7_1);
  
  // Stage 9
  wire [NSIG+53:0] s8_1;
  wire [NSIG+54:10] c8_1;

  compress_8_scc_local #(NSIG) TS8_2(s7_1, c7_1, c6_2, s8_1, c8_1);

  assign p[9:0] = s8_1[9:0];

  wire Cout;
  padder96 P96(s8_1[NSIG+53:10], c8_1[NSIG+53:10], 1'b0, p[105:10], Cout);
endmodule
