`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 04:34:42 PM
// Design Name: 
// Module Name: Edge_Detector
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


module Edge_Detector(
        input clk,
        input btn,
        output Eout
    );
    
    wire [1:0] Q;
    
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(1'b1), .D(btn), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(Q[0]), .Q(Q[1])); //takes in output of last flip flop
    
    assign Eout = Q[0] & ~Q[1];

endmodule
