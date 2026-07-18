`timescale 1ns / 1ps

module pong_top(
    input wire clk_100MHz,
    input wire reset,
    input wire [1:0] sw,
    input wire [3:0] btn, 
    output wire hsync,
    output wire vsync,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b
);

    // --- FILI DI COLLEGAMENTO INTERNI VGA ---
    wire video_on;
    wire hsync_internal;
    wire vsync_internal;
    wire p_tick;
    wire [9:0] x_pix;
    wire [9:0] y_pix;
    
    // --- FILI DI DISEGNO OGGETTI GIOCO ---
    wire ball_draw;
    wire paddle_draw1;
    wire paddle_draw2;

    // --- FILI PER LE POSIZIONI DALLA LOGICA DI GIOCO ---
    wire signed [10:0] ball_x, ball_y;
    wire signed [10:0] paddle1_x, paddle1_y;
    wire signed [10:0] paddle2_x, paddle2_y;

    // --- FILI PER I COLORI PARZIALI DEL MENU ---
    wire [3:0] menu_r, menu_g, menu_b;

    // 1. ISTANZA DEL CONTROLLER VGA GENERALE
    vga_controller vga_inst (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .video_on(video_on),
        .hsync(hsync_internal),
        .vsync(vsync_internal),
        .p_tick(p_tick),
        .x(x_pix),         
        .y(y_pix)          
    );

    assign hsync = hsync_internal;
    assign vsync = vsync_internal;

    // 2. ISTANZA DELLA LOGICA DI GIOCO
    pong_logic logica_inst (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .btn(btn),
        .sw(sw),
        .vsync(vsync_internal),
        .x_out(ball_x),
        .y_out(ball_y),
        .x1_out(paddle1_x),
        .y1_out(paddle1_y),
        .x2_out(paddle2_x),
        .y2_out(paddle2_y)
    );

    // 3. ISTANZA HARDWARE DELLA PALLINA
    ball #( .SIZE(8) ) ball_render_inst (
        .x_pix(x_pix), 
        .y_pix(y_pix),
        .x(ball_x), 
        .y(ball_y),
        .draw(ball_draw)
    );

    // 4. ISTANZA HARDWARE DELLE RACCHETTE
    paddle #( .WIDTH(8), .HEIGHT(64) ) paddles_render_inst (
        .x_pix(x_pix), 
        .y_pix(y_pix),
        .x1(paddle1_x), 
        .y1(paddle1_y),
        .x2(paddle2_x), 
        .y2(paddle2_y),
        .draw1(paddle_draw1), 
        .draw2(paddle_draw2)
    );

    // 5. ISTANZA DEL MODULO MENU TESTO
    text menu_inst (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .sw(sw),                    
        .video_on(video_on),
        .p_tick(p_tick),
        .x_pix(x_pix),
        .y_pix(y_pix),
        .vga_r(menu_r),             
        .vga_g(menu_g),
        .vga_b(menu_b)
    );

    // 6. ISTANZA DEL SELETTORE VIDEO FINALE (Prende tutto e sputa fuori i pin RGB)
    pong_video video_mix_inst (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .sw(sw),
        .video_on(video_on), 
        .y_pix(y_pix),                    
        .ball_draw(ball_draw),
        .paddle_draw1(paddle_draw1),
        .paddle_draw2(paddle_draw2),
        .menu_r(menu_r),
        .menu_g(menu_g),
        .menu_b(menu_b),
        .vga_r(vga_r),            
        .vga_g(vga_g),
        .vga_b(vga_b)
    );

endmodule