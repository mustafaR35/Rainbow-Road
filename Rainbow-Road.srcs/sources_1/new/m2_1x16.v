`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2020 12:52:33 PM
// Design Name: 
// Module Name: m2_1x16
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


module m2_1x16 (
        input [15:0] in0,
        input [15:0] in1,
        input sel,
        output [15:0] o
    );
    assign o[0] = (in0[0] & ~sel) | (in1[0] & sel);
    assign o[1] = (in0[1] & ~sel) | (in1[1] & sel);
    assign o[2] = (in0[2] & ~sel) | (in1[2] & sel);
    assign o[3] = (in0[3] & ~sel) | (in1[3] & sel);
    assign o[4] = (in0[4] & ~sel) | (in1[4] & sel);
    assign o[5] = (in0[5] & ~sel) | (in1[5] & sel);
    assign o[6] = (in0[6] & ~sel) | (in1[6] & sel);
    assign o[7] = (in0[7] & ~sel) | (in1[7] & sel);
    assign o[8] = (in0[8] & ~sel) | (in1[8] & sel);
    assign o[9] = (in0[9] & ~sel) | (in1[9] & sel);
    assign o[10] = (in0[10] & ~sel) | (in1[10] & sel);
    assign o[11] = (in0[11] & ~sel) | (in1[11] & sel);
    assign o[12] = (in0[12] & ~sel) | (in1[12] & sel);
    assign o[13] = (in0[13] & ~sel) | (in1[13] & sel);
    assign o[14] = (in0[14] & ~sel) | (in1[14] & sel);
    assign o[15] = (in0[15] & ~sel) | (in1[15] & sel);

endmodule
