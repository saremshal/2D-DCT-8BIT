`timescale 1ns / 1ps


module hardwareDCT_v2_tb(
    );
     reg [8:0]x0,x1,x2,x3,x4,x5,x6,x7;
     wire [8:0]y0,y1,y2,y3,y4,y5,y6,y7;
     reg clock = 0;
     
     //instantiating simple cpu lab
     fastDCT8 uut (
        .clk(clock),
        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .x5(x5),
        .x6(x6),
        .x7(x7),
        .y0(y0),
        .y1(y1),
        .y2(y2),
        .y3(y3),
        .y4(y4),
        .y5(y5),
        .y6(y6),
        .y7(y7)
    );
    
    initial begin
         x0=13;
         x1=-8;
         x2=232;
         x3=58;
         x4=-56;
         x5=63;
         x6=32;
         x7=-18;
    end

     //making clock pulse every 1 time unit
     always begin
        #1 clock = !clock;
     end

    initial #14 $finish; // The test will run for a total interval of 50 nanoseconds

endmodule



