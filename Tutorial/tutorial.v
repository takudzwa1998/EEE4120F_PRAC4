module project_1(
    //input	CLK100MHZ,
    //input[1:0] sw,
    //output reg [1:0] LED,
    input[1:0] BTN,
    output [7:0] SS_CAT,
    output [7:0] SS_AN
    ); 
    // hey tk, ok cool so is this all of it? mm hmm  
    //assign SS_CAT= BTN[0];
   // assign SS_CAT= 8'b1101101;
    //assign SS_CAT= 8'b1011011;
    assign SS_CAT= 8'b0100100;
    
    assign SS_AN=  8'b0000000;
    /*
    always @(posedge CLK100MHZ) begin
        //LED[0] <= sw[0];
        //LED[1] <= !sw[1];
    end
    
    always @(BTN) begin
        //LED[0] <= sw[0];
        LED[0] <= BTN[0];
        LED[1] <= BTN[1];
    end
    */
    
endmodule