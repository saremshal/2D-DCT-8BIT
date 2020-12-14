`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2020 10:48:28 AM
// Design Name: 
// Module Name: Design
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


module TwoDDCT(
  input clock,
  input reset,
  input signed [63:0][10:0] x,          //System Input
  input IN_START,                       //ready for new input
  output reg signed [63:0][28:0]y,      //System Output
  output reg OUT_XFC                    //output ready to send

);

reg [4:0] STATE;                        //State Machine variable
reg [63:0][19:0] trans_temp;            //temporary reg for transposing (stores dct values)
reg [7:0][19:0] DCT_out;                //1st output for 1-D DCT
reg [7:0][28:0] DCT_out2;               //2nd output for 1-D DCT
 
reg [7:0][10:0] dct_in;                 //Input 1 from 1-D DCT
reg [7:0][19:0] dct_in2;                //Input 2 from 1-D DCT

assign dct_in = x[((STATE-1)*8)+:8];                //Assigning variables to dct input
assign dct_in2 = trans_temp[((STATE-9))*8+:8];

always @(posedge clock)
begin
    if (reset)                                      //reset state
    begin
        STATE = 0;
        OUT_XFC = 0;
    end
    else if ((IN_START) && (STATE == 0))            //idle state
    begin
        STATE = STATE+1;
        OUT_XFC = 0;
    end
    else if ((STATE > 0) && (STATE < 9))            //assigns trans temp variables 
    begin                                           //location of storage depends on STATE
        trans_temp[(STATE-1)+(8*0)] <= DCT_out[0];
        trans_temp[(STATE-1)+(8*1)] <= DCT_out[1];
        trans_temp[(STATE-1)+(8*2)] <= DCT_out[2];
        trans_temp[(STATE-1)+(8*3)] <= DCT_out[3];
        trans_temp[(STATE-1)+(8*4)] <= DCT_out[4];
        trans_temp[(STATE-1)+(8*5)] <= DCT_out[5];
        trans_temp[(STATE-1)+(8*6)] <= DCT_out[6];
        trans_temp[(STATE-1)+(8*7)] <= DCT_out[7];
        STATE <= STATE + 1;                         //increment STATE
    end
    else if ((STATE > 8) && (STATE < 17))           //assigns output variables
    begin
        y[(STATE-9)+(8*0)]<= DCT_out2[0];
        y[(STATE-9)+(8*1)]<= DCT_out2[1];
        y[(STATE-9)+(8*2)]<= DCT_out2[2];
        y[(STATE-9)+(8*3)]<= DCT_out2[3];
        y[(STATE-9)+(8*4)]<= DCT_out2[4];
        y[(STATE-9)+(8*5)]<= DCT_out2[5];
        y[(STATE-9)+(8*6)]<= DCT_out2[6];
        y[(STATE-9)+(8*7)]<= DCT_out2[7];
        STATE <= STATE + 1;                         //increment STATE
    end
    else if (STATE == 17)                           //reset back to idle state next cycle
    begin                                           //sets ready to send variable high, as output is completed in the previous cycle
        OUT_XFC = 1;
        STATE = 0;
    end       
end

fastDCT8 #(.N(10)) dct1(.x(dct_in), .y(DCT_out));   //calls 1-D DCT module
fastDCT8 #(.N(19)) dct2(.x(dct_in2),.y(DCT_out2));

endmodule
