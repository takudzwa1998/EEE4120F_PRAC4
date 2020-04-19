module Debounce(
    input clk,
    input wire button,
    output reg state 
     //output reg output 
);
reg counter_one;
reg counter_two;
reg [21:0]Count; //assume count is null on FPGA configuration
//--------------------------------------------
always @(posedge clk) begin
    // implement your logic here
    // button for minutes, hours and reset	 
	   // code
  counter_one<=button;
  end
  always @(posedge clk)begin
  counter_two<=counter_one;
  end
  
  always @(posedge clk)begin
    if (state == counter_two)begin
        Count<=0;
    end
    else begin
        Count<=Count+1;
        if (Count == 3000000)begin
            state<=~state;
        end
    end
  
  end
endmodule

