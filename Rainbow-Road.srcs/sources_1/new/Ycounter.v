`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 05:24:02 PM
// Design Name: 
// Module Name: Ycounter
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


module Ycounter(
        input clk,
        input CE,
        input R,
        output [11:0] Q
    );
    
    wire utc1, utc2, dummy;

    Count_4b i0 (.clk(clk), .CE(CE), .R(R), .Q(Q[3:0]), .UTC(utc1));
    Count_4b i1 (.clk(clk), .CE(CE & utc1), .R(R), .Q(Q[7:4]), .UTC(utc2));
    Count_4b i2 (.clk(clk), .CE(CE & utc1 & utc2), .R(R), .Q(Q[11:8]), .UTC(dummy));
    
endmodule
