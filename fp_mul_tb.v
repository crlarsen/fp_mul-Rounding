`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright: © 2019-2020, Chris Larsen
// Engineer:
//
// Create Date: 07/26/2019 07:19:00 PM
// Design Name:
// Module Name: fp_mul_tb_16
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


module fp_mul_tb;
`define BINARY16 1
  // {NEXP, NSIG} = {5, 10} | {8, 23} | {11, 52} | {15, 112}
`ifdef BINARY16
  parameter NEXP =   5;
  parameter NSIG =  10;
`elsif BINARY32
  parameter NEXP =   8;
  parameter NSIG =  23;
`elsif BINARY64
  parameter NEXP =  11;
  parameter NSIG =  52;
`elsif BINARY128
  parameter NEXP =  15;
  parameter NSIG = 112;
`else
  No valid IEEE type
`endif
  `include "ieee-754-flags.vh"
  reg [NEXP+NSIG:0] a, b;
  // roundTiesToEven roundTowardZero roundTowardPositive roundTowardNegative
  reg [NRAS-1:0] ra = 1 << roundTiesToEven;
  wire [NEXP+NSIG:0] p;
  wire [NTYPES-1:0] flags;
  wire [NEXCEPTIONS-1:0] exception;
  
  reg [NEXP-1:0] exp;

  integer i, j, k, l, m, n;

  initial
  begin
    $display("Test multiply circuit for binary%0d, %0s:\n\n", NEXP+NSIG+1,
              ra[roundTiesToEven] ? "roundTiesToEven" :
                (ra[roundTowardZero] ? "roundTowardZero" :
                  (ra[roundTowardPositive] ? "roundTowardPositive" :
                    (ra[roundTowardNegative] ? "roundTowardNegative" :
                      (ra[roundTiesToAway] ? "roundTiesToAway" : "NO VALID ROUNDING MODE")))));

    // For these tests a is always a signalling NaN.
    $display("sNaN * {sNaN, qNaN, infinity, zero, subnormal, normal}:");
    #0  assign a = {1'b0, {NEXP{1'b1}}, 1'b0, ({NSIG-1{1'b0}} | 4'hA)};
        assign b = {1'b0, {NEXP{1'b1}}, 1'b0, ({NSIG-1{1'b0}} | 4'hB)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, {NEXP{1'b1}}, 1'b1, ({NSIG-1{1'b0}} | 4'hB)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hB)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hB)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);

    // For these tests b is always a signalling NaN.
    $display("\n{qNaN, infinity, zero, subnormal, normal} * sNaN:");
    assign b = {1'b0, {NEXP{1'b1}}, 1'b0, ({NSIG-1{1'b0}} | 4'hB)};
    assign a = {1'b0, {NEXP{1'b1}}, 1'b1, ({NSIG-1{1'b0}} | 4'hA)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign a = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign a = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign a = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hA)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign a = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hA)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);

    // For these tests a is always a quiet NaN.
    $display("\nqNaN * {qNaN, infinity, zero, subnormal, normal}:");
    assign a = {1'b0, {NEXP{1'b1}}, 1'b1, ({NSIG-1{1'b0}} | 4'hA)};
    assign b = {1'b0, {NEXP{1'b1}}, 1'b1, ({NSIG-1{1'b0}} | 4'hB)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hB)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    assign b = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hB)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);

    // For these tests b is always a quiet NaN.
    $display("\n{infinity, zero, subnormal, normal} * qNaN:");
    assign b = {1'b0, {NEXP{1'b1}}, 1'b1, ({NSIG-1{1'b0}} | 4'hB)};
    assign a = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    #10  assign a = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    #10  assign a = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hA)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    #10  assign a = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hA)};
    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);

    // Test signed multiplication of Infinity:
    for (i = 0; i < 2; i = i + 1)
      for (j = 0; j < 2; j = j + 1)
        begin
         // For these tests a is always Infinity.
          $display("\n%sinfinity * {%sinfinity, %szero, %ssubnormal, %snormal}:", (i ? "-" : "+"), (j ? "-" : "+"), (j ? "-" : "+"), (j ? "-" : "+"), (j ? "-" : "+"));
          assign a = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}} | (i << NEXP+NSIG);
          assign b = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign b = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign b = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hB)} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign b = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hB)} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);

         // For these tests b is always Infinity.
          $display("\n{%szero, %ssubnormal, %snormal} * %sinfinity:", (i ? "-" : "+"), (i ? "-" : "+"), (i ? "-" : "+"), (j ? "-" : "+"));
          assign b = {1'b0, {NEXP{1'b1}}, {NSIG{1'b0}}} | (j << NEXP+NSIG);
          assign a = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}} | (i << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign a = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hA)} | (i << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign a = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hA)} | (i << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    end

    // Test signed multiplication of Zero:
    for (i = 0; i < 2; i = i + 1)
      for (j = 0; j < 2; j = j + 1)
        begin
         // For these tests a is always Zero.
          $display("\n%szero * {%szero, %ssubnormal, %snormal}:", (j ? "-" : "+"), (i ? "-" : "+"), (i ? "-" : "+"), (i ? "-" : "+"));
          assign a = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}} | (j << NEXP+NSIG);
          assign b = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}} | (i << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign b = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hB)} | (i << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign b = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hB)} | (i << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);

         // For these tests b is always Zero.
          $display("\n{%ssubnormal, %snormal} * %szero:", (j ? "-" : "+"), (j ? "-" : "+"), (i ? "-" : "+"));
          assign b = {1'b0, {NEXP{1'b0}}, {NSIG{1'b0}}} | (i << NEXP+NSIG);
          assign a = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hA)} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
          assign a = {1'b0, 1'b0, {NEXP-1{1'b1}}, ({NSIG{1'b0}} | 4'hA)} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    end

    // Test signed multiplication of Subnormals:
    for (i = 0; i < 2; i = i + 1)
      for (j = 0; j < 2; j = j + 1)
        begin
          $display("\n%ssubnormal * %ssubnormal:", (i ? "-" : "+"), (j ? "-" : "+"));
          assign a = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hA)} | (i << NEXP+NSIG);
          assign b = {1'b0, {NEXP{1'b0}}, ({NSIG{1'b0}} | 4'hB)} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    end

    // Test rounding to infinity for roundTowardPositive,
    // roundTowardNegative, and roundTowardZero.
    for (i = 0; i < 2; i = i + 1)
      for (j = 0; j < 2; j = j + 1)
        begin
          $display("\n%s2**EMAX * %s2**EMAX:", (i ? "-" : "+"), (j ? "-" : "+"));
          assign a = {1'b0, {NEXP-1{1'b1}}, 1'b0, ({NSIG{1'b0}} | 4'hA)} | (i << NEXP+NSIG);
          assign b = {1'b0, {NEXP-1{1'b1}}, 1'b0, ({NSIG{1'b0}} | 4'hB)} | (j << NEXP+NSIG);
          #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
    end

    assign a = BIAS << NSIG;
    for (i = EMAX; i >= EMIN; i = i - 1)
      begin
        $display("\n1 * 2**%0d:", i);
        assign b = (i+BIAS) << NSIG;
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
      end

    assign a = BIAS << NSIG;
    for (i = EMIN-1; i >= EMIN-NSIG; i = i - 1)
      begin
        $display("\n1 * 2**%0d:", i);
        assign b = 1 << (NSIG - (EMIN - i));
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
      end

    assign b = BIAS << NSIG;
    for (i = EMAX; i >= EMIN; i = i - 1)
      begin
        $display("\n2**%0d * 1:", i);
        assign a = (i+BIAS) << NSIG;
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
      end

    assign b = BIAS << NSIG;
    for (i = EMIN-1; i >= EMIN-NSIG; i = i - 1)
      begin
        $display("\n2**%0d * 1:", i);
        assign a = 1 << (NSIG - (EMIN - i));
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
      end

    for (i = 0; i <= EMAX; i = i + 1)
      begin
        $display("\n2**%0d * 2**%0d:", i, EMAX-i);
        assign a = (i+BIAS) << NSIG;
        assign b = (EMAX-i+BIAS) << NSIG;
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
        assign a = a | ((1 << NSIG) - 1);
        assign b = b | ((1 << NSIG) - 1);
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
      end

    for (i = EMIN-NSIG; i < NSIG; i = i + 1)
      begin
        j = EMIN - 1 - i;
        $display("\n2**%0d * 2**%0d:", i, j);
        assign a = (i >= EMIN) ? ((i+BIAS) << NSIG) : (1 << (i - (EMIN-NSIG)));
        assign b = (j >= EMIN) ? ((j+BIAS) << NSIG) : (1 << (j - (EMIN-NSIG)));
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
        assign a = (i >= EMIN) ? (a | (((1 << NSIG) - 1))) : ((1 << (i - (EMIN-NSIG) + 1)) - 1);
        assign b = (j >= EMIN) ? (b | (((1 << NSIG) - 1))) : ((1 << (j - (EMIN-NSIG) + 1)) - 1);
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
      end

    for (i = EMIN-NSIG; i < 0; i = i + 1)
      begin
        j = EMIN-NSIG - 1 - i;
        $display("\n2**%0d * 2**%0d:", i, j);
        assign a = (i >= EMIN) ? ((i+BIAS) << NSIG) : (1 << (i - (EMIN-NSIG)));
        assign b = (j >= EMIN) ? ((j+BIAS) << NSIG) : (1 << (j - (EMIN-NSIG)));
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
        assign a = (i >= EMIN) ? (a | (((1 << NSIG) - 1))) : ((1 << (i - (EMIN-NSIG) + 1)) - 1);
        assign b = (j >= EMIN) ? (b | (((1 << NSIG) - 1))) : ((1 << (j - (EMIN-NSIG) + 1)) - 1);
        #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
      end

//    $display("\n20 * 20:"); // 1.0100000000 * 2**4 or 0x4D00
//    #10 assign a = 16'h4D00; assign b = 16'h4D00; // 1.1001000000 x 2**8 or 0x5E40
//    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);
        
//    $display("\n400 * PI:"); // PI = 1.1001001000 * 2**1
//    #10 assign a = 16'h5E40; assign b = 16'h4248; // 1.0011101000 * 2**10 or 0x64E8
//    #10 $display("p (%x %b %b) = a (%x) * b (%x)", p, flags, exception, a, b);

    #20 $display("\nEnd of tests : %t", $time);
    #20 $stop;
  end

  fp_mul #(NEXP, NSIG) inst1(
  .a(a),
  .b(b),
  .ra(ra),
  .p(p),
  .pFlags(flags),
  .exception(exception)
  );
endmodule
