`timescale 1ns / 1ps


module tbStimVerify(
        input clock,
        input reset,
        input signed [63:0][8:0] x,
        input IN_START,   //ready for new input
        output reg signed [63:0][8:0] y,
        output reg OUT_XFC  //output ready to send
    );
    
    
    reg [1:0]PRState; 
    reg [1:0] NXState;
    reg [2:0] muxSelectCounter;
        
    // setting values as parameters
    parameter idle = 1, busy = 2, done = 3;
    
    //muxSelectCounter
    always @ (posedge clock) begin
    // if present state is busy, increment counter
        if( PRState == busy)
            muxSelectCounter <= muxSelectCounter + 1;
        else // else set counter to zero
            muxSelectCounter <= 0;
    end
    
    //Defining State Machine
    always @ (*) begin //at the every clock pulse or reset
        // if eset is high, set present state to idle
        if( reset == 1'b1 ) begin
            PRState = idle;
        end
        else begin // else present state gets next state
            PRState = NXState;
        end
    end

    always @ (posedge clock) begin
        case (PRState) 
            // if IN_START is high, set next state to busy start process
            idle: if(IN_START == 1'b1) 
                   NXState <= busy;
               else NXState <= idle; // else set next state to idle
            //state is busy until counter gets to 7 and next state gets set to done
            busy: if(muxSelectCounter == 3'b111) begin
                        y[0] <= x[0]+8'h05;
                        y[1] <= x[1]+8'h0A;
                        y[2] <= x[2];
                        y[3] <= x[3];
                        y[4] <= x[4];
                        y[5] <= x[5];
                        y[6] <= x[6];
                        y[7] <= x[7];
                        y[8] <= x[8];
                        y[9] <= x[9];
                        y[10] <= x[10];
                        y[11] <= x[11];
                        y[12] <= x[12];
                        y[13] <= x[13];
                        y[14] <= x[14];
                        y[15] <= x[15];
                        y[16] <= x[16];
                        y[17] <= x[17];
                        y[18] <= x[18];
                        y[19] <= x[19];
                        y[20] <= x[20];
                        y[21] <= x[21];
                        y[22] <= x[22];
                        y[23] <= x[23];
                        y[24] <= x[24];
                        y[25] <= x[25];
                        y[26] <= x[26];
                        y[27] <= x[27];
                        y[28] <= x[28];
                        y[29] <= x[29];
                        y[30] <= x[30];
                        y[31] <= x[31];
                        y[32] <= x[32];
                        y[33] <= x[33];
                        y[34] <= x[34];
                        y[35] <= x[35];
                        y[36] <= x[36];
                        y[37] <= x[37];
                        y[38] <= x[38];
                        y[39] <= x[39];
                        y[40] <= x[40];
                        y[41] <= x[41];
                        y[42] <= x[42];
                        y[43] <= x[43];
                        y[44] <= x[44];
                        y[45] <= x[45];
                        y[46] <= x[46];
                        y[47] <= x[47];
                        y[48] <= x[48];
                        y[49] <= x[49];
                        y[50] <= x[50];
                        y[51] <= x[51];
                        y[52] <= x[52];
                        y[53] <= x[53];
                        y[54] <= x[54];
                        y[55] <= x[55];
                        y[56] <= x[56];
                        y[57] <= x[57];
                        y[58] <= x[58];
                        y[59] <= x[59];
                        y[60] <= x[60];
                        y[61] <= x[61];
                        y[62] <= x[62];
                        y[63] <= x[63];
                        NXState <= done;
                   end
               else NXState = busy;
            done: NXState <= idle;
            //setting default state
            default: NXState <= idle;
        endcase
    end
    // setting OUT_XFC to high when present state is done
    always @ (*) begin
        if (PRState == done)
            OUT_XFC <= 1;
        else
            OUT_XFC <= 0;
    end
    
endmodule
