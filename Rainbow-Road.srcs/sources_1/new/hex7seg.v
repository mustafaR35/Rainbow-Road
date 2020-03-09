`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2020 11:48:13 PM
// Design Name: 
// Module Name: hex7seg
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


module hex7seg ( //from lab 2
        input n3,
        input n2,
        input n1,
        input n0,
        output a,
        output b,
        output c,
        output d,
        output e,
        output f,
        output g
    );
    assign a = (~n3 & ~n2 & ~n1 & n0) | (~n3 & n2 & ~n1 & ~n0) | (n3 & ~n2 & n1 & n0) | (n3 & n2 & ~n1 & n0);
    assign b = (~n3 & n2 & ~n1 & n0) | (~n3 & n2 & n1 & ~n0) | (n3 & ~n2 & n1 & n0) | (n3 & n2 & ~n1 & ~n0) | (n3 & n2 & n1 & ~n0) | (n3 & n2 & n1 & n0);
    assign c = (~n3 & ~n2 & n1 & ~n0) | (n3 & n2 & ~n1 & ~n0) | (n3 & n2 & n1 & ~n0) | (n3 & n2 & n1 & n0);
    assign d = (~n3 & ~n2 & ~n1 & n0) | (~n3 & n2 & ~n1 & ~n0) | (~n3 & n2 & n1 & n0) | (n3 & ~n2 & ~n1 & n0) | (n3 & ~n2 & n1 & ~n0) | (n3 & n2 & n1 & n0);
    assign e = (~n3 & ~n2 & ~n1 & n0) | (~n3 & ~n2 & n1 & n0) | (~n3 & n2 & ~n1 & ~n0) | (~n3 & n2 & ~n1 & n0) | (~n3 & n2 & n1 & n0) | (n3 & ~n2 & ~n1 & n0);
    assign f = (~n3 & ~n2 & ~n1 & n0) | (~n3 & ~n2 & n1 & ~n0) | (~n3 & ~n2 & n1 & n0) | (~n3 & n2 & n1 & n0) | (n3 & n2 & ~n1 & n0);
    assign g = (~n3 & ~n2 & ~n1 & ~n0) | (~n3 & ~n2 & ~n1 & n0) | (~n3 & n2 & n1 & n0) | (n3 & n2 & ~n1 & ~n0);

endmodule
