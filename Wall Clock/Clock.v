`timescale 1ns / 1ps

module WallClock(
    // inputs
    input CLK100MHZ,
    input[2:0] button,
    //outputs
    output [7:0] SS_CAT,//SevenSegment
    output [3:0] SS_AN //Segment Drivers
	
);
    integer hr_r=0;
    integer hr_l=0;
    integer min_r=0;
    integer min_l=0;
    integer inc =0;
    integer button0, button1, button2;
    integer inc2;
    

	//Add the t
	//Initialize seven segment
	SS_Driver SS_Driver1(
		CLK100MHZ, button[2],
		hr_r, hr_l, min_r, min_l, // Use temporary test values 00:00, (hr_r hr_l: min_r min_l)
		SS_AN, SS_CAT
	);
	
	//The main logic
	always @(posedge CLK100MHZ) begin
	
	   inc<=inc+1;
	   inc2<=inc2+1;
	   
	    if(inc2 >=1000000) begin
	      button0 <= button[0];
	      button1 <= button[1];
	      button2 <= button[2];  
	       inc2  <= 0; 
	   end
	   
	     if(button0)begin
	   min_r <= min_r + 1;
	   
	   end

	end
	
endmodule  