# Verilog IEEE 754 Multiply w/Rounding

## Description

Update fp_mul module to support rounding.

Code is explained in the video series [Building an FPU in Verilog](https://www.youtube.com/watch?v=rYkVdJnVJFQ&list=PLlO9sSrh8HrwcDHAtwec1ycV-m50nfUVs).
See the video *Building an FPU in Verilog: Rounding the Results of fp_mul*.

## Manifest

|   Filename   |                        Description                        |
|--------------|-----------------------------------------------------------|
| README.md | This file. |
| ieee-754-flags.vh | Verilog header file to define constants for datum type (NaN, Infinity, Zero, Subnormal, and Normal), rounding attributes, and IEEE exceptions. |
| fp_class.sv | Utility module to identify the type of the IEEE 754 value passed in, and extract the exponent & significand fields for use by other modules. |
| fp_mul.v  | Parameterized multiply circuit for the IEEE 754 binary data types. |
| sigmul_10.v | Significand multiplication module using 3:2 compression for the binary16 format. |
| padder16.v | Prefix adder used by sigmul_10 module. |
| sigmul_23.v | Significand multiplication module using 3:2 compression for the binary32 format. |
| padder40.v | Prefix adder used by sigmul_23 module. |
| sigmul_52.v | Significand multiplication module using 3:2 compression for the binary64 format. |
| padder96.v | Prefix adder used by sigmul_52 module. |
| sigmul_112.v | Significand multiplication module using 3:2 compression for the binary128 format. |
| padder214.v | Prefix adder used by sigmul_112 module. |
| compress3_2.v | Generic 3:2 compression modules used by the significand multiplication modules. |
| fadder.v | Full adder module used by the 3:2 compression modules. |
| hadder.v | Half adder module used by the 3:2 compression modules. |
| fp_mul_tb.v | Parameterized testbench for all IEEE 754 binary formats. |
| simulate.\*-16 | Test logs for all 4 rounding attributes for the binary16 format. |
| simulate.\*-32 | Test logs for all 4 rounding attributes for the binary32 format. |
| simulate.\*-64 | Test logs for all 4 rounding attributes for the binary64 format. |
| simulate.\*-128 | Test logs for all 4 rounding attributes for the binary128 format. |
| round.v | Parameterized rounding module. |
| padder11.v | Prefix adder needed by the rounding module. |
| padder24.v | Prefix adder needed by the rounding module. |
| padder53.v | Prefix adder needed by the rounding module. |
| padder113.v | Prefix adder needed by the rounding module. |
| PijGij.v | Utility routines needed by the various prefix adder modules. |

## Copyright

:copyright: Chris Larsen, 2019-2022
