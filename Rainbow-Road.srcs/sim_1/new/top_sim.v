`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2020 03:06:11 PM
// Design Name: 
// Module Name: top_sim
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


module top_sim();
// Inputs
   reg btnC,btnD,btnU,btnL,btnR;
   reg [15:0] sw;
   reg clkin;

// Output
   wire [3:0] an;
   wire dp;
   wire [6:0] seg;
   wire [15:0] led;
   wire HS;
   wire [3:0] vgaBlue;
   wire [3:0] vgaGreen;
   wire [3:0] vgaRed;
   wire VS;

top_level UUT(
		.btnU(btnU), 
		.btnD(btnD), 
		.btnC(btnC),  
		.btnR(btnR),  
		.btnL(btnL),  
		.clkin(clkin), 
		.seg(seg), 
		.dp(dp), 
		.an(an),
		.vgaBlue(vgaBlue),
		.vgaRed(vgaRed),
		.vgaGreen(vgaGreen), 	
		.Vsync(VS), 
		.Hsync(HS), 
		.sw(sw), 
		.led(led)
);

    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;
    initial // Clock process for clkin
    begin
        #OFFSET
            clkin = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
        end
    end  

    initial
    begin
    //current time is 0ns
    //-------------------- all 0 (IDLE)
    btnC = 1'b0;
    btnR = 1'b0;
    btnL = 1'b0;
    sw = 16'd0;
    
    #1000; //current time is 1000ns
    //-------------------- all 0 (IDLE)
    btnC = 1'b0;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1100ns
    //-------------------- start game (BTWICE)
    btnC = 1'b1;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1200ns 
    //-------------------- not two seconds yet (BTWICE)
    btnC = 1'b0;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1300ns
    //-------------------- blinked for 2 seconds (RUNNING)
    btnC = 1'b0;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1400ns
    //-------------------- have not lost yet (RUNNING)
    btnC = 1'b0;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1500ns
    //-------------------- out of bounds (POST)
    btnC = 1'b0;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1600ns
    //-------------------- not started new game yet (POST)
    btnC = 1'b0;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1700ns
    //-------------------- started new game (BTWICE)
    btnC = 1'b1;
    btnR = 1'b0;
    btnL = 1'b0;
    
    #100; //current time is 1800ns
    end

endmodule
