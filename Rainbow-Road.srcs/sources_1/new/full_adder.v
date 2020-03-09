`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2020 02:19:47 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder (
        input a, 
        input b,
        input Cin,
        output Cout,
        output Sum
    );
    
    m4_1 sum (.in({Cin, ~Cin, ~Cin, Cin}), .sel({a, b}), .o(Sum));
    m4_1 carry (.in({1'b1, Cin, Cin, 1'b0}), .sel({a, b}),.o(Cout));
    
endmodule
