`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2020 02:22:38 PM
// Design Name: 
// Module Name: m4_1
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


module m4_1 (
        input [3:0] in,
        input [1:0] sel,
        output o
    );
    
    assign o = (in[0] & (~sel[1] & ~sel[0])) | //when these two are 0, whole thing is 1 (thats our condition)
    (in[1] & (~sel[1] & sel[0])) | (in[2] & (sel[1] & ~sel[0])) | (in[3] & (sel[1] & sel[0]));
    
endmodule
