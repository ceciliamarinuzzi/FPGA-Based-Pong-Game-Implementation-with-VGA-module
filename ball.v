`timescale 1ns / 1ps

//================================================================
//                          BALL MODULE
//================================================================
module ball #(
    parameter SIZE = 8           
)(
    input  [9:0]  x_pix, y_pix,  // Coerente con il controller VGA e il modulo paddle
    input signed [10:0] x, y,    // Posizione in alto a sinistra della pallina
    output        draw           // Segnale di abilitazione al disegno della pallina
);

    // Calcolo dei limiti (Destra e Basso) della pallina
    wire [10:0] r = x + SIZE - 1;
    wire [10:0] b = y + SIZE - 1;

    // Verifica se il pixel corrente si trova all'interno della pallina
    assign draw = (x_pix >= x && x_pix <= r) && (y_pix >= y && y_pix <= b);

endmodule