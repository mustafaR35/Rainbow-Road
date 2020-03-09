`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 04:22:29 PM
// Design Name: 
// Module Name: countUD16L
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


module countUD16L(
        input clk,
        input Up, //count enable (increment)
        input Dw, //not count enable (decrement)
        input LD,
        input [15:0] Din,
        output [15:0] Q,
        output UTC,
        output DTC
    );
    wire utc[3:0];
    wire dtc[3:0];

    countUD4L in0_1 (.clk(clk), .Up(Up & ~Dw), .Dw(Dw & ~Up), .LD(LD), .Din(Din[3:0]), .Q(Q[3:0]), .UTC(utc[0]), .DTC(dtc[0]));
    countUD4L in0_2 (.clk(clk), .Up(Up & ~Dw & utc[0]), .Dw(Dw & ~Up & dtc[0]), .LD(LD), .Din(Din[7:4]), .Q(Q[7:4]), .UTC(utc[1]), .DTC(dtc[1]));
    countUD4L in0_3 (.clk(clk), .Up(Up & ~Dw & utc[0] & utc[1]), .Dw(Dw & ~Up & dtc[0] & dtc[1]), .LD(LD), .Din(Din[11:8]), .Q(Q[11:8]), .UTC(utc[2]), .DTC(dtc[2]));
    countUD4L in0_4 (.clk(clk), .Up(Up & ~Dw & utc[0] & utc[1] & utc[2]), .Dw(Dw & ~Up & dtc[0] & dtc[1] & dtc[2]), .LD(LD), .Din(Din[15:12]), .Q(Q[15:12]), .UTC(utc[3]), .DTC(dtc[3]));
    assign UTC = utc[3] & utc[2] & utc[1] & utc[0];
    assign DTC = dtc[3] & dtc[2] & dtc[1] & dtc[0];
endmodule
