`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 12:15:09 AM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
        input clk, //frame
        input start, //button C
        input TwoSecs, //2 seconds passing
        input lose, //out of bounds
        output blink, //car blinks
        output game_start, //game has started (start of game)
        output game_running, //game is still running (increment score and move LEDS)
        output game_over, //game is over, flash score, LEDS OFF
        output [3:0] debugStates
    );
    
    wire IDLE, BTWICE, RUNNING, POST; //current state
    wire next_IDLE, next_BTWICE, next_RUNNING, next_POST; //next state
    
    assign next_IDLE = IDLE & ~start;
    assign next_BTWICE = IDLE & start | POST & start | BTWICE & ~TwoSecs;
    assign next_RUNNING = BTWICE & TwoSecs | RUNNING & ~lose;
    assign next_POST = RUNNING & lose | POST & ~start;
    
    FDRE #(.INIT(1'b1)) Q_0FF (.C(clk), .CE(1'b1), .D(next_IDLE), .Q(IDLE) );
    FDRE #(.INIT(1'b0)) Q_1FF (.C(clk), .CE(1'b1), .D(next_BTWICE), .Q(BTWICE) );
    FDRE #(.INIT(1'b0)) Q_2FF (.C(clk), .CE(1'b1), .D(next_RUNNING), .Q(RUNNING) );
    FDRE #(.INIT(1'b0)) Q_3FF (.C(clk), .CE(1'b1), .D(next_POST), .Q(POST) );
    
    assign blink = BTWICE & ~TwoSecs;
    assign game_start = IDLE | POST & start;
    assign game_running = RUNNING & ~lose;
    assign game_over = POST & ~start;  
    
    assign debugStates = {POST, RUNNING, BTWICE, IDLE};
    
endmodule
