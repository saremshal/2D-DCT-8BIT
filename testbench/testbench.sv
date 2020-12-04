`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2020 10:50:13 AM
// Design Name: 
// Module Name: testbench
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


module testbench(

    );
    // Inputs
        reg clk;
        reg [17:0] y [7 :0];   //Q(8+9).0
        reg rst;

    // Outputs
        wire [31:0] given_in;
        wire [31:0] trans_out;

    // Instantiate the Unit Under Test (UUT)
        Transpose uut (
            .rst(rst),
            .clk(clk),
            .y(y),
            .given_in(given_in),
            .trans_out(trans_out)
        );
        initial begin
            clk = 0;
            rst = 1;
            y[0] = 0;
            y[1] = 0;
            y[2] = 0;
            y[3] = 0;
            y[4] = 0;
            y[5] = 0;
            y[6] = 0;
            y[7] = 0;
            
            #10;
            clk = 1;
            
            #20;
            rst = 0;
            
            while (1) 
            begin
            #5 clk = ~clk;  // toggle clk each 5 ns (100 MHz clock frequency)
            y[0] <= y[0] + 1;
            y[1] <= y[1] + 1;
            y[2] <= y[2] + 1;
            y[3] <= y[3] + 1;
            y[4] <= y[4] + 1;
            y[5] <= y[5] + 1;
            y[6] <= y[6] + 1;
            y[7] <= y[7] + 1;
            end
            end
         /*   #100;
            y[0] = 8'd12;
            y[1] = 8'd17;
            y[2] = 8'd25;
            y[3] = 8'd30;
            y[4] = 8'd45;
            y[5] = 8'd10;
            y[6] = 8'd5;
            y[7] = 8'd50;
            
            #100
            y[0] = 8'd21;
            y[1] = 8'd41;
            y[2] = 8'd52;
            y[3] = 8'd03;
            y[4] = 8'd54;
            y[5] = 8'd01;
            y[6] = 8'd50;
            y[7] = 8'd05;
            
            clk = 0;
            while (1) #5 clk = ~clk;  // toggle clk each 5 ns (100 MHz clock frequency)
            
        end    
        always @(posedge clk)
        begin
            
            
        // Wait 100 ns for global reset to finish
            #100;
            rst = 0;
            
            #100;
            y[0] = 8'd12;
            y[1] = 8'd17;
            y[2] = 8'd25;
            y[3] = 8'd30;
            y[4] = 8'd45;
            y[5] = 8'd10;
            y[6] = 8'd5;
            y[7] = 8'd50;
            
            #100
            y[0] = 8'd21;
            y[1] = 8'd41;
            y[2] = 8'd52;
            y[3] = 8'd03;
            y[4] = 8'd54;
            y[5] = 8'd01;
            y[6] = 8'd50;
            y[7] = 8'd05;
            
end  */         
        // Add stimulus here
endmodule

