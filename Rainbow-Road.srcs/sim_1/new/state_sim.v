`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 08:47:52 PM
// Design Name: 
// Module Name: state_sim
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


module state_sim();
        reg clk; //frame
        reg start; //button C
        reg TwoSecs; //2 seconds passing
        reg lose; //out of bounds
        wire blink; //car blinks
        wire game_running; //game is still running (increment score and move LEDS)
        wire game_over; //game is over, flash score, LEDS OFF

state_machine UUT(
        .clk(clk),
        .start(start),
        .TwoSecs(TwoSecs),
        .lose(lose),
        .blink(blink),
        .game_running(game_running),
        .game_over(game_over)
);

    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;
    initial // Clock process for clkin
    begin
        #OFFSET
            clk = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = ~clk;
        end
    end  

    initial
    begin
    //current time is 0ns
    //-------------------- all 0 (IDLE)
    start = 1'b0;
    TwoSecs = 1'b0;
    lose = 1'b0;
    
    #1000; //current time is 1000ns
    //-------------------- all 0 (IDLE)
    start = 1'b0;
    TwoSecs = 1'b0;
    lose = 1'b0;
    
    #100; //current time is 1100ns
    //-------------------- start game (BTWICE)
    start = 1'b1;
    TwoSecs = 1'b0;
    lose = 1'b0;
    
    #100; //current time is 1200ns 
    //-------------------- not two seconds yet (BTWICE)
    start = 1'b0;
    TwoSecs = 1'b0;
    lose = 1'b0;
    
    #100; //current time is 1300ns
    //-------------------- blinked for 2 seconds (RUNNING)
    start = 1'b0;
    TwoSecs = 1'b1;
    lose = 1'b0;
    
    #100; //current time is 1400ns
    //-------------------- have not lost yet (RUNNING)
    start = 1'b0;
    TwoSecs = 1'b0;
    lose = 1'b0;
    
    #100; //current time is 1500ns
    //-------------------- out of bounds (POST)
    start = 1'b0;
    TwoSecs = 1'b0;
    lose = 1'b1;
    
    #100; //current time is 1600ns
    //-------------------- not started new game yet (POST)
    start = 1'b0;
    TwoSecs = 1'b0;
    lose = 1'b0;
    
    #100; //current time is 1700ns
    //-------------------- started new game (BTWICE)
    start = 1'b1; 
    TwoSecs = 1'b0;
    lose = 1'b0;
    
    #100; //current time is 1800ns
    end

endmodule
