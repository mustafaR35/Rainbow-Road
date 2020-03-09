`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 04:19:54 PM
// Design Name: 
// Module Name: countUD4L
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


module countUD4L(
        input clk,
        input Up, //count enable (increment)
        input Dw, //not count enable (decrement)
        input LD,
        input [3:0] Din,
        output [3:0] Q,
        output UTC,
        output DTC
    );
    wire [3:0] D;
    wire upen, dwen;

    assign upen = Up & ~Dw;
    assign dwen = Dw & ~Up;
    assign D[0] = (LD & Din[0]) |
    (~LD & ( Up & ~Dw & (upen ^ Q[0]) | Dw & ~Up & (dwen ^ Q[0])));
    assign D[1] = (LD & Din[1]) | (~LD & (Up & ~Dw & (upen &Q[0] ^ Q[1]) | Dw & ~Up & (dwen & ~Q[0] ^ Q[1])) );
    assign D[2] = (LD & Din[2]) | (~LD & (Up & ~Dw & (Q[2] ^ (Q[1] & Q[0] & upen)) | Dw & ~Up & (Q[2] ^ (dwen & ~Q[1] & ~Q[0]))) );
    assign D[3] = (LD & Din[3]) | (~LD & (Up & ~Dw & (Q[3] ^ (Q[2] & Q[1] & Q[0] & upen)) | Dw & ~Up & (Q[3] ^ (dwen & ~Q[2] & ~Q[1] & ~Q[0]))) );
    
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(LD | upen | dwen), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(LD | upen | dwen), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(LD | upen | dwen), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(LD | upen | dwen), .D(D[3]), .Q(Q[3]));
    assign UTC = (Q[0] & Q[1] & Q[2] & Q[3]);
    assign DTC = ~Q[0] & ~Q[1] & ~Q[2] & ~Q[3];

endmodule
