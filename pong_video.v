`timescale 1ns / 1ps

module pong_video(
    input wire clk_100MHz,
    input wire reset,
    input wire [1:0] sw,                
    input wire video_on,              
    input wire [9:0] y_pix,                
    input wire ball_draw,              
    input wire paddle_draw1,          
    input wire paddle_draw2,          
    input wire [3:0] menu_r,
    input wire [3:0] menu_g,
    input wire [3:0] menu_b,
    output reg [3:0] vga_r,
    output reg [3:0] vga_g,
    output reg [3:0] vga_b
);

    wire any_paddle = paddle_draw1 || paddle_draw2;
    wire text_active = (menu_r != 4'h0 || menu_g != 4'h0 || menu_b != 4'h0);
	
	
    //============================//
	//  FIRST COMBINATORY BLOCK  //
	//============================//
    reg [3:0] next_r, next_g, next_b;
	reg [3:0] game_r, game_g, game_b;

    always @(*) begin
        if (!video_on) begin
            next_r = 4'h0; next_g = 4'h0; next_b = 4'h0;
        end
        else if (y_pix < 80 && text_active) begin
            next_r = menu_r; next_g = menu_g; next_b = menu_b;
        end
        else if (sw[0] ^ sw[1]) begin
            next_r = game_r; next_g = game_g; next_b = game_b;
        end
        else begin
            next_r = menu_r; next_g = menu_g; next_b = menu_b;
        end
    end

    //============================//
	//  SECOND COMBINATORY BLOCK   //
	//============================//
	

    always @(*) begin
        if (ball_draw) begin
            game_r = 4'hF; game_g = 4'hF; game_b = 4'h0; // Giallo
        end
        else if (any_paddle) begin
            game_r = 4'hF; game_g = 4'h0; game_b = 4'hF; // Viola
        end
        else if ((y_pix >= 80 && y_pix <= 83) || (y_pix >= 477 && y_pix <= 480)) begin 
            game_r = 4'h0; game_g = 4'hF; game_b = 4'hF; // Ciano
        end
        else begin
            game_r = 4'h0; game_g = 4'h0; game_b = 4'h0; // Nero
        end
    end


    //============================//
	//      SEQUENTIAL BLOCK      //
	//============================//
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            vga_r <= 4'h0; vga_g <= 4'h0; vga_b <= 4'h0;
        end
        else begin
            vga_r <= next_r;
            vga_g <= next_g;
            vga_b <= next_b;
        end
    end

endmodule