`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2020 01:33:52 PM
// Design Name: 
// Module Name: top_level
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


module top_level(
// Inputs
   input btnC, //new game
   input btnD, //not used (only here for test sync)
   input btnU, //not used (only here for test sync)
   input btnL, //left
   input btnR, //right
   input [15:0] sw, //only using sw4, sw5, sw6
   input clkin,
// Outputs
   output [3:0] an,
   output dp, //not used (only here for test sync)
   output [6:0] seg,
   output [15:0] led,
   output Hsync,
   output [3:0] vgaBlue,
   output [3:0] vgaGreen,
   output [3:0] vgaRed,
   output Vsync
    );
    
    wire clk, digsel;
    wire [15:0] Hcount, Vcount;
    wire frame1, frame2; //high when one frame has passed 
    wire [15:0] frame16, frame64, frame128, scoreFlash, ledframe; //counts every 16 frames (quarter sec), 64 frames (1 sec), 128 frames (2 secs), score flash, led shift
    wire [3:0] rings; //output of ring counter
    wire [3:0] sel; //output of selector
    wire [15:0] bits; //input of selector to show on display
    wire [15:0] sec_count; //holds result of second counter (time counter for seconds)
    wire TwoSecs, lose, blink, game_start, game_running, game_over; //HAVE NOT ASSIGNED VALUES TO THESE YET      
     
    lab7_clks not_so_slow (.clkin(clkin), .greset(sw[0]), .clk(clk), .digsel(digsel));
    
    Edge_Detector f1 (.clk(clk), .btn(Vsync), .Eout(frame1)); //detects each frame
    Edge_Detector f2 (.clk(clk), .btn(~Vsync), .Eout(frame2)); //detects each frame (for counting twice per frame)
    
    Hcounter hc (.clk(clk), .CE(1'b1), .R(Hcount == 16'd799), .Q(Hcount), .Hsync(Hsync)); 
    Vcounter vc (.clk(clk), .CE(Hcount == 16'd799), .R(Vcount == 16'd524 & Hcount == 16'd799), .Q(Vcount), .Vsync(Vsync)); //goes to bottom right corner
    
    //===============================================STATE MACHINE=======================================================
    wire [3:0] debugStates;
    state_machine game (.clk(clk), .start(btnC), .TwoSecs(TwoSecs), .lose(lose), .blink(blink), .game_start(game_start), .game_running(game_running), .game_over(game_over)
                        ,.debugStates(debugStates));
                         
    // Debugging
    //assign led[3:0] = debugStates;
    //assign led[15:4] = 12'd0; 
    
    countUD16L f64 (.clk(clk), .Up(frame1), .Dw(1'b0), .LD ((frame64[15:0] == 16'd64) | game_start), .Din(16'b0), .Q(frame64[15:0])); //64 frame counter
    Time_Counter ts (.clk(clk), .CE( (frame64[15:0] == 16'd64) & blink), .R(game_start), .Q(sec_count[15:0])); //second counter
    
    assign TwoSecs = (sec_count[15:0] == 16'd2); //determines if 2 secs has been passed
    
    //===============================================BLOCK STUFF=========================================================  
    wire [15:0] red_X, red_Y, orange_X, orange_Y, yellow_X, yellow_Y, green_X, green_Y, blue_X, blue_Y, indigo_X, indigo_Y, violet_X, violet_Y; //coordinate       
    wire [3:0] red1, red2, red3, red4, red5, red6, red7, car_red;
    wire [3:0] green1, green2, green3, green4, green5, green6, green7, car_green;
    wire [3:0] blue1, blue2, blue3, blue4, blue5, blue6, blue7, car_blue;     
    wire [7:0] rand;
    wire [15:0] R_offset, O_offset, Y_offset, G_offset, B_offset, I_offset, V_offset;
    wire [15:0] i, width; 
    wire [15:0] R_spawn, O_spawn, Y_spawn, G_spawn, B_spawn, I_spawn, V_spawn;  
    //wire block_respawn;
    wire [15:0] carX; 
    wire flash; //controls car blink
    assign i[2] = sw[6];
    assign i[1] = sw[5];
    assign i[0] = sw[4];
    assign width = 16'd8 + 16'd16 * i;
    wire in_left, in_right;
    assign inleft = (red_X - width/16'd2 > 16'd0) & (orange_X - width/16'd2 > 16'd0) & (yellow_X - width/16'd2 > 16'd0) & (green_X - width/16'd2 > 16'd0) & (blue_X - width/16'd2 > 16'd0) & (indigo_X - width/16'd2 > 16'd0) & (violet_X - width/16'd2 > 16'd0);
    assign inright = (red_X + width/16'd2 < 16'd639) & (orange_X + width/16'd2 < 16'd639) & (yellow_X + width/16'd2 < 16'd639) & (green_X + width/16'd2 < 16'd639) & (blue_X + width/16'd2 < 16'd639) & (indigo_X + width/16'd2 < 16'd639) & (violet_X + width/16'd2 < 16'd639);
    
    LFSR random (.clk(clk), .Q(rand[7:0]));  
    //assign block_respawn = (red_Y == 16'd559) | (orange_Y == 16'd559) | (yellow_Y == 16'd559) | (green_Y == 16'd559) | (blue_Y == 16'd559) | (indigo_Y == 16'd559) | (violet_Y == 16'd559);
    //Set_Random sr(.clk(clk), .CE(block_respawn), .rand(rand[7:0]), .set(offset[15:0]));
    
    //==========RED==========
    //Ycounter yc (.clk(clk), .CE(frame1 | frame2), .R(Ycount == 12'd559), .Q(Ycount)); //Y coordinate counter
    countUD16L redY (.clk(clk), .Up( (frame1 | frame2) & game_running ), .Dw(1'b0), .LD(red_Y == 16'd560 | game_start), .Din(game_start ? 16'd0 : 16'd0), .Q(red_Y), .UTC(), .DTC());//Y coordinate counter
    Set_Random srr(.clk(clk), .CE(red_Y == 16'd480), .rand(rand[7:0]), .set(R_offset[15:0])); //gets offset amount
    assign R_spawn = ( (orange_X + R_offset > width/16'd2) && (orange_X + R_offset + width/16'd2 < 16'd639)) ? orange_X  + R_offset : orange_X; //determines new spawn point (doesn't let go past screen)
    countUD16L redX (.clk(clk), .Up( btnR & ~btnL & inright & (frame1 | frame2) & game_running ), .Dw( btnL & ~btnR & inleft & (frame1 | frame2)  & game_running ), .LD(game_start | violet_Y == 16'd480), 
                    .Din(game_start ? 16'd320 : R_spawn), .Q(red_X), .UTC(), .DTC());//X coordinate counter    
    block redblock (.inRed(4'hf), .inGreen(4'h0), .inBlue(4'h0), .x(Hcount), .xMin(red_X - width/16'd2), .xMax(red_X + width/16'd2),   
                .y(Vcount), .yMin( (red_Y - 16'd81) & {16{(red_Y >= 16'd81)}} ), .yMax(red_Y), .outRed(red1), .outGreen(green1), .outBlue(blue1) ); 
                
    //==========ORANGE==========            
    countUD16L orangeY (.clk(clk), .Up( (frame1 | frame2) & game_running ), .Dw(1'b0), .LD(orange_Y == 16'd560 | game_start), .Din(game_start ? 16'd80 : 16'd0), .Q(orange_Y), .UTC(), .DTC());//Y coordinate counter
    Set_Random sro(.clk(clk), .CE(orange_Y == 16'd480), .rand(rand[7:0]), .set(O_offset[15:0])); //gets offset amount
    assign O_spawn = ( (yellow_X + O_offset > width/16'd2) && (yellow_X + O_offset + width/16'd2 < 16'd639)) ? yellow_X  + O_offset : yellow_X; //determines new spawn point (doesn't let go past screen)
    countUD16L orangeX (.clk(clk), .Up( btnR & ~btnL & inright & (frame1 | frame2) & game_running ), .Dw( btnL & ~btnR & inleft & (frame1 | frame2)  & game_running ), .LD(game_start | red_Y == 16'd480), 
                        .Din(game_start ? 16'd320 : O_spawn), .Q(orange_X), .UTC(), .DTC());//X coordinate counter   
    block orangeblock (.inRed(4'hf), .inGreen(4'h7), .inBlue(4'h0), .x(Hcount), .xMin(orange_X - width/16'd2), .xMax(orange_X + width/16'd2), 
                .y(Vcount), .yMin( (orange_Y - 16'd81) & {16{(orange_Y >= 16'd81)}} ), .yMax(orange_Y), .outRed(red2), .outGreen(green2), .outBlue(blue2) );     
                           
    //==========YELLOW==========            
    countUD16L yellowY (.clk(clk), .Up( (frame1 | frame2) & game_running ), .Dw(1'b0), .LD(yellow_Y == 16'd560 | game_start), .Din(game_start ? 16'd160 : 16'd0), .Q(yellow_Y), .UTC(), .DTC());//Y coordinate counter
    Set_Random sry(.clk(clk), .CE(yellow_Y == 16'd480), .rand(rand[7:0]), .set(Y_offset[15:0]));  //gets offset amount
    assign Y_spawn = ( (green_X + O_offset > width/16'd2) && (green_X + Y_offset + width/16'd2 < 16'd639)) ? green_X  + Y_offset : green_X; //determines new spawn point (doesn't let go past screen)
    countUD16L yellowX (.clk(clk), .Up( btnR & ~btnL & inright & (frame1 | frame2) & game_running ), .Dw( btnL & ~btnR & inleft & (frame1 | frame2)  & game_running ), .LD(game_start | orange_Y == 16'd480), 
                        .Din(game_start ? 16'd320 : Y_spawn), .Q(yellow_X), .UTC(), .DTC());//X coordinate counter     
    block yellowblock (.inRed(4'hf), .inGreen(4'hf), .inBlue(4'h0), .x(Hcount), .xMin(yellow_X - width/16'd2), .xMax(yellow_X + width/16'd2), 
                .y(Vcount), .yMin( (yellow_Y - 16'd81) & {16{(yellow_Y >= 16'd81)}} ), .yMax(yellow_Y), .outRed(red3), .outGreen(green3), .outBlue(blue3) );      
                 
    //==========GREEN==========            
    countUD16L greenY (.clk(clk), .Up( (frame1 | frame2) & game_running ), .Dw(1'b0), .LD(green_Y == 16'd560 | game_start), .Din(game_start ? 16'd240 : 16'd0), .Q(green_Y), .UTC(), .DTC());//Y coordinate counter
    Set_Random srg(.clk(clk), .CE(green_Y == 16'd480), .rand(rand[7:0]), .set(G_offset[15:0])); //gets offset amount
    assign G_spawn = ( (blue_X + O_offset > width/16'd2) && (blue_X + G_offset + width/16'd2 < 16'd639)) ? blue_X  + G_offset : blue_X; //determines new spawn point (doesn't let go past screen)
    countUD16L greenX (.clk(clk), .Up( btnR & ~btnL & inright & (frame1 | frame2) & game_running ), .Dw( btnL & ~btnR & inleft & (frame1 | frame2)  & game_running ), .LD(game_start | yellow_Y == 16'd480), 
                        .Din(game_start ? 16'd320 : G_spawn), .Q(green_X), .UTC(), .DTC());//X coordinate counter     
    block greenblock (.inRed(4'h0), .inGreen(4'hf), .inBlue(4'h0), .x(Hcount), .xMin(green_X - width/16'd2), .xMax(green_X + width/16'd2), 
                .y(Vcount), .yMin( (green_Y - 16'd81) & {16{(green_Y >= 16'd81)}} ), .yMax(green_Y), .outRed(red4), .outGreen(green4), .outBlue(blue4) );  
                     
    //==========BLUE==========            
    countUD16L blueY (.clk(clk), .Up( (frame1 | frame2) & game_running ), .Dw(1'b0), .LD(blue_Y == 16'd560 | game_start), .Din(game_start ? 16'd320 : 16'd0), .Q(blue_Y), .UTC(), .DTC());//Y coordinate counter 
    Set_Random srb(.clk(clk), .CE(blue_Y == 16'd480), .rand(rand[7:0]), .set(B_offset[15:0]));  //gets offset amount
    assign B_spawn = ( (indigo_X + O_offset > width/16'd2) && (indigo_X + B_offset + width/16'd2 < 16'd639)) ? indigo_X  + B_offset : indigo_X; //determines new spawn point (doesn't let go past screen)
    countUD16L blueX (.clk(clk), .Up( btnR & ~btnL & inright & (frame1 | frame2) & game_running ), .Dw( btnL & ~btnR & inleft & (frame1 | frame2)  & game_running ), .LD(game_start | green_Y == 16'd480), 
                        .Din(game_start ? 16'd320 : B_spawn), .Q(blue_X), .UTC(), .DTC());//X coordinate counter     
    block blueblock (.inRed(4'h0), .inGreen(4'h0), .inBlue(4'hf), .x(Hcount), .xMin(blue_X - width/16'd2), .xMax(blue_X + width/16'd2), 
                .y(Vcount), .yMin( (blue_Y - 16'd81) & {16{(blue_Y >= 16'd81)}} ), .yMax(blue_Y), .outRed(red5), .outGreen(green5), .outBlue(blue5) );      
                 
    //==========INDIGO==========            
    countUD16L indigoY (.clk(clk), .Up( (frame1 | frame2) & game_running ), .Dw(1'b0), .LD(indigo_Y == 16'd560 | game_start), .Din(game_start ? 16'd400 : 16'd0), .Q(indigo_Y), .UTC(), .DTC());//Y coordinate counter 
    Set_Random sri(.clk(clk), .CE(indigo_Y == 16'd480), .rand(rand[7:0]), .set(I_offset[15:0]));  //gets offset amount
    assign I_spawn = ( (violet_X + O_offset > width/16'd2) && (violet_X + I_offset + width/16'd2 < 16'd639)) ? violet_X  + I_offset : violet_X; //determines new spawn point (doesn't let go past screen)
    countUD16L indigoX (.clk(clk), .Up( btnR & ~btnL & inright & (frame1 | frame2) & game_running ), .Dw( btnL & ~btnR & inleft & (frame1 | frame2)  & game_running ), .LD(game_start | blue_Y == 16'd480), 
                        .Din(game_start ? 16'd320 : I_spawn), .Q(indigo_X), .UTC(), .DTC());//X coordinate counter     
    block indigoblock (.inRed(4'h2), .inGreen(4'h2), .inBlue(4'h5), .x(Hcount), .xMin(indigo_X - width/16'd2), .xMax(indigo_X + width/16'd2), 
                .y(Vcount), .yMin( (indigo_Y - 16'd81) & {16{(indigo_Y >= 16'd81)}} ), .yMax(indigo_Y), .outRed(red6), .outGreen(green6), .outBlue(blue6) );   
                    
    //==========VIOLET==========             
    countUD16L violetY (.clk(clk), .Up( (frame1 | frame2) & game_running ), .Dw(1'b0), .LD(violet_Y == 16'd560 | game_start), .Din(game_start ? 16'd480 : 16'd0), .Q(violet_Y), .UTC(), .DTC());//Y coordinate counter
    Set_Random srv(.clk(clk), .CE(violet_Y == 16'd480), .rand(rand[7:0]), .set(V_offset[15:0]));  //gets offset amount
    assign V_spawn = ( (red_X + O_offset > width/16'd2) && (red_X + V_offset + width/16'd2 < 16'd639)) ? red_X  + V_offset : red_X; //determines new spawn point (doesn't let go past screen)
    countUD16L violetX (.clk(clk), .Up( btnR & ~btnL & inright & (frame1 | frame2)  & game_running ), .Dw( btnL & ~btnR & inleft & (frame1 | frame2)  & game_running ), .LD(game_start | indigo_Y == 16'd480), 
                        .Din(game_start ? 16'd320 : V_spawn), .Q(violet_X), .UTC(), .DTC());//X coordinate counter     
    block violetblock (.inRed(4'h8), .inGreen(4'h0), .inBlue(4'hf), .x(Hcount), .xMin(violet_X - width/16'd2), .xMax(violet_X + width/16'd2), 
                .y(Vcount), .yMin( (violet_Y - 16'd81) & {16{(violet_Y >= 16'd81)}} ), .yMax(violet_Y), .outRed(red7), .outGreen(green7), .outBlue(blue7) );                                                             
    
    //==========CAR==========            
    block car (.inRed(4'hf), .inGreen(4'hf), .inBlue(4'hf), .x(Hcount), .xMin(16'd312), .xMax(16'd328), 
                .y(Vcount), .yMin(16'd392), .yMax(16'd408), .outRed(car_red), .outGreen(car_green), .outBlue(car_blue) );              
                
    assign flash = ( (blink | game_over) & (frame64[15:0] < 16'd32) ) | (~blink & ~game_over); //controls car blink (blink every second  (on/off))           
               
    assign vgaRed[3] = red1[3] | red2[3] | red3[3] | red4[3] | red5[3] | red6[3] | red7[3] | (car_red[3] & flash);
    assign vgaRed[2] = red1[2] | red2[2] | red3[2] | red4[2] | red5[2] | red6[2] | red7[2] | (car_red[2] & flash);
    assign vgaRed[1] = red1[1] | red2[1] | red3[1] | red4[1] | red5[1] | red6[1] | red7[1] | (car_red[1] & flash);
    assign vgaRed[0] = red1[0] | red2[0] | red3[0] | red4[0] | red5[0] | red6[0] | red7[0] | (car_red[0] & flash);
    
    assign vgaGreen[3] = green1[3] | green2[3] | green3[3] | green4[3] | green5[3] | green6[3] | green7[3] | (car_green[3] & flash);
    assign vgaGreen[2] = green1[2] | green2[2] | green3[2] | green4[2] | green5[2] | green6[2] | green7[2] | (car_green[2] & flash);
    assign vgaGreen[1] = green1[1] | green2[1] | green3[1] | green4[1] | green5[1] | green6[1] | green7[1] | (car_green[1] & flash);
    assign vgaGreen[0] = green1[0] | green2[0] | green3[0] | green4[0] | green5[0] | green6[0] | green7[0] | (car_green[0] & flash);
    
    assign vgaBlue[3] = blue1[3] | blue2[3] | blue3[3] | blue4[3] | blue5[3] | blue6[3] | blue7[3] | (car_blue[3] & flash);
    assign vgaBlue[2] = blue1[2] | blue2[2] | blue3[2] | blue4[2] | blue5[2] | blue6[2] | blue7[2] | (car_blue[2] & flash); 
    assign vgaBlue[1] = blue1[1] | blue2[1] | blue3[1] | blue4[1] | blue5[1] | blue6[1] | blue7[1] | (car_blue[1] & flash);
    assign vgaBlue[0] = blue1[0] | blue2[0] | blue3[0] | blue4[0] | blue5[0] | blue6[0] | blue7[0] | (car_blue[0] & flash); 
     
    //==========OUT OF BOUNDS==========(checks if inside left, right, top, and bot bound)  
    wire [6:0] inside; //if inside road segments
    
    assign inside[0] = (red_X < 16'd328 + width/16'd2)      & (red_X + width/16'd2 > 16'd312)        &    (red_Y <    16'd488)    & (red_Y > 16'd392);    //red
    assign inside[1] = (orange_X < 16'd328 + width/16'd2)   & (orange_X + width/16'd2 > 16'd312)     &    (orange_Y < 16'd488) & (orange_Y > 16'd392); //orange
    assign inside[2] = (yellow_X < 16'd328 + width/16'd2)   & (yellow_X + width/16'd2 > 16'd312)     &    (yellow_Y < 16'd488) & (yellow_Y > 16'd392); //yellow
    assign inside[3] = (green_X < 16'd328 + width/16'd2)    & (green_X + width/16'd2 > 16'd312)      &    (green_Y <  16'd488)  & (green_Y > 16'd392);  //green
    assign inside[4] = (blue_X < 16'd328 + width/16'd2)     & (blue_X + width/16'd2 > 16'd312)       &    (blue_Y <   16'd488)   & (blue_Y > 16'd392);   //blue
    assign inside[5] = (indigo_X < 16'd328 + width/16'd2)   & (indigo_X + width/16'd2 > 16'd312)     &    (indigo_Y < 16'd488) & (indigo_Y > 16'd392); //indigo
    assign inside[6] = (violet_X < 16'd328 + width/16'd2)   & (violet_X + width/16'd2 > 16'd312)     &    (violet_Y < 16'd488) & (violet_Y > 16'd392); //violet
     
    assign lose =  ~( inside[0] | inside[1] | inside[2] | inside[3] | inside[4] | inside[5] | inside[6] ); //not (inside at least one block) 
     
    //===============================================BOARD DISPLAY STUFF=================================================
    
    //==========SCORE==========
    countUD16L f16 (.clk(clk), .Up(frame1 & game_running), .Dw(1'b0), .LD ((frame16[15:0] == 16'd16) | game_start), .Din(16'b0), .Q(frame16[15:0])); //16 frame counter
    //Time_Counter tc (.clk(clk), .CE(frame16[15:0] == 16'd16), .R(start_game), .Q(bits[15:0])); //game counter (counts every quarter second)
    countUD16L gc (.clk(clk), .Up(frame16[15:0] == 16'd16), .Dw(1'b0), .LD(game_start), .Din(16'b0), .Q(bits[15:0]) );
    
    RingCounter r4 (.clk(clk), .Advance(digsel), .Q(rings[3:0]));
    Selector s16 (.sel(rings[3:0]) , .N(bits[15:0]), .H(sel[3:0]));
    hex7seg seven (.n3(sel[3]), .n2(sel[2]), .n1(sel[1]), .n0(sel[0]), .a(seg[0]), .b(seg[1]), .c(seg[2]), .d(seg[3]),.e(seg[4]), .f(seg[5]), .g(seg[6]));
    
    countUD16L sf (.clk(clk), .Up(frame1 & game_over), .Dw(1'b0), .LD (scoreFlash[15:0] == 16'd64), .Din(16'b0), .Q(scoreFlash[15:0])); //64 frame counter for making score flash
    assign an[3] = ~(rings[3] & ( (game_over & (scoreFlash[15:0] < 16'd32)) | ~game_over) );
    assign an[2] = ~(rings[2] & ( (game_over & (scoreFlash[15:0] < 16'd32)) | ~game_over) );
    assign an[1] = ~(rings[1] & ( (game_over & (scoreFlash[15:0] < 16'd32)) | ~game_over) );
    assign an[0] = ~(rings[0] & ( (game_over & (scoreFlash[15:0] < 16'd32)) | ~game_over) );
    
    //==========LEDS==========
    countUD16L f128 (.clk(clk), .Up(frame1 & blink), .Dw(1'b0), .LD ((frame128[15:0] == 16'd128) | game_start), .Din(16'b0), .Q(frame128[15:0])); //64 frame counter for led countdown
    countUD16L ls64 (.clk(clk), .Up(frame1), .Dw(1'b0), .LD ((ledframe[15:0] == 16'd64) | game_start), .Din(16'b0), .Q(ledframe[15:0])); //64 frame counter for led shifter
    
    assign led[15] = (game_running & (ledframe[15:0] >= 16'd0) & (ledframe[15:0] <= 16'd16) ) | (blink & (frame128[15:0] > 16'd0));
    assign led[14] = (game_running & (ledframe[15:0] > 16'd16) & (ledframe[15:0] <= 16'd32) ); 
    assign led[13] = (game_running & (ledframe[15:0] > 16'd32) & (ledframe[15:0] <= 16'd48) );
    assign led[12] = (game_running & (ledframe[15:0] > 16'd48) & (ledframe[15:0] <= 16'd64) );
    assign led[11] = (game_running & (ledframe[15:0] >= 16'd0) & (ledframe[15:0] <= 16'd16) ) | (blink & (frame128[15:0] > 16'd32)); 
    assign led[10] = (game_running & (ledframe[15:0] > 16'd16) & (ledframe[15:0] <= 16'd32) );
    assign led[9] = (game_running & (ledframe[15:0] > 16'd32) & (ledframe[15:0] <= 16'd48) );
    assign led[8] = (game_running & (ledframe[15:0] > 16'd48) & (ledframe[15:0] <= 16'd64) );
    assign led[7] = (game_running & (ledframe[15:0] >= 16'd0) & (ledframe[15:0] <= 16'd16) ) | (blink & (frame128[15:0] > 16'd64));
    assign led[6] = (game_running & (ledframe[15:0] > 16'd16) & (ledframe[15:0] <= 16'd32) );
    assign led[5] = (game_running & (ledframe[15:0] > 16'd32) & (ledframe[15:0] <= 16'd48) );
    assign led[4] = (game_running & (ledframe[15:0] > 16'd48) & (ledframe[15:0] <= 16'd64) );
    assign led[3] = (game_running & (ledframe[15:0] >= 16'd0) & (ledframe[15:0] <= 16'd16) ) | (blink & (frame128[15:0] > 16'd96));
    assign led[2] = (game_running & (ledframe[15:0] > 16'd16) & (ledframe[15:0] <= 16'd32) );
    assign led[1] = (game_running & (ledframe[15:0] > 16'd32) & (ledframe[15:0] <= 16'd48) );
    assign led[0] = (game_running & (ledframe[15:0] > 16'd48) & (ledframe[15:0] <= 16'd64) );
    
endmodule
