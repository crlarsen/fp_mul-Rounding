`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright: Chris Larsen, 2021
// Engineer: Chris Larsen
// 
// Create Date: 03/20/2021 09:47:04 PM
// Design Name: 
// Module Name: compress3_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Write generic modules for the 3:2 compression cases we
//              commonly expect to see while implementing significand
//              multiplication for the various IEEE 754 binary formats.
//              These common cases have been parameterized to increase
//              their generality.
// 
// Dependencies: hadder, fadder
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module compress_1_ppp(x, y, z, s, c);
    parameter NSIG = 10;
    input [NSIG:0] x;
    input [NSIG+1:1] y;
    input [NSIG+2:2] z;
    output [NSIG+2:0] s;
    output [NSIG+2:2] c;
    
    assign s[0] = x[0];
    
    hadder U0(x[1], y[1], s[1], c[2]);
    
    genvar i;
    generate
      for (i = 2; i < NSIG+1; i = i + 1)
        begin
          fadder Ui(x[i], y[i], z[i], s[i], c[i+1]);
        end
    endgenerate
    
    hadder U1(y[NSIG+1], z[NSIG+1], s[NSIG+1], c[NSIG+2]);
    
    assign s[NSIG+2] = z[NSIG+2];
endmodule

// After compressing the partial products the next 3:2 compression is
// going to alternate between sum-carry-sum vectors and carry-sum-carry
// vectors. The next 2 modules deal with these two cases.
module compress_2_scs(x, y, z, s, c);
  parameter NSIG = 10;
  input [NSIG+2:0] x;
  input [NSIG+2:2] y;
  input [NSIG+5:3] z;
  output [NSIG+5:0] s;
  output [NSIG+3:3] c;
  
  assign s[1:0] = x[1:0];
  
  hadder U1(x[2], y[2], s[2], c[3]);
  
  genvar i;
  generate
    for (i = 3; i <= NSIG+2; i = i + 1)
      begin
        fadder Ui(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+5:NSIG+3] = z[NSIG+5:NSIG+3];
endmodule

module compress_2_csc(x, y, z, s, c);
  parameter NSIG = 10;
  input [NSIG+5:5] x;
  input [NSIG+8:6] y;
  input [NSIG+8:8] z;
  output [NSIG+8:5] s;
  output [NSIG+9:7] c;
  
  assign s[5] = x[5];
  
  genvar i;
  generate
    for (i = 6; i < 8; i = i + 1)
      begin
        hadder Ui(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 8; i <= NSIG+5; i = i + 1)
      begin
        fadder Vi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+6; i <= NSIG+8; i = i + 1)
      begin
        hadder Wi(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
endmodule

module compress_3_scs1(x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+5:0] x;
  input [NSIG+3:3] y;
  input [NSIG+8:5] z;
  output [NSIG+8:0] s;
  output [NSIG+6:4] c;
  
  assign s[2:0] = x[2:0];
  
  genvar i;
  generate
    for (i = 3; i < 5; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 5; i < NSIG+4; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+4; i < NSIG+6; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+8:NSIG+6] =  z[NSIG+8:NSIG+6];
endmodule

module compress_3_csc1(x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+9:7] x;
  input [NSIG+14:9] y;
  input [NSIG+12:12] z;
  output [NSIG+14:7] s;
  output [NSIG+13:10] c;
  
  assign s[8:7] = x[8:7];
  
  genvar i;
  generate
    for (i = 9; i < 12; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 12; i < NSIG+10; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+10; i < NSIG+13; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+14:NSIG+13] =  y[NSIG+14:NSIG+13];
endmodule
  
module compress_3_scs2 (x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+17:14] x;
  input [NSIG+18:16] y;
  input [NSIG+23:18] z;
  output [NSIG+23:14] s;
  output [NSIG+19:17] c;
  
  assign s[15:14] = x[15:14];
  
  genvar i;
  generate
    for (i = 16; i < 18; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 18; i < NSIG+18; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  hadder Hj(y[NSIG+18], z[NSIG+18], s[NSIG+18], c[NSIG+19]);

  assign s[NSIG+23:NSIG+19] =  z[NSIG+23:NSIG+19];
endmodule
  
module compress_3_csc2(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+21:21] x;
  input [NSIG+26:23] y;
  input [NSIG+27:25] z;
  output [NSIG+27:21] s;
  output [NSIG+27:24] c;
  
  assign s[22:21] = x[22:21];
  
  genvar i;
  generate
    for (i = 23; i < 25; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end

    for (i = 25; i < NSIG+22; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end

    for (i = NSIG+22; i < NSIG+27; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end

    assign s[NSIG+27] = z[NSIG+27];
  endgenerate
endmodule
    
module compress_4_scs1(x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+8:0] x;
  input [NSIG+6:4] y;
  input [NSIG+14:7] z;
  output [NSIG+14:0] s;
  output [NSIG+9:5] c;
  
  assign s[3:0] = x[3:0];
  
  genvar i;
  generate
    for (i = 4; i < 7; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 7; i < NSIG+7; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+7; i < NSIG+9; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+14:NSIG+9] =  z[NSIG+14:NSIG+9];
endmodule

module compress_4_csc1(x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+13:10] x;
  input [NSIG+23:14] y;
  input [NSIG+19:17] z;
  output [NSIG+23:10] s;
  output [NSIG+20:15] c;
  
  assign s[13:10] = x[13:10];
  
  genvar i;
  generate
    for (i = 14; i < 17; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 17; i < NSIG+14; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+14; i < NSIG+20; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+23:NSIG+20] =  y[NSIG+23:NSIG+20];
endmodule
    
module compress_4_scs2(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+27:21] x;
  input [NSIG+27:24] y;
  input [NSIG+35:27] z;
  output [NSIG+35:21] s;
  output [NSIG+28:25] c;
  
  assign s[23:21] = x[23:21];
  
  genvar i;
  generate
    for (i = 24; i < 27; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end

    for (i = 27; i < NSIG+28; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+35:NSIG+28] = z[NSIG+35:NSIG+28];
endmodule

module compress_4_csc2(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+33:31] x;
  input [NSIG+41:34] y;
  input [NSIG+40:37] z;
  output [NSIG+41:31] s;
  output [NSIG+41:35] c;
  
  assign s[33:31] = x[33:31];
  
  genvar i;
  generate
    for (i = 34; i < 37; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
      
    for (i = 37; i < NSIG+34; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
      
    for (i = NSIG+34; i < NSIG+41; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+41] = y[NSIG+41];
endmodule

module compress_4_scs3(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+50:41] x;
  input [NSIG+46:44] y;
  input [NSIG+54:48] z;
  output [NSIG+54:41] s;
  output [NSIG+51:45] c;
  
  assign s[43:41] = x[43:41];
  
  genvar i;
  generate
    for (i = 44; i < 48; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 48; i < NSIG+47; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+47; i < NSIG+51; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+54:NSIG+51] =  z[NSIG+54:NSIG+51];
endmodule

module compress_4_csc3(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+54:51] x;
  input [NSIG+62:54] y;
  input [NSIG+60:58] z;
  output [NSIG+62:51] s;
  output [NSIG+61:55] c;
  
  assign s[53:51] = x[53:51];
  
  genvar i;
  generate
    for (i = 54; i < 58; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 58; i < NSIG+55; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+55; i < NSIG+61; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+62:NSIG+61] =  y[NSIG+62:NSIG+61];
endmodule

module compress_4_scs4(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+68:61] x;
  input [NSIG+67:64] y;
  input [NSIG+77:68] z;
  output [NSIG+77:61] s;
  output [NSIG+69:65] c;
  
  assign s[63:61] = x[63:61];
  
  genvar i;
  generate
    for (i = 64; i < 68; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 68; i < NSIG+68; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  hadder H68(x[NSIG+68], z[NSIG+68], s[NSIG+68], c[NSIG+69]);

  assign s[NSIG+77:NSIG+69] =  z[NSIG+77:NSIG+69];
endmodule

module compress_4_csc4(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+73:71] x;
  input [NSIG+81:75] y;
  input [NSIG+81:78] z;
  output [NSIG+81:71] s;
  output [NSIG+82:76] c;
  
  assign s[74:71] = x[74:71];
  
  genvar i;
  generate
    for (i = 75; i < 78; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 78; i < NSIG+74; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+74; i < NSIG+82; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
endmodule

module compress_5_scs1(x, y, z, s, c);
  parameter NSIG = 23;
  input [NSIG+14:0] x;
  input [NSIG+9:5] y;
  input [NSIG+23:10] z;
  output [NSIG+23:0] s;
  output [NSIG+15:6] c;
  
  assign s[4:0] = x[4:0];
  
  genvar i;
  generate
    for (i = 5; i < 10; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 10; i < NSIG+10; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+10; i < NSIG+15; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  assign s[NSIG+23:NSIG+15] =  z[NSIG+23:NSIG+15];
endmodule

module compress_5_csc1(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+20:15] x;
  input [NSIG+35:21] y;
  input [NSIG+28:25] z;
  output [NSIG+35:15] s;
  output [NSIG+29:22] c;
  
  assign s[20:15] = x[20:15];
  
  genvar i;
  generate
    for (i = 21; i < 25; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end

    for (i = 25; i < NSIG+21; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end

    for (i = NSIG+21; i < NSIG+29; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+35:NSIG+29] = y[NSIG+35:NSIG+29];
endmodule

module compress_6_scs1(x, y, z, s, c);
  parameter NSIG = 52;
  input [NSIG+23:0] x;
  input [NSIG+15:6] y;
  input [NSIG+35:15] z;
  output [NSIG+35:0] s;
  output [NSIG+24:7] c;
  
  assign s[5:0] = x[5:0];
  
  assign s[14:6] = x[14:6] ^ y[14:6];
  assign c[15:7] = x[14:6] & y[14:6];
  
  assign s[NSIG+15:15] = x[NSIG+15:15] ^ y[NSIG+15:15] ^ z[NSIG+15:15];
  assign c[NSIG+16:16] = (x[NSIG+15:15] & y[NSIG+15:15]) |
                            (x[NSIG+15:15] & z[NSIG+15:15]) |
                            (y[NSIG+15:15] & z[NSIG+15:15]);
                            
  assign s[NSIG+23:NSIG+16] = x[NSIG+23:NSIG+16] ^ z[NSIG+23:NSIG+16];
  assign c[NSIG+24:NSIG+17] = x[NSIG+23:NSIG+16] & z[NSIG+23:NSIG+16];
                            
  assign s[NSIG+35:NSIG+24] = z[NSIG+35:NSIG+24];
endmodule

module compress_5_scs2(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+41:31] x;
  input [NSIG+41:35] y;
  input [NSIG+54:41] z;
  output [NSIG+54:31] s;
  output [NSIG+42:36] c;
  
  assign s[34:31] = x[34:31];
  
  genvar i;
  generate
    for (i = 35; i < 41; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 41; i < NSIG+42; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+54:NSIG+42] =  z[NSIG+54:NSIG+42];
endmodule

module compress_5_csc2(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+51:45] x;
  input [NSIG+62:51] y;
  input [NSIG+61:55] z;
  output [NSIG+62:45] s;
  output [NSIG+62:52] c;
  
  assign s[50:45] = x[50:45];
  
  genvar i;
  generate
    for (i = 51; i < 55; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end

    for (i = 55; i < NSIG+52; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end

    for (i = NSIG+52; i < NSIG+62; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+62] = y[NSIG+62];
endmodule

module compress_5_scs3(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+77:61] x;
  input [NSIG+69:65] y;
  input [NSIG+81:71] z;
  output [NSIG+81:61] s;
  output [NSIG+78:66] c;
  
  assign s[64:61] = x[64:61];
  
  genvar i;
  generate
    for (i = 65; i < 71; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 71; i < NSIG+70; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+70; i < NSIG+78; i = i + 1)
      begin
        hadder Hi(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+81:NSIG+78] =  z[NSIG+81:NSIG+78];
endmodule

module compress_5_csc3(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+82:76] x;
  input [NSIG+95:81] y;
  input [NSIG+90:86] z;
  output [NSIG+95:76] s;
  output [NSIG+91:82] c;
  
  assign s[80:76] = x[80:76];
  
  genvar i;
  generate
    for (i = 81; i < 86; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end

    for (i = 86; i < NSIG+83; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end

    for (i = NSIG+83; i < NSIG+91; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+95:NSIG+91] = y[NSIG+95:NSIG+91];
endmodule

module compress_6_csc1(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+29:22] x;
  input [NSIG+54:31] y;
  input [NSIG+42:36] z;
  output [NSIG+54:22] s;
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
  
  assign s[NSIG+54:NSIG+43] = y[NSIG+54:NSIG+43];
endmodule

module compress_6_scs2(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+62:45] x;
  input [NSIG+62:52] y;
  input [NSIG+81:61] z;
  output [NSIG+81:45] s;
  output [NSIG+63:53] c;
  
  assign s[51:45] = x[51:45];
  
  genvar i;
  generate
    for (i = 52; i < 61; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
      
  generate
    for (i = 61; i < NSIG+63; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
      
  assign s[NSIG+81:NSIG+63] = z[NSIG+81:NSIG+63];
endmodule

module compress_6_csc2(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+78:66] x;
  input [NSIG+95:76] y;
  input [NSIG+91:82] z;
  output [NSIG+95:66] s;
  output [NSIG+92:77] c;
  
  assign s[75:66] = x[75:66];
  
  genvar i;
  generate
    for (i = 76; i < 82; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
      
  generate
    for (i = 82; i < NSIG+79; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
      
  generate
    for (i = NSIG+79; i < NSIG+92; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
      
  assign s[NSIG+95:NSIG+92] = y[NSIG+95:NSIG+92];
endmodule

module compress_7_scs1(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+35:0] x;
  input [NSIG+24:7] y;
  input [NSIG+54:22] z;
  output [NSIG+54:0] s;
  output [NSIG+36:8] c;
  
  assign s[6:0] = x[6:0];
  
  genvar i;
  generate
    for (i = 7; i < 22; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 22; i < NSIG+25; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = NSIG+25; i < NSIG+36; i = i + 1)
      begin
        hadder Hi(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+54:NSIG+36] = z[NSIG+54:NSIG+36];

endmodule
  
module compress_7_csc1(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+43:32] x;
  input [NSIG+81:45] y;
  input [NSIG+63:53] z;
  output [NSIG+81:32] s;
  output [NSIG+64:46] c;
  
  assign s[44:32] = x[44:32];
  
  genvar i;
  generate
    for (i = 45; i < 53; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = 53; i < NSIG+44; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate

  generate
    for (i = NSIG+44; i < NSIG+64; i = i + 1)
      begin
        hadder Hj(y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+81:NSIG+64] = y[NSIG+81:NSIG+64];

endmodule

module compress_8_scs1(x, y, z, s, c);
  parameter NSIG = 112;
  input [NSIG+54:0] x;
  input [NSIG+36:8] y;
  input [NSIG+81:32] z;
  output [NSIG+81:0] s;
  output [NSIG+55:9] c;
  
  assign s[7:0] = x[7:00];
  
  genvar i;
  generate
    for (i = 8; i < 32; i = i + 1)
      begin
        hadder Hi(x[i], y[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = 32; i < NSIG+37; i = i + 1)
      begin
        fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  generate
    for (i = NSIG+37; i < NSIG+55; i = i + 1)
      begin
        hadder Hj(x[i], z[i], s[i], c[i+1]);
      end
  endgenerate
  
  assign s[NSIG+81:NSIG+55] = z[NSIG+81:NSIG+55];

endmodule
