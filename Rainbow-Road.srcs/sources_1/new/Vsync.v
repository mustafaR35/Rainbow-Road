`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2020 01:59:21 PM
// Design Name: 
// Module Name: Vsync
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


module Vcounter(
        input clk,
        input CE,
        input R,
        output [15:0] Q,
        output Vsync
    );
    
    wire utc1, utc2, utc3, dummy;
    
    Count_4b i0 (.clk(clk), .CE(CE), .R(R), .Q(Q[3:0]), .UTC(utc1));
    Count_4b i1 (.clk(clk), .CE(CE & utc1), .R(R), .Q(Q[7:4]), .UTC(utc2));
    Count_4b i2 (.clk(clk), .CE(CE & utc1 & utc2), .R(R), .Q(Q[11:8]), .UTC(utc3));
    Count_4b i3 (.clk(clk), .CE(CE & utc1 & utc2 & utc3), .R(R), .Q(Q[15:12]), .UTC(dummy));
    
    assign Vsync = (Q[15:0] < 16'd489) | (Q[15:0] > 16'd490);
        
endmodule
