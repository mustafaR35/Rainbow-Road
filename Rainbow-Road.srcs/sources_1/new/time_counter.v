`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 09:40:26 PM
// Design Name: 
// Module Name: time_counter
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


module Time_Counter(
        input clk,
        input CE, //count enable
        input R, //Reset
        output [15:0] Q
    );
    
    wire utc1, utc2, utc3, utc4;
    
    Count_4b i0 (.clk(clk), .CE(CE), .R(R), .Q(Q[3:0]), .UTC(utc1));
    Count_4b i1 (.clk(clk), .CE(utc1 & CE), .R(R), .Q(Q[7:4]), .UTC(utc2));
    Count_4b i2 (.clk(clk), .CE(utc1 & utc2 & CE), .R(R), .Q(Q[11:8]), .UTC(utc3));
    Count_4b i3 (.clk(clk), .CE(utc1 & utc2 & utc3 & CE), .R(R), .Q(Q[15:12]), .UTC(utc4));
    //utc for counters before current need to be 1 first
    
endmodule
