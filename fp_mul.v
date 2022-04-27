`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Copyright: Chris Larsen 2019
// Engineer: Chris Larsen
//
// Create Date: 07/26/2019 07:05:10 PM
// Design Name: Parameterized Floating Point Multiplier
// Module Name: fp_mul
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

module fp_mul(a, b, ra, p, pFlags, exception);
  parameter NEXP = 5;
  parameter NSIG = 10;
  `include "ieee-754-flags.vh"
  input [NEXP+NSIG:0] a, b;
  input [NRAS-1:0] ra;
  output [NEXP+NSIG:0] p;
  output [NTYPES-1:0] pFlags;
  reg [NTYPES-1:0] pFlags;
  output [NEXCEPTIONS-1:0] exception;
  reg [NEXCEPTIONS-1:0] exception;

  wire signed [NEXP+1:0] aExp, bExp, expOut;
  reg signed [NEXP+1:0] pExp, expIn;
  wire [NSIG:0] aSig, bSig, sigOut;

  reg [NEXP+NSIG:0] pTmp;

  wire [2*NSIG+1:0] rawSignificand;
  reg [2*NSIG+1:0] sigIn;

  wire [NTYPES-1:0] aFlags, bFlags;

  reg pSign, subnormal, si;
  wire inexact;

  fp_class #(NEXP,NSIG) aClass(a, aExp, aSig, aFlags);
  fp_class #(NEXP,NSIG) bClass(b, bExp, bSig, bFlags);

  if (NSIG == 10)
    sigmul_10 U10(aSig, bSig, rawSignificand);
  else if (NSIG == 23)
    sigmul_23 U23(aSig, bSig, rawSignificand);
  else if (NSIG == 52)
    sigmul_52 U52(aSig, bSig, rawSignificand);
  else if (NSIG == 112)
    sigmul_112 U112(aSig, bSig, rawSignificand);
//  else
//    assign rawSignificand = aSig * bSig;    

  always @(*)
  begin
    // IEEE 754-2019, section 6.3 requires that "[w]hen neither the
    // inputs nor result are NaN, the sign of a product ... is the
    // exclusive OR of the operands' signs".
    pSign = a[NEXP+NSIG] ^ b[NEXP+NSIG];
    pTmp = {pSign, {NEXP{1'b1}}, 1'b0, {NSIG-1{1'b1}}};  // Initialize p to be an sNaN.
    pFlags = 6'b000000;
    exception = 0;

    if ((aFlags[SNAN] | bFlags[SNAN]) == 1'b1)
      begin
        pTmp = aFlags[SNAN] == 1'b1 ? a : b;
        pFlags[SNAN] = 1;
        exception[INVALID] = 1;
      end
    else if ((aFlags[QNAN] | bFlags[QNAN]) == 1'b1)
      begin
        pTmp = aFlags[QNAN] == 1'b1 ? a : b;
        pFlags[QNAN] = 1;
      end
    else if ((aFlags[INFINITY] | bFlags[INFINITY]) == 1'b1)
      begin
        if ((aFlags[ZERO] | bFlags[ZERO]) == 1'b1)
          begin
            pTmp = {pSign, {NEXP{1'b1}}, 1'b1, {NSIG-1{1'b0}}}; // qNaN
            pFlags[QNAN] = 1;
            exception[INVALID] = 1;
          end
        else
          begin
            si = ra[roundTowardZero] |
                (ra[roundTowardNegative] & ~pSign) |
                (ra[roundTowardPositive] &  pSign);
            pTmp = {pSign, {NEXP-1{1'b1}}, ~si, {NSIG{si}}};
            pFlags[INFINITY] = ~si;
            pFlags[NORMAL]   =  si;
            exception[OVERFLOW] = 1;
          end
      end
    else if ((aFlags[ZERO] | bFlags[ZERO]) == 1'b1)
      begin
        pTmp = {pSign, {NEXP+NSIG{1'b0}}};
        pFlags[ZERO] = 1;
      end
    else
      begin
        sigIn = rawSignificand << ~rawSignificand[2*NSIG+1];
        expIn = aExp + bExp + rawSignificand[2*NSIG+1];

        // Here control logically passes out of the always block and into
        // the rounding module. This happens because the rounding module
        // can't be instantiated inside of the always block.

        if (expOut < EMIN) //The significand was rounded to zero or is Subnormal
          begin
            // For subnormal numbers there is no leading 1 bit to strip off so
            // we take the NSIG most significant bits. This also works in the
            // case that we rounded to zero.
            pTmp = {pSign, {NEXP{1'b0}}, sigOut[NSIG:1]};
            subnormal = |sigOut[NSIG:1];
            pFlags[SUBNORMAL] =  subnormal;
            pFlags[ZERO]      = ~subnormal;
            exception[UNDERFLOW] = 1;
          end
        else if (expOut > EMAX) // Infinity
          begin
            si = ra[roundTowardZero] |
                (ra[roundTowardNegative] & ~pSign) |
                (ra[roundTowardPositive] &  pSign);
            pTmp = {pSign, {NEXP-1{1'b1}}, ~si, {NSIG{si}}};
            pFlags[INFINITY] = ~si;
            pFlags[NORMAL]   =  si;
            exception[OVERFLOW] = 1;
          end
        else // Normal
          begin
            pExp = expOut + BIAS;
            // Remember that for Normals we always assume the most
            // significant bit is 1 so we only store the least
            // significant NSIG bits in the significand.
            pTmp = {pSign, pExp[NEXP-1:0], sigOut[NSIG-1:0]};
            pFlags[NORMAL] = 1;
          end
      
        exception[INEXACT] = inexact;
      end //
  end
  
  // Round the significand.
  round #(2*NSIG+2, NEXP, NSIG) U0(pSign, expIn, sigIn, ra, expOut, sigOut,
                                   inexact);

  // Logically control returns to the always block which constructs the final
  // product value based the rounded exponent value expOut.

  assign p = pTmp;

endmodule
