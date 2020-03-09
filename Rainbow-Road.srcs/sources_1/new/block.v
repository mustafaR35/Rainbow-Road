`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 01:42:50 PM
// Design Name: 
// Module Name: block
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


module block(
        input [3:0] inRed,
        input [3:0] inGreen,
        input [3:0] inBlue,
        
        input [15:0] x, //bottom right
        input [15:0] xMin,
        input [15:0] xMax,
                
        input [15:0] y, //bottom right
        input [15:0] yMin,
        input [15:0] yMax,
        
        output [3:0] outRed,
        output [3:0] outGreen,
        output [3:0] outBlue
    );
     
    assign outRed = inRed & {4{(x > xMin & x < xMax) & (y > yMin & y < yMax)}};
    assign outGreen = inGreen & {4{(x > xMin & x < xMax) & (y > yMin & y < yMax)}};
    assign outBlue = inBlue & {4{(x > xMin & x < xMax) & (y > yMin & y < yMax)}};
    
endmodule
