module SS_Driver(
    input Clk, input [15:0] Reset,
    input [3:0] BCD3, BCD2, BCD1, BCD0, // Binary-coded decimal input
    output reg [3:0] SegmentDrivers, // Digit drivers (active low)
    output reg [7:0] SevenSegment // Segments (active low)//SevenSegment
);

// Make use of a subcircuit to decode the BCD to seven-segment (SS)
wire [6:0]SS[3:0];
BCD_Decoder BCD_Decoder0 (BCD0, SS[0]);
BCD_Decoder BCD_Decoder1 (BCD1, SS[1]);
BCD_Decoder BCD_Decoder2 (BCD2, SS[2]);
BCD_Decoder BCD_Decoder3 (BCD3, SS[3]);


// Counter to reduce the 100 MHz clock to 762.939 Hz (100 MHz / 2^17)
reg [16:0]Count;
reg state = 0;
integer high = 0;
integer clock = 0;
integer reset = 0;
integer pwm = 20;
integer val;
integer  brightness = 500000;
// Scroll through the digits, switching one on at a time
always @(posedge Clk) begin

  clock <= clock + 1;// Yoh
   high <= (1000000 / 100) * pwm;
   case (Reset)
    Reset[1] : brightness <= brightness;
    Reset[2] : brightness <= brightness + (31250*2);
    //significant change                   31250
    Reset[3] : brightness <= brightness + (31250*3);
    Reset[4] : brightness <= brightness + (31250*4);
    Reset[5] : brightness <= brightness + (31250*5);
    Reset[6] : brightness <= brightness + (31250*6);
    Reset[15] : brightness <= brightness + 400000;
   endcase
   if(clock < brightness
      && clock <1000000)begin
     state <= 0;
   end
   else if(clock >brightness
      && clock <1000000)begin
   state <= 1;
   end
   if(clock >1000000)begin
   clock <= 0;
   end
   
   reset <= state;
    
 Count <= Count + 1'b1;
 if ( Reset[0]) SegmentDrivers <= 4'hE;
 else if(&Count) SegmentDrivers <= {SegmentDrivers[2:0], SegmentDrivers[3]};
end

//------------------------------------------------------------------------------
always @(*) begin // This describes a purely combinational circuit
    val <= Reset[0];
    SevenSegment[7] <= 1'b1; // Decimal point always off
    if (val || reset) begin
        SevenSegment[6:0] <= 7'h7F; // All off during Reset
    end else begin
        case(~SegmentDrivers) // Connect the correct signals,
            4'h1 : SevenSegment[6:0] <= ~SS[0]; // depending on which digit is on at
            4'h2 : SevenSegment[6:0] <= ~SS[1]; // this point
            4'h4 : SevenSegment[6:0] <= ~SS[2];
            4'h8 : SevenSegment[6:0] <= ~SS[3];
            default: SevenSegment[6:0] <= 7'h7F;
        endcase
    end
end

endmodule
