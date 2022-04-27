`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/23/2022 08:36:04 PM
// Design Name:
// Module Name: sigmul_112
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

module compress_2_scp_local(x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+110:108] x;
  input [NSIG+110:110] y;
  input [NSIG+111:111] z;
  output [NSIG+111:108] s;
  output [NSIG+111:111] c;

  assign s[109:108] = x[109:108];
  
  hadder H110(x[110], y[110], s[110], c[111]);
  
  genvar i;
  generate
    for (i = 111; i < NSIG+111; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+111] = z[NSIG+111];
endmodule

module compress_3_scp_local(x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+111:108] x;
  input [NSIG+111:111] y;
  input [NSIG+112:112] z;
  output [NSIG+112:108] s;
  output [NSIG+112:112] c;
  
  assign s[110:108] = x[110:108];
  
  hadder H111(x[111], y[111], s[111], c[112]);
  
  genvar i;
  generate
    for (i = 112; i < NSIG+112; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+112] = z[NSIG+112];
endmodule

module compress_5_scs4_local (x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+104:91] x;
  input [NSIG+101:96] y;
  input [NSIG+112:102] z;
  output [NSIG+112:91] s;
  output [NSIG+105:97] c;
  
  assign s[95:91] = x[95:91];
  
  genvar i;
  generate
    for (i = 96; i < 102; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 102; i < NSIG+102; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = NSIG+102; i < NSIG+105; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+112:NSIG+105] = z[NSIG+112:NSIG+105];

endmodule

module compress_4_scs1_local_112 (x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+108:102] x;
  input [NSIG+108:105] y;
  input [NSIG+112:108] z;
  output [NSIG+112:102] s;
  output [NSIG+109:106] c;
  
  assign s[104:102] = x[104:102];
  
  genvar i;
  generate
    for (i = 105; i < 108; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 108; i < NSIG+109; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+112:NSIG+109] = z[NSIG+112:NSIG+109];

endmodule

module compress_6_scc_local (x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+112:91] x;
  input [NSIG+105:97] y;
  input [NSIG+109:106] z;
  output [NSIG+112:91] s;
  output [NSIG+110:98] c;
  
  assign s[96:91] = x[96:91];
  
  genvar i;
  generate
    for (i = 97; i < 106; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 106; i < NSIG+106; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+106; i < NSIG+110; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+112:NSIG+110] = x[NSIG+112:NSIG+110];

endmodule

module compress_7_scs2_local(x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+95:66] x;
  input [NSIG+92:77] y;
  input [NSIG+112:91] z;
  output [NSIG+112:66] s;
  output [NSIG+96:78] c;
  
  assign s[76:66] = x[76:66];
  
  genvar i;
  generate
    for (i = 77; i < 91; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 91; i < NSIG+93; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = NSIG+93; i < NSIG+96; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+112:NSIG+96] = z[NSIG+112:NSIG+96];

endmodule

module compress_8_csc1_local(x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+64:46] x;
  input [NSIG+112:66] y;
  input [NSIG+96:78] z;
  output [NSIG+112:46] s;
  output [NSIG+97:67] c;
  
  assign s[65:46] = x[65:46];
  
  genvar i;
  generate
    for (i = 66; i < 78; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 78; i < NSIG+65; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+65; i < NSIG+97; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+112:NSIG+97] = y[NSIG+112:NSIG+97];

endmodule

module compress_9_scs1_local(x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+81:0] x;
  input [NSIG+55:9] y;
  input [NSIG+112:46] z;
  output [NSIG+112:0] s;
  output [NSIG+82:10] c;
  
  assign s[8:0] = x[8:0];
  
  genvar i;
  generate
    for (i = 9; i< 46; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 46; i< NSIG+56; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+56; i< NSIG+82; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+112:NSIG+82] = z[NSIG+112:NSIG+82];

endmodule

module compress_9_ccc1_local(x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+97:67] x;
  input [NSIG+110:98] y;
  input [NSIG+112:112] z;
  output [NSIG+112:67] s;
  output [NSIG+111:99] c;
  
  assign s[97:67] = x[97:67];
  
  genvar i;
  generate
    for (i = 98; i < 112; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 112; i < NSIG+98; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+98; i < NSIG+111; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+112:NSIG+111] = z[NSIG+112:NSIG+111];

endmodule

module compress_10_scs1_local (x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+112:0] x;
  input [NSIG+82:10] y;
  input [NSIG+112:67] z;
  output [NSIG+112:0] s;
  output [NSIG+113:11] c;
  
  assign s[9:0] = x[9:0];
  
  genvar i;
  generate
    for (i = 10; i < 67; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 67; i < NSIG+83; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = NSIG+83; i < NSIG+113; i = i + 1)
      begin
        hadder Fj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate

endmodule

module compress_11_scc1_local(x, y, z, s, c);
  localparam NSIG = 112;
  input [NSIG+112:0] x;
  input [NSIG+113:11] y;
  input [NSIG+111:99] z;
  output [NSIG+113:0] s;
  output [NSIG+113:12] c;
  
  assign s[10:0] = x[10:0];
  
  genvar i;
  generate
    for (i = 11; i < 99; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 99; i < NSIG+112; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  hadder Hj(x[NSIG+112], y[NSIG+112], s[NSIG+112], c[NSIG+113]);

  assign s[NSIG+113] = y[NSIG+113];

endmodule

module sigmul_112(a, b, p);
  localparam NSIG = 112;
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
  
  wire [NSIG+53:51] s0_I;
  wire [NSIG+53:53] c0_I;

  compress_1_ppp #(NSIG) sc34_36(pp[51], pp[52], pp[53], s0_I, c0_I);
  
  wire [NSIG+56:54] s0_J;
  wire [NSIG+56:56] c0_J;

  compress_1_ppp #(NSIG) sc37_39(pp[54], pp[55], pp[56], s0_J, c0_J);
  
  wire [NSIG+59:57] s0_K;
  wire [NSIG+59:59] c0_K;

  compress_1_ppp #(NSIG) sc3A_3C(pp[57], pp[58], pp[59], s0_K, c0_K);
  
  wire [NSIG+62:60] s0_L;
  wire [NSIG+62:62] c0_L;

  compress_1_ppp #(NSIG) sc3D_3F(pp[60], pp[61], pp[62], s0_L, c0_L);
  
  wire [NSIG+65:63] s0_M;
  wire [NSIG+65:65] c0_M;

  compress_1_ppp #(NSIG) sc40_42(pp[63], pp[64], pp[65], s0_M, c0_M);
  
  wire [NSIG+68:66] s0_N;
  wire [NSIG+68:68] c0_N;

  compress_1_ppp #(NSIG) sc43_45(pp[66], pp[67], pp[68], s0_N, c0_N);
  
  wire [NSIG+71:69] s0_O;
  wire [NSIG+71:71] c0_O;

  compress_1_ppp #(NSIG) sc46_48(pp[69], pp[70], pp[71], s0_O, c0_O);
  
  wire [NSIG+74:72] s0_P;
  wire [NSIG+74:74] c0_P;

  compress_1_ppp #(NSIG) sc49_4B(pp[72], pp[73], pp[74], s0_P, c0_P);
  
  wire [NSIG+77:75] s0_Q;
  wire [NSIG+77:77] c0_Q;

  compress_1_ppp #(NSIG) sc4C_4E(pp[75], pp[76], pp[77], s0_Q, c0_Q);
  
  wire [NSIG+80:78] s0_R;
  wire [NSIG+80:80] c0_R;

  compress_1_ppp #(NSIG) sc4F_51(pp[78], pp[79], pp[80], s0_R, c0_R);
  
  wire [NSIG+83:81] s0_S;
  wire [NSIG+83:83] c0_S;

  compress_1_ppp #(NSIG) sc52_54(pp[81], pp[82], pp[83], s0_S, c0_S);
  
  wire [NSIG+86:84] s0_T;
  wire [NSIG+86:86] c0_T;

  compress_1_ppp #(NSIG) sc55_57(pp[84], pp[85], pp[86], s0_T, c0_T);
  
  wire [NSIG+89:87] s0_U;
  wire [NSIG+89:89] c0_U;

  compress_1_ppp #(NSIG) sc58_5A(pp[87], pp[88], pp[89], s0_U, c0_U);
  
  wire [NSIG+92:90] s0_V;
  wire [NSIG+92:92] c0_V;

  compress_1_ppp #(NSIG) sc5B_5D(pp[90], pp[91], pp[92], s0_V, c0_V);
  
  wire [NSIG+95:93] s0_W;
  wire [NSIG+95:95] c0_W;

  compress_1_ppp #(NSIG) sc5E_60(pp[93], pp[94], pp[95], s0_W, c0_W);
  
  wire [NSIG+98:96] s0_X;
  wire [NSIG+98:98] c0_X;

  compress_1_ppp #(NSIG) sc61_63(pp[96], pp[97], pp[98], s0_X, c0_X);
  
  wire [NSIG+101:99] s0_Y;
  wire [NSIG+101:101] c0_Y;

  compress_1_ppp #(NSIG) sc64_66(pp[99], pp[100], pp[101], s0_Y, c0_Y);
  
  wire [NSIG+104:102] s0_Z;
  wire [NSIG+104:104] c0_Z;

  compress_1_ppp #(NSIG) sc67_69(pp[102], pp[103], pp[104], s0_Z, c0_Z);
  
  wire [NSIG+107:105] s0_a;
  wire [NSIG+107:107] c0_a;

  compress_1_ppp #(NSIG) sc6A_6C(pp[105], pp[106], pp[107], s0_a, c0_a);
  
  wire [NSIG+110:108] s0_b;
  wire [NSIG+110:110] c0_b;

  compress_1_ppp #(NSIG) sc6D_6F(pp[108], pp[109], pp[110], s0_b, c0_b);
  
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

  wire [NSIG+53:50] s1_C;
  wire [NSIG+54:52] c1_C;

  compress_2_csc #(NSIG) TS1_C(c0_H, s0_I, c0_I, s1_C, c1_C);
  
  wire [NSIG+59:54] s1_D;
  wire [NSIG+57:57] c1_D;

  compress_2_scs #(NSIG) TS1_D(s0_J, c0_J, s0_K, s1_D, c1_D);

  wire [NSIG+62:59] s1_E;
  wire [NSIG+63:61] c1_E;

  compress_2_csc #(NSIG) TS1_E(c0_K, s0_L, c0_L, s1_E, c1_E);

  wire [NSIG+68:63] s1_F;
  wire [NSIG+66:66] c1_F;

  compress_2_scs #(NSIG) TS1_F(s0_M, c0_M, s0_N, s1_F, c1_F);

  wire [NSIG+71:68] s1_G;
  wire [NSIG+72:70] c1_G;

  compress_2_csc #(NSIG) TS1_G(c0_N, s0_O, c0_O, s1_G, c1_G);
  
  wire [NSIG+77:72] s1_H;
  wire [NSIG+75:75] c1_H;

  compress_2_scs #(NSIG) TS1_H(s0_P, c0_P, s0_Q, s1_H, c1_H);

  wire [NSIG+80:77] s1_I;
  wire [NSIG+81:79] c1_I;

  compress_2_csc #(NSIG) TS1_I(c0_Q, s0_R, c0_R, s1_I, c1_I);
  
  wire [NSIG+86:81] s1_J;
  wire [NSIG+84:84] c1_J;

  compress_2_scs #(NSIG) TS1_J(s0_S, c0_S, s0_T, s1_J, c1_J);

  wire [NSIG+89:86] s1_K;
  wire [NSIG+90:88] c1_K;

  compress_2_csc #(NSIG) TS1_K(c0_T, s0_U, c0_U, s1_K, c1_K);
  
  wire [NSIG+95:90] s1_L;
  wire [NSIG+93:93] c1_L;

  compress_2_scs #(NSIG) TS1_L(s0_V, c0_V, s0_W, s1_L, c1_L);

  wire [NSIG+98:95] s1_M;
  wire [NSIG+99:97] c1_M;

  compress_2_csc #(NSIG) TS1_M(c0_W, s0_X, c0_X, s1_M, c1_M);
  
  wire [NSIG+104:99] s1_N;
  wire [NSIG+102:102] c1_N;

  compress_2_scs #(NSIG) TS1_N(s0_Y, c0_Y, s0_Z, s1_N, c1_N);

  wire [NSIG+107:104] s1_O;
  wire [NSIG+108:106] c1_O;

  compress_2_csc #(NSIG) TS1_O(c0_Z, s0_a, c0_a, s1_O, c1_O);
  
  wire [NSIG+111:108] s1_P;
  wire [NSIG+111:111] c1_P;

  compress_2_scp_local TS1_p(s0_b, c0_b, pp[111], s1_P, c1_P);

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

  wire [NSIG+54:48] s2_8;
  wire [NSIG+54:51] c2_8;

  compress_3_csc2 #(NSIG) TS2_8(c1_B, s1_C, c1_C, s2_8, c2_8);

  wire [NSIG+62:54] s2_9;
  wire [NSIG+60:58] c2_9;

  compress_3_scs1 #(NSIG) TS2_9(s1_D, c1_D, s1_E, s2_9, c2_9);

  wire [NSIG+68:61] s2_A;
  wire [NSIG+67:64] c2_A;

  compress_3_csc1 #(NSIG) TS2_A(c1_E, s1_F, c1_F, s2_A, c2_A);

  wire [NSIG+77:68] s2_B;
  wire [NSIG+73:71] c2_B;

  compress_3_scs2 #(NSIG) TS2_B(s1_G, c1_G, s1_H, s2_B, c2_B);

  wire [NSIG+81:75] s2_C;
  wire [NSIG+81:78] c2_C;

  compress_3_csc2 #(NSIG) TS2_C(c1_H, s1_I, c1_I, s2_C, c2_C);

  wire [NSIG+89:81] s2_D;
  wire [NSIG+87:85] c2_D;

  compress_3_scs1 #(NSIG) TS2_D(s1_J, c1_J, s1_K, s2_D, c2_D);

  wire [NSIG+95:88] s2_E;
  wire [NSIG+94:91] c2_E;

  compress_3_csc1 #(NSIG) TS2_E(c1_K, s1_L, c1_L, s2_E, c2_E);

  wire [NSIG+104:95] s2_F;
  wire [NSIG+100:98] c2_F;

  compress_3_scs2 #(NSIG) TS2_F(s1_M, c1_M, s1_N, s2_F, c2_F);

  wire [NSIG+108:102] s2_G;
  wire [NSIG+108:105] c2_G;

  compress_3_csc2 #(NSIG) TS2_G(c1_N, s1_O, c1_O, s2_G, c2_G);

  wire [NSIG+112:108] s2_H;
  wire [NSIG+112:112] c2_H;

  compress_3_scp_local TS2_H(s1_P, c1_P, pp[112], s2_H, c2_H);

  // Stage 4
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

  wire [NSIG+54:41] s3_5;
  wire [NSIG+51:45] c3_5;
  
  compress_4_scs3 #(NSIG) TS3_5(s2_7, c2_7, s2_8, s3_5, c3_5);

  wire [NSIG+62:51] s3_6;
  wire [NSIG+61:55] c3_6;
  
  compress_4_csc3 #(NSIG) TS3_6(c2_8, s2_9, c2_9, s3_6, c3_6);

  wire [NSIG+77:61] s3_7;
  wire [NSIG+69:65] c3_7;
  
  compress_4_scs4 #(NSIG) TS3_7(s2_A, c2_A, s2_B, s3_7, c3_7);

  wire [NSIG+81:71] s3_8;
  wire [NSIG+82:76] c3_8;
  
  compress_4_csc4 #(NSIG) TS3_8(c2_B, s2_C, c2_C, s3_8, c3_8);

  wire [NSIG+95:81] s3_9;
  wire [NSIG+90:86] c3_9;

  compress_4_scs1 #(NSIG) TS3_9(s2_D, c2_D, s2_E, s3_9, c3_9);

  wire [NSIG+104:91] s3_A;
  wire [NSIG+101:96] c3_A;

  compress_4_csc1 #(NSIG) TS3_A(c2_E, s2_F, c2_F, s3_A, c3_A);

  wire [NSIG+112:102] s3_B;
  wire [NSIG+109:106] c3_B;

  compress_4_scs1_local_112 TS3_B(s2_G, c2_G, s2_H, s3_B, c3_B);
  
  // Stage 5
  wire [NSIG+23:0] s4_1;
  wire [NSIG+15:6] c4_1;

  compress_5_scs1 #(NSIG) TS4_1(s3_1, c3_1, s3_2, s4_1, c4_1);

  wire [NSIG+35:15] s4_2;
  wire [NSIG+29:22] c4_2;

  compress_5_csc1 #(NSIG) TS4_2(c3_2, s3_3, c3_3, s4_2, c4_2);  
  
  wire [NSIG+54:31] s4_3;
  wire [NSIG+42:36] c4_3;

  compress_5_scs2 #(NSIG) TS4_3(s3_4, c3_4, s3_5, s4_3, c4_3);

  wire [NSIG+62:45] s4_4;
  wire [NSIG+62:52] c4_4;

  compress_5_csc2 #(NSIG) TS4_4(c3_5, s3_6, c3_6, s4_4, c4_4);

  wire [NSIG+81:61] s4_5;
  wire [NSIG+78:66] c4_5;

  compress_5_scs3 #(NSIG) TS4_5(s3_7, c3_7, s3_8, s4_5, c4_5);

  wire [NSIG+95:76] s4_6;
  wire [NSIG+91:82] c4_6;

  compress_5_csc3 #(NSIG) TS4_6(c3_8, s3_9, c3_9, s4_6, c4_6);

  wire [NSIG+112:91] s4_7;
  wire [NSIG+105:97] c4_7;

  compress_5_scs4_local TS4_7(s3_A, c3_A, s3_B, s4_7, c4_7);

  // Stage 6
  wire [NSIG+35:0] s5_1;
  wire [NSIG+24:7] c5_1;

  compress_6_scs1 #(NSIG) TS5_1(s4_1, c4_1, s4_2, s5_1, c5_1);
  
  wire [NSIG+54:22] s5_2;
  wire [NSIG+43:32] c5_2;

  compress_6_csc1 #(NSIG) TS5_2(c4_2, s4_3, c4_3, s5_2, c5_2);

  wire [NSIG+81:45] s5_3;
  wire [NSIG+63:53] c5_3;

  compress_6_scs2 #(NSIG) TS5_3(s4_4, c4_4, s4_5, s5_3, c5_3);
  
  wire [NSIG+95:66] s5_4;
  wire [NSIG+92:77] c5_4;

  compress_6_csc2 #(NSIG) TS5_4(c4_5, s4_6, c4_6, s5_4, c5_4);

  wire [NSIG+112:91] s5_5;
  wire [NSIG+110:98] c5_5;

  compress_6_scc_local TS5_5(s4_7, c4_7, c3_B, s5_5, c5_5);

  // Stage 7
  wire [NSIG+54:0] s6_1;
  wire [NSIG+36:8] c6_1;

  compress_7_scs1 #(NSIG) TS6_1(s5_1, c5_1, s5_2, s6_1, c6_1);
  
  wire [NSIG+81:32] s6_2;
  wire [NSIG+64:46] c6_2;

  compress_7_csc1 #(NSIG) TS6_2(c5_2, s5_3, c5_3, s6_2, c6_2);

  wire [NSIG+112:66] s6_3;
  wire [NSIG+96:78] c6_3;

  compress_7_scs2_local TS6_3(s5_4, c5_4, s5_5, s6_3, c6_3);

  // Stage 8
  wire [NSIG+81:0] s7_1;
  wire [NSIG+55:9] c7_1;

  compress_8_scs1 #(NSIG) TS7_1(s6_1, c6_1, s6_2, s7_1, c7_1);
  
  wire [NSIG+112:46] s7_2;
  wire [NSIG+97:67] c7_2;

  compress_8_csc1_local TS7_2(c6_2, s6_3, c6_3, s7_2, c7_2);

  // Stage 9
  wire [NSIG+112:0] s8_1;
  wire [NSIG+82:10] c8_1;

  compress_9_scs1_local TS8_1(s7_1, c7_1, s7_2, s8_1, c8_1);

  wire [NSIG+112:67] s8_2;
  wire [NSIG+111:99] c8_2;

  compress_9_ccc1_local TS8_2(c7_2, c5_5, c2_H, s8_2, c8_2);

  // Stage 10
  wire [NSIG+112:0] s9_1;
  wire [NSIG+113:11] c9_1;

  compress_10_scs1_local TS9_1(s8_1, c8_1, s8_2, s9_1, c9_1);

  // Stage 11
  wire [NSIG+113:0] sA_1;
  wire [NSIG+113:12] cA_1;

  compress_11_scc1_local TSA_1(s9_1, c9_1, c8_2, sA_1, cA_1);
  
  wire Cout;
  
  assign p[11:0] = sA_1[11:0];
  padder214 U0(sA_1[NSIG+113:12], cA_1, 1'b0, p[NSIG+113:12], Cout);
  
endmodule
