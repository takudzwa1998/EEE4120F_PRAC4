`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:30 05/30/2017 
// Design Name: 
// Module Name:    PWM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PWM(
    input clk,			//input clock
    input [7:0] pwm_in, 
    output reg pwm_out 	//output of PWM	
);
reg state = 0;
integer high = 0;
integer clock = 0;

always @(posedge clk) begin
   clock <= clock + 1;
   high <= (1000000 / 100) * pwm_in;

   if(clock <= high 
      && clock <=1000000)begin
     state <= 0;
   end
   else if(clock >=high 
      && clock <=1000000)begin
   state <= 1;
   end
   if(clock >=1000000)begin
   clock <= 0;
   end
   
    pwm_out = state;
    //Write your implementation here	
end
	

endmodule
