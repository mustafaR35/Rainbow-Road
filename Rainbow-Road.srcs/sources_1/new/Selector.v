`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2020 11:47:25 PM
// Design Name: 
// Module Name: Selector
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


module Selector(
        input [3:0] sel,
        input [15:0] N,
        output [3:0] H
    );
    
    assign H[3:0] = (N[15:12] & {4{sel[3]}}) | (N[11:8] & {4{sel[2]}}) | (N[7:4] & {4{sel[1]}}) | (N[3:0] & {4{sel[0]}});

endmodule
