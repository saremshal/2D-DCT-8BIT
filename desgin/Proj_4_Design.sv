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


module Transpose(
 input rst,
 input clk,
 input [17:0] y [7 :0],   //Q(8+9).0
 //output  [31:0] given_in,
 //output  [31:0] trans_out
);

reg [4:0] STATE;
reg [3:0] transposer;

reg [17:0] temp [7:0][7:0];
reg [17:0] trans_temp [7:0][7:0];

always @(posedge clk)
begin
    if (rst)
    begin
        STATE = 0;
        transposer = 0;
        //rtr_internal = 1;
        //rts_internal = 0;
        //we can also set the arrays to be zero if we want, but its not needed.
    end
    else if (STATE == 0)
    begin
        STATE = STATE + 1;
        transposer = 0;
        //rtr_internal = 1;
        //rts_internal = 0;
    end
    else if ((STATE > 0) && (STATE < 9))
    begin    
        temp[STATE-1][0] = y[0];
        temp[STATE-1][1] = y[1];
        temp[STATE-1][2] = y[2];
        temp[STATE-1][3] = y[3];
        temp[STATE-1][4] = y[4];
        temp[STATE-1][5] = y[5];
        temp[STATE-1][6] = y[6];
        temp[STATE-1][7] = y[7];
    
        STATE = STATE + 1;
    end
    else if ((STATE > 8) && (STATE < 17))
    begin
        //rtr_internal = 0; //this actually will prob need its own "if"
        trans_temp[0][transposer] = temp[transposer][0];
        trans_temp[1][transposer] = temp[transposer][1];
        trans_temp[2][transposer] = temp[transposer][2];
        trans_temp[3][transposer] = temp[transposer][3];
        trans_temp[4][transposer] = temp[transposer][4];
        trans_temp[5][transposer] = temp[transposer][5];
        trans_temp[6][transposer] = temp[transposer][6];
        trans_temp[7][transposer] = temp[transposer][7]; 
        STATE = STATE + 1;
        transposer = transposer + 1;
    end
    else if (STATE == 17)
    begin
        //rts_internal = 1;
        STATE = 0;
    end       
end
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
