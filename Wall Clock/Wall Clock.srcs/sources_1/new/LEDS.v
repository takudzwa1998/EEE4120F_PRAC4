`timescale 1ns / 1ps

module LEDS(
 input Clk,
 output reg [5:0] LED,
 input wire sec
    );
    integer sec_old, inc;
    always @(posedge Clk) begin
       if(inc >=100000000) begin
           sec_old<=sec;
           sec_old=sec_old+1;
	       inc<=0;
	       LED[5:0] = sec;
	   end
	end
endmodule
