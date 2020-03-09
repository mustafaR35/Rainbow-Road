`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 01:31:50 AM
// Design Name: 
// Module Name: Set_Random
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


module Set_Random(
        input clk,
        input CE,
        input [7:0] rand,
        output [15:0] set
    );
    
    //wire [15:0] set; //pos
    //wire [15:0] neg;
    //wire sign;
        
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(CE), .D(1'b0), .Q(set[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(CE), .D(1'b0), .Q(set[1]));
    FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(CE), .D(1'b0), .Q(set[2]));
    FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(CE), .D(rand[0]), .Q(set[3])); //4th bit 
    FDRE #(.INIT(1'b0)) Q4_FF (.C(clk), .CE(CE), .D(rand[1]), .Q(set[4])); //5th bit 
    FDRE #(.INIT(1'b0)) Q5_FF (.C(clk), .CE(CE), .D(rand[2]), .Q(set[5])); //6th bit 
    FDRE #(.INIT(1'b0)) Q6_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[6])); //sign bit
    FDRE #(.INIT(1'b0)) Q7_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[7]));
    FDRE #(.INIT(1'b0)) Q8_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[8]));
    FDRE #(.INIT(1'b0)) Q9_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[9]));
    FDRE #(.INIT(1'b0)) Q10_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[10]));
    FDRE #(.INIT(1'b0)) Q11_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[11]));
    FDRE #(.INIT(1'b0)) Q12_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[12])); 
    FDRE #(.INIT(1'b0)) Q13_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[13]));
    FDRE #(.INIT(1'b0)) Q14_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[14]));
    FDRE #(.INIT(1'b0)) Q15_FF (.C(clk), .CE(CE), .D(rand[3]), .Q(set[15]));   
    
    //twos_comp conv (.count(set[6:0]), .s(neg[6:0]));
    
    //assign set[15:7] = {9{1'b0}}; //sign extend positive
    //assign neg[15:7] = {9{1'b1}}; //sign extend negative
    
    //m2_1x16 choose (.in0(set[15:0]), .in1(neg[15:0]), .sel(set[6]), .o(final[15:0]));
    
endmodule
