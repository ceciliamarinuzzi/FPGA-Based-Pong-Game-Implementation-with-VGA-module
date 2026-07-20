`timescale 1ns / 1ps



    //=========================//
    //      DECLARATIONS       //
    //=========================//
	
module pong_logic #(
	parameter SIZE = 8,
	parameter WIDTH = 8,
	parameter HEIGHT = 64,
	parameter HEIGHTHALF = 32
)(
    input clk_100MHz,
    input reset,
    input [3:0] btn,
    input [1:0] sw,
    input vsync, 
    
    output signed [10:0] x_out,    //coordinate pallina
    output signed [10:0] y_out,
    output signed [10:0] x1_out,   //coordinate paddle 1
    output signed [10:0] y1_out,
    output signed [10:0] x2_out,   //coordinate paddle 2
    output signed [10:0] y2_out
);

    //=========================//
    //    INTERNAL REGISTERS   //
    //=========================//
    reg signed [10:0] x, y;           // coordinata pallina
    reg signed [10:0] dir_x, dir_y;   // direzione pallina
    reg signed [10:0] x1, y1;         // coordinata paddle 1
    reg signed [10:0] x2, y2;         // coordinata paddle 2
    
    reg vsync_reg;
    wire frame_tick;
    
    reg [1:0] sw_reg;
    wire sw_change;

    always @(posedge clk_100MHz) begin
        vsync_reg <= vsync;
        sw_reg <= sw;
    end 
    
    assign frame_tick = (vsync_reg == 0 && vsync == 1);  //frame_tick diventa 1 ad ogni frame (60 Hz)
    assign sw_change = (sw != sw_reg);					 //sw_change diventa 1 ogni volta che si cambia mode 

    //=========================//
    //      GAME DYNAMICS      //
    //=========================//
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset || sw_change) begin // CONDIZIONI INIZIALI 
            x <= 320;
            y <= 280;
            x1 <= 600;
            y1 <= 240;
            x2 <= 30;
            y2 <= 240;
            dir_x <= 2;
            dir_y <= 2;
        end
        else if (frame_tick) begin    // AVVIO GIOCO
            // RIMBALZO SU PARETI POST PADDLEs E RIGENERAZIONE PALLINA
            if (x >= 631 || x <= 0) begin
                x <= 320;
                y <= 240;
                dir_x <= (x <= 0) ? -2 : 2;
                dir_y <= 2;
            end
            
            // RIMBALZO SU PAVIMENTO, TETTO E PADDLE
            else begin 
                if ((y >= y1 && y <= y1 + HEIGHT - SIZE) && (x + SIZE >= x1 && x + SIZE <= x1 + 3)) begin 
                    dir_x <= -2;
                end 
                else if ((y >= y2 && y <= y2 + HEIGHT - SIZE) && (x <= x2 + WIDTH && x >= x2 + WIDTH -3 )) begin 
                    dir_x <= 2;
                end 
                
                if (y <= 85) 
                    dir_y <= 2;
                else if (y + SIZE >= 475) 
                    dir_y <= -2;
            
                x <= x + dir_x;
                y <= y + dir_y;
            end

            // MOVIMENTO PADDLE DX 
            if (sw[0] || sw[1]) begin
                if (btn[0] && (y1 + HEIGHT < 475))
                    y1 <= y1 + 4;
                else if (btn[1] && (y1 > 85))
                    y1 <= y1 - 4;
            end

            // MOVIMENTO PADDLE SX 
            if (sw[0]) begin // MODALITA' SINGLE PLAYER
                // MODALITÀ SINGLE PLAYER
                if (x < 160) begin
                    if (y > y2 + HEIGHTHALF) begin 
                        if (y2 + HEIGHT < 475)
                            y2 <= y2 + 2; 
                    end
                    else if (y < y2 + HEIGHTHALF) begin 
                        if (y2 > 85)
                            y2 <= y2 - 2; 
                    end
                end
                else begin
                    y2 <= y2;
                end
            end
            else if (sw[1]) begin 
                // MODALITÀ MULTI PLAYER
                if (btn[2] && (y2 + HEIGHT < 475))
                    y2 <= y2 + 4;
                else if (btn[3] && (y2 > 85))
                    y2 <= y2 - 4;
            end
        end 
    end 

    //==============================//
	//       FINAL ASSIGNMENTS      //
	//==============================//
    assign x_out = x;
    assign y_out = y;
    assign x1_out = x1;
    assign y1_out = y1;
    assign x2_out = x2;
    assign y2_out = y2;
    
endmodule