`timescale 1ns / 1ps



module fastDCT8(
    input clk,
    input signed [8:0]x0,x1,x2,x3,x4,x5,x6,x7, 
    output wire [8:0]y0,y1,y2,y3,y4,y5,y6,y7    
    );
    
    reg signed [9:0] v0,v1,v2,v3,v4,v5,v6,v7;           //Q9.0
    reg signed [10:0] v8,v9,v10,v11,v12,v14;            //Q10.0
    wire signed [10:0] v13temp;                         //Q10.0
    reg signed [11:0] v15,v16;                          //Q11.0
    wire signed [11:0] v17temp,v18temp;                 //Q11.0
    
    wire signed [26:0] v13_unrounded;                    //Q11.15
    reg signed [16:0] v13;                              //Q11.5
    
    wire signed [27:0] v17_unrounded, v18_unrounded;     //Q12.15
    reg signed [16:0] v17, v18;                         //Q12.4
    
    wire signed [26:0] v19temp_unrounded,v20temp_unrounded; //Q11.15
    wire signed [15:0] v19temp1,v20temp1;                   //Q11.4
    wire signed [17:0] v19temp2,v20temp2;                   //Q13.4
    reg signed [16:0] v19,v20;                           //Q13.3
    
    wire signed [17:0] v21_unrounded,v22_unrounded;      //Q13.4
    wire signed [14:0] v21_22temp;                       //10.4
    reg signed [16:0] v21,v22;                          //Q13.3
    
    wire signed [17:0] v23_unrounded,v24_unrounded;      //Q12.5
    wire signed [14:0] v23_24temp;                       //15.5
    reg signed [16:0] v23,v24;                          //Q12.4
    
    wire signed [18:0] v25_unrounded,v26_unrounded,v27_unrounded,v28_unrounded; //Q14.4
    wire signed [17:0] v25_28temp,v26_27temp;            //Q13.4
    reg signed [16:0] v25,v26,v27,v28;                  //Q14.2

    reg signed [27:0] y0_unrounded, y4_unrounded;       //Q12.15
    reg signed [32:0] y1_unrounded,y3_unrounded,y5_unrounded,y7_unrounded; //Q15.17
    reg signed [32:0] y2_unrounded, y6_unrounded;       //Q14.18
    reg signed [15:0] y0temp,y1temp,y2temp,y3temp,y4temp,y5temp,y6temp,y7temp; //Q15.0
    
    
    //constants ... Q1.15 fixed point
    reg signed [16:0] S0,S1,S2,S3,S4,S5,S6,S7;
    reg signed [16:0] A1,A2,A3,A4,A5;
    initial begin
       S0 = 17'h2D41; //0.353553390593273762200422,
	   S1 = 17'h20A0; //0.254897789552079584470970,
	   S2 = 17'h022A2; //0.270598050073098492199862,
	   S3 = 17'h267C; //0.300672443467522640271861,
	   S4 = 17'h2D41; //0.353553390593273762200422,
	   S5 = 17'h3999; //0.449988111568207852319255,
	   S6 = 17'h539E; //0.653281482438188263928322,
	   S7 = 17'hA406; //1.281457723870753089398043,
	  
	   A1 = 17'h5A82; //0.707106781186547524400844,
	   A2 = 17'h4545; //0.541196100146196984399723,
       A3 = 17'h5A82; //0.707106781186547524400844,
	   A4 = 17'hA73D; //1.306562964876376527856643,
	   A5 = 17'h30FC; //0.382683432365089771728460,
    end
    
    //============== stage 1=================//
    always @ (posedge clk) begin
        v0 <= x0+x7; //Q8.0 + Q8.0 = Q9.0
        v1 <= x1+x6; //Q8.0 + Q8.0 = Q9.0
        v2 <= x2+x5; //Q8.0 + Q8.0 = Q9.0
        v3 <= x3+x4; //Q8.0 + Q8.0 = Q9.0
        v4 <= x3-x4; //Q8.0 + Q8.0 = Q9.0
        v5 <= x2-x5; //Q8.0 + Q8.0 = Q9.0
        v6 <= x1-x6; //Q8.0 + Q8.0 = Q9.0
        v7 <= x0-x7; //Q8.0 + Q8.0 = Q9.0
    end
    
    //============== stage 2=================//    
    assign v13temp = v5 + v6; //Q9.0 + Q9.0 = Q10.0
    assign v13_unrounded = v13temp * A3; // Q10.0 * Q1.15 = Q11.15
    always @ (posedge clk) begin
        v8 <= v0+v3; // Q9.0 + Q9.0 = Q10.0
        v9 <= v1+v2; // Q9.0 + Q9.0 = Q10.0
        v10 <= v1-v2; // Q9.0 + Q9.0 = Q10.0
        v11 <= v0-v3; // Q9.0 + Q9.0 = Q10.0
        v12 <= -v4-v5; // Q9.0 + Q9.0 = Q10.0    
       
        v13 <= {v13_unrounded[26:10]}; //Q11.5
       
        v14 <= v6+v7; // Q9.0 + Q9.0 = Q10.0
    end 
    
    //============== stage 3=================//  
    assign v17temp = v10+v11; // Q10.0 + Q10.0 = Q11.0
    assign v17_unrounded = v17temp*A1; //Q11.0 * Q1.15 = Q12.15
    assign v18temp = v12+v14; // Q10.0 + Q10.0 = Q11.0
    assign v18_unrounded = v18temp*A5; //Q11.0 * Q1.15 = Q12.15
    
    always @ (posedge clk) begin
        v15 <= v8+v9; // Q10.0 + Q10.0 = Q11.0
        v16 <= v8-v9; // Q10.0 + Q10.0 = Q11.0
        v17 <= {v17_unrounded[27:11]}; //Q12.4   
        v18 <= {v18_unrounded[27:11]}; //Q12.4
    end
    
    //============== stage 4=================//
    assign v19temp_unrounded = v12 * A2; //Q10.0 * Q1.15 = Q 11.15
    assign v19temp1 = {v19temp_unrounded[26:11]}; //Q11.4
    assign v19temp2 = -v19temp1 - v18; // Q11.4 + Q12.4 = Q13.4
    
    assign v20temp_unrounded =  v14 * A4; //Q10.0 * Q1.15 = Q 11.15
    assign v20temp1 = {v20temp_unrounded[26:11]}; //Q11.4
    assign v20temp2 = v20temp1 - v18; // Q11.4 + Q12.4 = Q13.4
    
    always @ (posedge clk) begin
        
        v19 <= {v19temp2[17:1]}; //Q13.3
        
        v20 <= {v20temp2[17:1]}; //Q13.3
    end 
    
    //============== stage 5=================//
    assign v21_22temp = {v11,4'b0000}; //Q10.0 -> Q10.4
        
    assign v21_unrounded = v21_22temp+v17; //Q10.4 + Q12.4 = Q13.4 
    assign v22_unrounded = v21_22temp-v17; //Q10.4 + Q12.4 = Q13.4   
    
    assign v23_24temp = {v7,5'b00000}; //Q9.0 -> Q9.5    
    assign v23_unrounded = v23_24temp+v13; //Q9.5 + Q11.5 = Q12.5         
    assign v24_unrounded = v23_24temp-v13; //9.5 + Q11.5 = Q12.5
    
    always @ (posedge clk) begin
        v21 <= {v21_unrounded[17:1]}; //Q13.3
        
        v22 <= {v22_unrounded[17:1]}; //Q13.3
        
        v23 <= {v23_unrounded[17:1]}; //Q12.4

        v24 <= {v24_unrounded[17:1]}; //Q12.4
    end
    
    //============== stage 6=================// 
    assign v25_28temp = {v19,1'b0}; //Q13.4
        
    assign v25_unrounded = v24+v25_28temp; //Q12.4 + Q13.3 = Q14.4
    assign v28_unrounded = v24-v25_28temp; //Q12.4 + Q13.3 = Q14.4
     
    assign v26_27temp = {v20,1'b0}; //Q13.3 -> Q13.4
        
    assign v26_unrounded = v23+v26_27temp; //Q12.4 + Q13.3 = Q14.4
    assign v27_unrounded = v23-v26_27temp; //Q12.4 + Q13.3 = Q14.4
    
    always @ (posedge clk) begin
        v25 <= {v25_unrounded[18:2]}; //Q14.2

        v28 <= {v28_unrounded[18:2]}; //Q14.2
        
        v26 <= {v26_unrounded[18:2]}; //Q14.2
         
        v27 <= {v27_unrounded[18:2]}; //Q14.2
    end
    
    //============== stage 7=================// 
    always @ (posedge clk) begin
        y0_unrounded <= S0 * v15; //Q1.15 * Q11.0 = Q12.15
        y0temp <= {y0_unrounded[27],y0_unrounded[27],y0_unrounded[27],y0_unrounded[27:15]}; //Q15.0
              
        y1_unrounded = S1 * v26; //Q1.15 * Q14.2 = Q15.17 
        y1temp <= {y1_unrounded[32:17]}; //Q15.0
        
        y2_unrounded <= S2 * v21; //Q1.15 * Q13.3 = Q14.18
        y2temp <= {y2_unrounded[32],y2_unrounded[32:18]}; //Q15.0
        
        y3_unrounded <= S3 * v28; //Q1.15 * Q14.2 = Q15.17
        y3temp <= {y3_unrounded[32:17]}; //Q15.0
        
        y4_unrounded <= S4 * v16; //Q1.15 * Q11.0 = Q12.15
        y4temp <= {y4_unrounded[27],y4_unrounded[27],y4_unrounded[27],y4_unrounded[27:15]};  //Q15.0
        
        y5_unrounded <= S5 * v25; //Q1.15 * Q14.2 = Q15.17
        y5temp <= {y5_unrounded[32:17]}; //Q15.0
        
        y6_unrounded <= S6 * v22; //Q1.15 * Q13.3 = Q14.18
        y6temp <= {y6_unrounded[32],y6_unrounded[32:18]}; //Q15.0
        
        y7_unrounded <= S7 * v27; //Q1.15 * Q14.2 = Q15.17
        y7temp <= {y7_unrounded[32:17]}; //15.0
    end
   
    saturationUnit op0 (y0temp,y0);
    saturationUnit op1 (y1temp,y1);
    saturationUnit op2 (y2temp,y2);
    saturationUnit op3 (y3temp,y3);
    saturationUnit op4 (y4temp,y4);
    saturationUnit op5 (y5temp,y5);
    saturationUnit op6 (y6temp,y6);
    saturationUnit op7 (y7temp,y7);
    
    
    
endmodule


// Final Saturation round:
// Saturate Q12.0 to Q10.0.  Range for Q10.0 is -1024 to 1023.
// if (y < -1024) y = -1024;
// if (y > 1023 ) y =  1023;

//shift_and_round(x, n_bits)  return x + (1 << (n_bits-1))>>n_bits
//(1 << (n_bits-1)) is basically 0.5



module saturationUnit(
    input signed [15:0] x,
    output reg [8:0] y
    );
    always @ * begin
        //Saturating Q12.0 to Q8.0
        if( x < -256 ) begin
            y <= -256; 
        end   
        else if ( x > 255 ) begin
            y <= 255; 
        end
        else begin
            y <= {x[8:0]};
        end
    end
endmodule
