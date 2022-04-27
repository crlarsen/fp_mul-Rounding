`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2021 10:21:47 PM
// Design Name: 
// Module Name: fadder
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


module fadder(x, y, z, s, c);
    input x, y, z;
    output s, c;
    
    assign s = x ^ y ^ z;
    assign c = (x & y) | (x & z) | (y & z);
endmodule
