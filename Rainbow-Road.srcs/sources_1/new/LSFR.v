`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 01:29:34 AM
// Design Name: 
// Module Name: LSFR
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


module LFSR(
        input clk,
        output [7:0] Q
    );
    
    wire rand;
    
    assign rand = Q[0] ^ Q[5] ^ Q[6] ^ Q[7];
    
    FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .D(rand), .Q(Q[0])); //xor some bits for 1st bit
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(Q[0]), .Q(Q[1])); //shift rand val down
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(1'b1), .D(Q[1]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(1'b1), .D(Q[2]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) Q4_FF (.C(clk), .CE(1'b1), .D(Q[3]), .Q(Q[4]));
    FDRE #(.INIT(1'b0)) Q5_FF (.C(clk), .CE(1'b1), .D(Q[4]), .Q(Q[5]));
    FDRE #(.INIT(1'b0)) Q6_FF (.C(clk), .CE(1'b1), .D(Q[5]), .Q(Q[6]));
    FDRE #(.INIT(1'b0)) Q7_FF (.C(clk), .CE(1'b1), .D(Q[6]), .Q(Q[7]));
    
endmodule
