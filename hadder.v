`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2021 10:16:31 PM
// Design Name: 
// Module Name: hadder
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


module hadder(x, y, s, c);
    input x, y;
    output s, c;
    
    assign s = x ^ y;
    assign c = x & y;
endmodule
