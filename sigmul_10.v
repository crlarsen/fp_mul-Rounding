`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright: Chris Larsen, 2019-2021 
// Engineer: Chris Larsen
// 
// Create Date: 01/18/2021 08:33:16 AM
// Design Name: 
// Module Name: sigmul_10
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 11-bit Significand Multiply Circuit
//              This code assumes that the most significant bits of both input
//              values will be 1 (one) because of the way the parent module
//              extracts significands for normal and subnormal numbers. The
//              the output of this module will only ever be used if the two 
//              IEEE 754 binary16 floating point numbers being multiplied are
//              both normal, or subnormal numbers. Logic in the parent module
//              doesn't need the output of this module if either of the input
//              values are NaNs, Infinities, or Zeroes.
//
//              The module uses 3:2 compression to avoid carry bit propagation
//              delay, when possible. When the module uses a prefix adder to
//              perform addition, when addition can't be avoided.
// 
// Dependencies: Modules compress_1_ppp, compress_2_scs, compress_2_csc, hadder, fadder,
//               and padder16.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module compress_3_cpp_local(x, y, z, s, c);
    parameter NSIG = 10;
    input [NSIG+9:7] x;
    input [NSIG+9:9] y;
    input [NSIG+10:10] z;
    output [NSIG+10:7] s;
    output [NSIG+10:10] c;

    assign s[8:7] = x[8:7];

    hadder H9(x[9], y[9], s[9], c[10]);

    genvar i;
    generate
      for (i = 10; i < NSIG+10; i = i + 1)
        begin
          fadder Fi(x[i], y[i], z[i], s[i], c[i+1]);
        end
    endgenerate

    assign s[NSIG+10] = z[NSIG+10];
    
endmodule

module compress_4_scs1_local_10(x, y, z, s, c);
    parameter NSIG = 10;
    input [NSIG+8:0] x;
    input [NSIG+6:4] y;
    input [NSIG+10:7] z;
    output [NSIG+10:0] s;
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

    assign s[NSIG+10:NSIG+9] = z[NSIG+10:NSIG+9];
    
endmodule

module compress_5_scc1_local(x, y, z, s, c);
    parameter NSIG = 10;
    input [NSIG+10:0] x;
    input [NSIG+9:5] y;
    input [NSIG+10:10] z;
    output [NSIG+10:0] s;
    output [NSIG+11:6] c;

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

    hadder Hj(x[NSIG+10], z[NSIG+10], s[NSIG+10], c[NSIG+11]);

endmodule

module sigmul_10(a, b, p);
    parameter NSIG = 10;
    input [NSIG:0] a;
    input [NSIG:0] b;
    output [2*NSIG+1:0] p;
    
    wire [NSIG:0] pp[NSIG:0];
    
    genvar i;
    generate
      for (i = 0; i < NSIG; i = i + 1)
      begin
        assign pp[i] = a & {NSIG+1{b[i]}};
      end
      
      assign pp[NSIG] = a;
    endgenerate
    
    // Stage 1
    wire [NSIG+2:0] s1_1;
    wire [NSIG+2:2] c1_1;
    
    compress_1_ppp sc012(pp[0], pp[1], pp[2], s1_1, c1_1);

    wire [NSIG+5:3] s1_2;
    wire [NSIG+5:5] c1_2;
    
    compress_1_ppp sc345(pp[3], pp[4], pp[5], s1_2, c1_2);

    wire [NSIG+8:6] s1_3;
    wire [NSIG+8:8] c1_3;
    
    compress_1_ppp sc678(pp[6], pp[7], pp[8], s1_3, c1_3);
    
    // Stage 2
    wire [NSIG+5:0] s2_1;
    wire [NSIG+3:3] c2_1;
    
    compress_2_scs TS1_1(s1_1, c1_1, s1_2, s2_1, c2_1);
    
    // Strip off the next bits of our product.
    assign p[2:0] = s2_1[2:0];
    
    wire [NSIG+8:5] s2_2;
    wire [NSIG+9:7] c2_2;
    
    compress_2_csc TS1_2(c1_2, s1_3, c1_3, s2_2, c2_2);
    
    // Stage 3
    wire [NSIG+8:0] s3_1;
    wire [NSIG+6:4] c3_1;
    
    compress_3_scs1 #(NSIG) TS3_1(s2_1, c2_1, s2_2, s3_1, c3_1);

    wire [NSIG+10:7] s3_2;
    wire [NSIG+10:10] c3_2;
    
    compress_3_cpp_local #(NSIG) TS3_2(c2_2, pp[9], pp[10], s3_2, c3_2);
    
    // Stage 4
//    wire [NSIG+8:0] s3_1;
//    wire [NSIG+6:4] c3_1;
//    wire [NSIG+10:7] s3_2;
    wire [NSIG+10:0] s4_1;
    wire [NSIG+9:5] c4_1;
    
    compress_4_scs1_local_10 #(NSIG) TS4_1(s3_1, c3_1, s3_2, s4_1, c4_1);

    // Stage 5
//    wire [NSIG+10:0] s4_1;
//    wire [NSIG+9:5] c4_1;
//    wire [NSIG+10:10] c3_2;
    wire [NSIG+10:0] s5_1;
    wire [NSIG+11:6] c5_1;

    compress_5_scc1_local #(NSIG) TS5_1(s4_1, c4_1, c3_2, s5_1, c5_1);

    assign p[5:0] = s5_1[5:0];

    wire Cout;
    padder16 psum({ 1'b0, s5_1[NSIG+10:6] }, c5_1, 1'b0, p[NSIG+11:6], Cout);

endmodule
