`timescale 1ns / 1ps

//================================================================
//                         PADDLE MODULE
//================================================================
module paddle #(
    parameter WIDTH  = 8, 
    parameter HEIGHT = 64
)(
    input  [9:0]  x_pix, y_pix,  // Coordinate del pixel corrente dal VGA Controller
    input  [10:0] x1, y1,        // Posizione in alto a sinistra della Racchetta 1
    input  [10:0] x2, y2,        // Posizione in alto a sinistra della Racchetta 2
    output        draw1, draw2   // Segnali di abilitazione al disegno
);

    // Calcolo dei limiti (Destra e Basso) per la Racchetta 1
    wire [10:0] r1 = x1 + WIDTH  - 1;
    wire [10:0] b1 = y1 + HEIGHT - 1;

    // Calcolo dei limiti (Destra e Basso) per la Racchetta 2
    wire [10:0] r2 = x2 + WIDTH  - 1;
    wire [10:0] b2 = y2 + HEIGHT - 1;

    // Verifica se il pixel corrente si trova all'interno delle racchette
    assign draw1 = (x_pix >= x1 && x_pix <= r1) && (y_pix >= y1 && y_pix <= b1);
    assign draw2 = (x_pix >= x2 && x_pix <= r2) && (y_pix >= y2 && y_pix <= b2);

endmodule