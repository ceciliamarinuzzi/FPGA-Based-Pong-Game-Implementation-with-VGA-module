`timescale 1ns / 1ps

module text(
    input wire clk_100MHz,      
    input wire reset,           
    input wire [1:0] sw,        
    input wire video_on,                  
    input wire [9:0] x_pix,         
    input wire [9:0] y_pix,         
    output reg [3:0] vga_r,    
    output reg [3:0] vga_g,     
    output reg [3:0] vga_b      
);

    //================================//
    //       REGISTER DECLARATION     //
	//================================//

    reg [6:0] char_code;        
    reg [3:0] row_addr;     
    reg [2:0] bit_addr;     


    //================================//
    //       LOCAL COORDINATES        //
	//================================//
    
	wire [9:0] x_menu  = x_pix - 256;    // Coordinata x scritta "MENU"
    wire [9:0] y_menu  = y_pix - 208;    // Coordinata y scritta "MENU"
    wire [9:0] x_riga1 = x_pix - 152;    // Coordinata x scritta "Single Player" 
    wire [9:0] y_riga1 = y_pix - 300;    // Coordinata y scritta "Single Player" (nel menu)
    wire [9:0] y_game  = y_pix - 45;     // Coordinata y scritta "Single Player" e "Multi Player" (nel game)
    wire [9:0] x_riga2 = x_pix - 160;    // Coordinata x scritta "Multi Player"
    wire [9:0] y_riga2 = y_pix - 350;    // Coordinata y scritta "Multi Player" (nel menu)
	

    //================================//
    //        IN GAME TEXT             //
    //================================//
    always @* begin
        char_code = 7'h20; 
        row_addr = 4'h0;
        bit_addr = 3'h0;

        // --- STRISCIA IN ALTO DURANTE IL GIOCO ---
        if (y_pix >= 45 && y_pix < 77) begin
            if (sw == 2'b01 && x_pix >= 152 && x_pix < 512) begin
                row_addr = y_game[4:1]; 
                bit_addr = x_riga1[3:1];
                case (x_riga1[9:4])
                    6'd2:  char_code = 7'h53; // 'S'
                    6'd3:  char_code = 7'h69; // 'i'
                    6'd4:  char_code = 7'h6E; // 'n'
                    6'd5:  char_code = 7'h67; // 'g'
                    6'd6:  char_code = 7'h6C; // 'l'
                    6'd7:  char_code = 7'h65; // 'e'
                    6'd9:  char_code = 7'h50; // 'P'
                    6'd10: char_code = 7'h6C; // 'l'
                    6'd11: char_code = 7'h61; // 'a'
                    6'd12: char_code = 7'h79; // 'y'
                    6'd13: char_code = 7'h65; // 'e'
                    6'd14: char_code = 7'h72; // 'r'
                    6'd16: char_code = 7'h4D; // 'M'
                    6'd17: char_code = 7'h6F; // 'o'
                    6'd18: char_code = 7'h64; // 'd'
                    6'd19: char_code = 7'h65; // 'e'
                    default: char_code = 7'h20; 
                endcase
            end
            else if (sw == 2'b10 && x_pix >= 160 && x_pix < 512) begin
                row_addr = y_game[4:1];
                bit_addr = x_riga2[3:1];
                case (x_riga2[9:4])
                    6'd2:  char_code = 7'h4D; // 'M'
                    6'd3:  char_code = 7'h75; // 'u'
                    6'd4:  char_code = 7'h6C; // 'l'
                    6'd5:  char_code = 7'h74; // 't'
                    6'd6:  char_code = 7'h69; // 'i'
                    6'd8:  char_code = 7'h50; // 'P'
                    6'd9:  char_code = 7'h6C; // 'l'
                    6'd10: char_code = 7'h61; // 'a'
                    6'd11: char_code = 7'h79; // 'y'
                    6'd12: char_code = 7'h65; // 'e'
                    6'd13: char_code = 7'h72; // 'r'
                    6'd15: char_code = 7'h4D; // 'M'
                    6'd16: char_code = 7'h6F; // 'o'
                    6'd17: char_code = 7'h64; // 'd'
                    6'd18: char_code = 7'h65; // 'e'
                    default: char_code = 7'h20;
                endcase
            end
        end
        
        
    //================================//
    //        START SCREEN TEXT       //
    //================================//
        else if (sw == 2'b00 || sw == 2'b11) begin 
            if (y_pix >= 208 && y_pix < 272 && x_pix >= 256 && x_pix < 384) begin
                row_addr = y_menu[5:2];
                bit_addr = x_menu[4:2];
                case (x_menu[9:5])
                    5'd0: char_code = 7'h4D; // 'M'
                    5'd1: char_code = 7'h45; // 'E'
                    5'd2: char_code = 7'h4E; // 'N'
                    5'd3: char_code = 7'h55; // 'U'
                    default: char_code = 7'h20;
                endcase
            end
            else if (y_pix >= 300 && y_pix < 332 && x_pix >= 152 && x_pix < 512) begin
                row_addr = y_riga1[4:1];
                bit_addr = x_riga1[3:1];
                case (x_riga1[9:4])
                    6'd0:  char_code = 7'h53; // 'S'
                    6'd1:  char_code = 7'h69; // 'i'
                    6'd2:  char_code = 7'h6E; // 'n'
                    6'd3:  char_code = 7'h67; // 'g'
                    6'd4:  char_code = 7'h6C; // 'l'
                    6'd5:  char_code = 7'h65; // 'e'
                    6'd7:  char_code = 7'h50; // 'P'
                    6'd8:  char_code = 7'h6C; // 'l'
                    6'd9:  char_code = 7'h61; // 'a'
                    6'd10: char_code = 7'h79; // 'y'
                    6'd11: char_code = 7'h65; // 'e'
                    6'd12: char_code = 7'h72; // 'r'
                    6'd14: char_code = 7'h4D; // 'M'
                    6'd15: char_code = 7'h6F; // 'o'
                    6'd16: char_code = 7'h64; // 'd'
                    6'd17: char_code = 7'h65; // 'e'
                    6'd19: char_code = 7'h53; // 'S'
                    6'd20: char_code = 7'h57; // 'W'
                    6'd21: char_code = 7'h30; // '0'
                    default: char_code = 7'h20;
                endcase
            end
            else if (y_pix >= 350 && y_pix < 382 && x_pix >= 160 && x_pix < 512) begin
                row_addr = y_riga2[4:1];
                bit_addr = x_riga2[3:1];
                case (x_riga2[9:4])
                    6'd0:  char_code = 7'h4D; // 'M'
                    6'd1:  char_code = 7'h75; // 'u'
                    6'd2:  char_code = 7'h6C; // 'l'
                    6'd3:  char_code = 7'h74; // 't'
                    6'd4:  char_code = 7'h69; // 'i'
                    6'd6:  char_code = 7'h50; // 'P'
                    6'd7:  char_code = 7'h6C; // 'l'
                    6'd8:  char_code = 7'h61; // 'a'
                    6'd9:  char_code = 7'h79; // 'y'
                    6'd10: char_code = 7'h65; // 'e'
                    6'd11: char_code = 7'h72; // 'r'
                    6'd13: char_code = 7'h4D; // 'M'
                    6'd14: char_code = 7'h6F; // 'o'
                    6'd15: char_code = 7'h64; // 'd'
                    6'd16: char_code = 7'h65; // 'e'
                    6'd18: char_code = 7'h53; // 'S'
                    6'd19: char_code = 7'h57; // 'W'
                    6'd20: char_code = 7'h31; // '1'
                    default: char_code = 7'h20;
                endcase
            end
        end
    end

    //================================//
    //         ROM ACCESS             //
	//================================//
    
    wire [10:0] rom_addr = {char_code, row_addr};
    wire [7:0] rom_data;
    
    font_rom font_inst (
        .clk(clk_100MHz),
        .addr(rom_addr),    
        .data(rom_data)    
    );

    // Estrazione istantanea del bit del font 
    wire font_bit = rom_data[~bit_addr];

    //================================//
    //         COLOR OUTPUTS          //
	//================================//
    always @* begin

        if (!video_on || !font_bit) begin
            vga_r = 4'h0;
            vga_g = 4'h0;
            vga_b = 4'h0;
        end else begin
            vga_r = 4'h0;
            vga_g = 4'hF; 
            vga_b = 4'h0;
        end
    end

endmodule