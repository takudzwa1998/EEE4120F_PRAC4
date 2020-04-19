`timescale 1ns / 1ps

module WallClock(
    // inputs
    input CLK100MHZ,
    input[2:0] button,
    input [15:0] sw,
    //outputs
    output [7:0] SS_CAT,//SevenSegment
    output [3:0] SS_AN, //Segment Drivers
    output wire [5:0] LED
	
);

    integer hr_r=1;
    integer hr_l=2;
    integer min_r=3;
    integer min_l=4;
    
    integer inc =0;
    integer sec=0;
    wire count;
    
  
	//Initialize seven segment
	SS_Driver SS_Driver1(
		CLK100MHZ, sw,
		hr_r, hr_l, min_r, min_l, // Use temporary test values 00:00, (hr_r hr_l: min_r min_l)
		SS_AN, SS_CAT
	);
	

	Debounce Debounce1(CLK100MHZ, button[0], count);
	//The main logic
	
	always @(posedge CLK100MHZ) begin//posedge CLK100MHZ or
	   inc<=inc+1;
	    if(inc >=100000000) begin
	        sec <= sec + 1;//sec <= sec + 1;
	        if(sec == 59) begin
                   sec<=0; 
	           	   if (min_l == 9)begin
	                    min_l<=0;
	                    if (min_r == 5) begin
	                        min_r<=0;
	                        min_l<=0;
	                        if (hr_l == 3)begin
	                            if ( hr_r == 2)begin
	                                hr_r<=0;
	                                hr_l<=0;
                                end
	                            else begin
	                               hr_r<=hr_r+1;
	                            end
	                       end
	                       else begin
	                           hr_l<=hr_l+1;
	                       end
                        end
	               else begin
	                   min_r<=min_r+1;
	               end
	        end  else begin
	           min_l<=min_l+1;
	        end
        end
         inc  <= 0;
        end  
        end
	assign LED[5:0] = sec;
	
endmodule 