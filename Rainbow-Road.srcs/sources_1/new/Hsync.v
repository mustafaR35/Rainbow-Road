`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2020 01:59:07 PM
// Design Name: 
// Module Name: Hsync
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


module Hcounter(
        input clk,
        input CE,
        input R,
        output [15:0] Q,
        output Hsync
    );
    
    wire utc1, utc2, utc3, dummy;

    Count_4b i0 (.clk(clk), .CE(CE), .R(R), .Q(Q[3:0]), .UTC(utc1));
    Count_4b i1 (.clk(clk), .CE(CE & utc1), .R(R), .Q(Q[7:4]), .UTC(utc2));
    Count_4b i2 (.clk(clk), .CE(CE & utc1 & utc2), .R(R), .Q(Q[11:8]), .UTC(dummy));
    Count_4b i3 (.clk(clk), .CE(CE & utc1 & utc2 & utc3), .R(R), .Q(Q[15:12]), .UTC(dummy));
    
    assign Hsync = (Q[15:0] < 16'd655) | (Q[15:0] > 16'd750);
        
endmodule
