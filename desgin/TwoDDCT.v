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
  input signed [63:0][8:0] x,
  input IN_START,   //ready for new input
  output reg signed [63:0][26:0]y,
  output reg OUT_XFC  //output ready to send

);

reg [4:0] STATE;
reg [63:0][8:0] trans_temp;
reg [7:0][17:0] DCT_out;
reg [7:0][26:0] DCT_out2;
 
reg [7:0][8:0] dct_in;
reg [7:0][17:0] dct_in2;

assign dct_in = x[((STATE-1)*8)+:8];
assign dct_in2 = trans_temp[((STATE-9))*8+:8];

always @(posedge clock)
begin
    if (reset)
    begin
        STATE = 0;
        OUT_XFC = 0;
    end
    else if ((IN_START) && (STATE == 0))
    begin
        STATE = STATE+1;
        OUT_XFC = 0;
    end
    else if ((STATE > 0) && (STATE < 9))
    begin    
        trans_temp[(STATE-1)+(8*0)] <= DCT_out[0];
        trans_temp[(STATE-1)+(8*1)] <= DCT_out[1];
        trans_temp[(STATE-1)+(8*2)] <= DCT_out[2];
        trans_temp[(STATE-1)+(8*3)] <= DCT_out[3];
        trans_temp[(STATE-1)+(8*4)] <= DCT_out[4];
        trans_temp[(STATE-1)+(8*5)] <= DCT_out[5];
        trans_temp[(STATE-1)+(8*6)] <= DCT_out[6];
        trans_temp[(STATE-1)+(8*7)] <= DCT_out[7];
        STATE <= STATE + 1;
    end
    else if ((STATE > 8) && (STATE < 17))
    begin
        y[(STATE-9)+(8*0)]<= DCT_out2[0];
        y[(STATE-9)+(8*1)]<= DCT_out2[1];
        y[(STATE-9)+(8*2)]<= DCT_out2[2];
        y[(STATE-9)+(8*3)]<= DCT_out2[3];
        y[(STATE-9)+(8*4)]<= DCT_out2[4];
        y[(STATE-9)+(8*5)]<= DCT_out2[5];
        y[(STATE-9)+(8*6)]<= DCT_out2[6];
        y[(STATE-9)+(8*7)]<= DCT_out2[7];
        STATE <= STATE + 1;
    end
    else if (STATE == 17)
    begin
        OUT_XFC = 1;
        STATE = 0;
    end       
end

fastDCT8 #(.N(8)) dct1(.x(dct_in), .y(DCT_out));
fastDCT8 #(.N(17)) dct2(.x(dct_in2),.y(DCT_out2));



/*
initial
begin
#205$display("the original matrix");
$display("%b\t %b\t %b\t %b\t %b\t %b\t %b\t %b\t",temp[0][0],temp[0][1],temp[0][2],temp[0][3],temp[0][4],temp[0][5],temp[0][6],temp[0][7]);
$display("%b\t %b\t %b\t %b\t %b\t %b\t %b\t %b\t",temp[1][0],temp[1][1],temp[1][2],temp[1][3],temp[1][4],temp[1][5],temp[1][6],temp[1][7]);
$display("the transposed matrix");
$display("%b\t %b\t %b\t %b\t %b\t %b\t %b\t %b\t",trans_temp[0][0],trans_temp[1][0],trans_temp[2][0],trans_temp[3][0],trans_temp[4][0],trans_temp[5][0],trans_temp[6][0],trans_temp[7][0]);
$display("%b\t %b\t %b\t %b\t %b\t %b\t %b\t %b\t",trans_temp[0][1],trans_temp[1][1],trans_temp[2][1],trans_temp[3][1],trans_temp[4][1],trans_temp[5][1],trans_temp[6][1],trans_temp[7][1]);
end
*/
endmodule
