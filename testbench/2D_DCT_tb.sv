`timescale 1ns / 1ps

module TwoD_DCT_tb();

    ////////////////////////////////////////////////////////////////////////    
    // Clock & reset generator
    //
    reg     clock;
    reg     rst_ = 0;
    wire    reset;
    
    integer acceptableError = 10;
    
    integer reset_count = 0;
    `define NUM_RESET_CYCLES (10)
    
    wire    sck_falling_edge;
    
    assign reset = ~rst_;
    
    initial
    begin
        clock = 0;
        while (1)
            #5 clock = ~clock;  // toggle clk each 5 ns (100 MHz clock frequency)
    end
    
    always @ (posedge clock)
    begin
        reset_count <= reset_count + 1;     // always use non-blocking assignment, '<=',
                                            // in sequential processes
    
        if (reset_count == `NUM_RESET_CYCLES)
            rst_ <= 1;                                        
    end
    ////////////////////////////////////////////////////////////////////////    

    ////////////////////////////////////////////////////////////////////////    
    // Open the file at simulation startup
    //
    integer fd_in;
    
    initial
    begin
        fd_in = $fopen( "C:/Users/Josh/Dropbox/VLSI/Project4/2D-DCT-8BIT/desgin/stimV1.txt", "r" );
        if (fd_in == 0)
        begin
            $display( "Couldn't open file for read" );
            $finish;
        end
    end
    //////////////////////////////////////////////////////////////////////// 

    ////////////////////////////////////////////////////////////////////////    
    // Read in stimulus vectors, and golden response from the file
    //
    reg  signed[63:0][8:0] stim_IN_X;
    wire                   stim_IN_START;
    
    wire              resp_OUT_XFC;
    wire signed[63:0][26:0] resp_OUT_Y;
    
    reg signed[63:0][26:0] gold_OUT_Y;
    
    string  the_line;
    integer num_items;
    
    `define TB_STATE_IDLE   (0)
    `define TB_STATE_START  (1)
    `define TB_STATE_WAIT   (2)
    `define TB_STATE_DONE   (3)
    
    integer tb_state;
    
    assign stim_IN_START = (tb_state == `TB_STATE_START);
    
    always @ (posedge clock)
    begin
        if (reset)
            tb_state <= `TB_STATE_IDLE;
        else
            case (tb_state)
                `TB_STATE_IDLE:
                    tb_state <= `TB_STATE_START;
                    
                `TB_STATE_START:
                    tb_state <= `TB_STATE_WAIT;
                `TB_STATE_WAIT:
                    if (resp_OUT_XFC)
                        tb_state <= `TB_STATE_DONE;
                `TB_STATE_DONE:
                    tb_state <= `TB_STATE_IDLE;
            endcase
    end
    
    integer test_status;
    integer i;
            
    always @ (posedge clock)
    begin
        if (reset)
        begin
            stim_IN_X       <= 0;
            gold_OUT_Y    <= 0;
        end
        else
        begin
            if (tb_state == `TB_STATE_START)
            begin
                num_items=$fgets( the_line, fd_in );
                
                if (num_items == 0)
                begin
                    $display( "***** ----> PASS <---- ***** !!!\n" );
                    #25 $finish;
                end
                else if (the_line[0] != "/")
                begin
                    $sscanf( the_line, "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", 
                       	stim_IN_X[0],
                        stim_IN_X[1],
                        stim_IN_X[2],
                        stim_IN_X[3],
                        stim_IN_X[4],
                        stim_IN_X[5],
                        stim_IN_X[6],
                        stim_IN_X[7],
                        stim_IN_X[8],
                        stim_IN_X[9],
                        stim_IN_X[10],
                        stim_IN_X[11],
                        stim_IN_X[12],
                        stim_IN_X[13],
                        stim_IN_X[14],
                        stim_IN_X[15],
                        stim_IN_X[16],
                        stim_IN_X[17],
                        stim_IN_X[18],
                        stim_IN_X[19],
                        stim_IN_X[20],
                        stim_IN_X[21],
                        stim_IN_X[22],
                        stim_IN_X[23],
                        stim_IN_X[24],
                        stim_IN_X[25],
                        stim_IN_X[26],
                        stim_IN_X[27],
                        stim_IN_X[28],
                        stim_IN_X[29],
                        stim_IN_X[30],
                        stim_IN_X[31],
                        stim_IN_X[32],
                        stim_IN_X[33],
                        stim_IN_X[34],
                        stim_IN_X[35],
                        stim_IN_X[36],
                        stim_IN_X[37],
                        stim_IN_X[38],
                        stim_IN_X[39],
                        stim_IN_X[40],
                        stim_IN_X[41],
                        stim_IN_X[42],
                        stim_IN_X[43],
                        stim_IN_X[44],
                        stim_IN_X[45],
                        stim_IN_X[46],
                        stim_IN_X[47],
                        stim_IN_X[48],
                        stim_IN_X[49],
                        stim_IN_X[50],
                        stim_IN_X[51],
                        stim_IN_X[52],
                        stim_IN_X[53],
                        stim_IN_X[54],
                        stim_IN_X[55],
                        stim_IN_X[56],
                        stim_IN_X[57],
                        stim_IN_X[58],
                        stim_IN_X[59],
                        stim_IN_X[60],
                        stim_IN_X[61],
                        stim_IN_X[62],
                        stim_IN_X[63],
                        gold_OUT_Y[0],
                        gold_OUT_Y[1],
                        gold_OUT_Y[2],
                        gold_OUT_Y[3],
                        gold_OUT_Y[4],
                        gold_OUT_Y[5],
                        gold_OUT_Y[6],
                        gold_OUT_Y[7],
                        gold_OUT_Y[8],
                        gold_OUT_Y[9],
                        gold_OUT_Y[10],
                        gold_OUT_Y[11],
                        gold_OUT_Y[12],
                        gold_OUT_Y[13],
                        gold_OUT_Y[14],
                        gold_OUT_Y[15],
                        gold_OUT_Y[16],
                        gold_OUT_Y[17],
                        gold_OUT_Y[18],
                        gold_OUT_Y[19],
                        gold_OUT_Y[20],
                        gold_OUT_Y[21],
                        gold_OUT_Y[22],
                        gold_OUT_Y[23],
                        gold_OUT_Y[24],
                        gold_OUT_Y[25],
                        gold_OUT_Y[26],
                        gold_OUT_Y[27],
                        gold_OUT_Y[28],
                        gold_OUT_Y[29],
                        gold_OUT_Y[30],
                        gold_OUT_Y[31],
                        gold_OUT_Y[32],
                        gold_OUT_Y[33],
                        gold_OUT_Y[34],
                        gold_OUT_Y[35],
                        gold_OUT_Y[36],
                        gold_OUT_Y[37],
                        gold_OUT_Y[38],
                        gold_OUT_Y[39],
                        gold_OUT_Y[40],
                        gold_OUT_Y[41],
                        gold_OUT_Y[42],
                        gold_OUT_Y[43],
                        gold_OUT_Y[44],
                        gold_OUT_Y[45],
                        gold_OUT_Y[46],
                        gold_OUT_Y[47],
                        gold_OUT_Y[48],
                        gold_OUT_Y[49],
                        gold_OUT_Y[50],
                        gold_OUT_Y[51],
                        gold_OUT_Y[52],
                        gold_OUT_Y[53],
                        gold_OUT_Y[54],
                        gold_OUT_Y[55],
                        gold_OUT_Y[56],
                        gold_OUT_Y[57],
                        gold_OUT_Y[58],
                        gold_OUT_Y[59],
                        gold_OUT_Y[60],
                        gold_OUT_Y[61],
                        gold_OUT_Y[62],
                        gold_OUT_Y[63]
                    );
                end
            end
            else if (resp_OUT_XFC)
            begin
                $display("checking output ");
                for( i=0; i<64; i+=1) begin 
                    if ( gold_OUT_Y[i]-resp_OUT_Y[i]<=acceptableError || resp_OUT_Y[i]-gold_OUT_Y[i]<=acceptableError)
                        test_status = 1;
                    else                
                    begin
                        $display( "***** ----> FAIL on %d, got %d <---- ***** !!!\n", gold_OUT_Y[i], resp_OUT_Y[i] );
                        #25 $finish;
                    end
                end
            end
        end
    end
    ////////////////////////////////////////////////////////////////////////  

    ////////////////////////////////////////////////////////////////////////    
    // Instantiate DUT
    //

    TwoDDCT u_TwoDDCT
    (
        .clock      (clock      ),
        .reset    (reset    ),
        .x     (stim_IN_X     ),
        .IN_START (stim_IN_START ),
        .y  (resp_OUT_Y  ),
        .OUT_XFC  (resp_OUT_XFC  )
    );
endmodule
