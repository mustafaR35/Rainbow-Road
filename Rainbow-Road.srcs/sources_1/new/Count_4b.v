`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2020 02:25:10 PM
// Design Name: 
// Module Name: Count_4b
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


module Count_4b(
        input clk,
        input CE, //count enable
        input R, //Reset
        output [3:0] Q,
        output UTC
    );
    
    wire [3:0] D;
    
    assign D[0] = ~Q[0];
    assign D[1] = (Q[1] ^ Q[0]) & CE;
    assign D[2] = (Q[2] ^ (Q[1] & Q[0])) & CE;
    assign D[3] = (Q[3] ^ (Q[2] & Q[1] & Q[0])) & CE;
    
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .R(R), .CE(CE), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .R(R), .CE(CE), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .R(R), .CE(CE), .D(D[2]), .Q(Q[2])); 
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .R(R), .CE(CE), .D(D[3]), .Q(Q[3]));
    
    assign UTC = Q[3] & Q[2] & Q[1] & Q[0];
    
endmodule
