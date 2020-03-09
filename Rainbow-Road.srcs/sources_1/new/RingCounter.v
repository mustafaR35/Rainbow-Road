`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2020 11:48:55 PM
// Design Name: 
// Module Name: RingCounter
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


module RingCounter(
        input clk,
        input Advance,
        output [3:0] Q     
    ); 
    
    
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(Advance), .D(Q[0]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(Advance), .D(Q[1]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(Advance), .D(Q[2]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(Advance), .D(Q[3]), .Q(Q[0])); 
    
endmodule
