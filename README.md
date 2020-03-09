# Rainbow-Road

This is a driving game ran on a Basys3 board and displayed on a monitor. The road is moved using button L and R. The game is started and restarted using button C. The goal is to remain on the Road for as long as possible, the player's final score is displayed at the end.

## Getting Started

  ### Built With
  
  - Verilog
  - Vivado
  - Basys3 Board

  ### Prereqiusites
  
  - Basys3 Board
  - Micro USB to USB A cable connecting Basys3 Board to  PC
  - Male to Male VGA cable connecting Basys3 Board to Monitor
  - Vivado 
  
  ### Running
  
  - download repository
  - open project by double clicking Rainbow-Road.xpr in Rainbow-Road folder
  - connect and turn on Basys3 Board
  - generate bitstream (may take a few minutes)
  - open target
  - click auto connect
  - click program device
  
  ### Playing the game
  - press button C to start the game
  - press button L and button R to move the road left and right
  - the goal is to stay on the road for as long as possible
  - each road segment will be generated randomly and the width of each road segment can be changed 
    using switch 4, 5, and 6 (sw4, sw5, sw6)
  - your score is displayed at the end of the game
  
