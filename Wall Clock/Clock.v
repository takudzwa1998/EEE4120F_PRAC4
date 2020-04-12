`timescale 1ns / 1ps

module WallClock(
    // inputs
    input CLK100MHZ,
    input[2:0] button,
    //outputs
    output [7:0] SS_CAT,//SevenSegment
    output [3:0] SS_AN, //Segment Drivers
    output wire [5:0] LED
	
);
    integer hr_r=0;
    integer hr_l=0;
    integer min_r=0;
    integer min_l=0;
    integer inc =0;
    integer button0, button1, button2;
    integer sec=0;
    

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
	    if(inc >=100000000) begin
	        sec <= sec + 1;
	        if(sec == 59) begin
	            min_l<=min_l+1; 
	            sec<=0;
	        end
	     inc  <= 0; 
	   end
	end
	 assign LED[5:0] = sec;
	
endmodule  