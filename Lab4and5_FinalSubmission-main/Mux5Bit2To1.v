`timescale 1ns / 1ps
module Mux5Bit2To1(inA, inB, sel, out);
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;

    output reg [4:0] out;
    
    // assign out = sel? inB: inA;   for this line, no reg in line 12
    always @(*) begin
        if (sel === 1'bx) begin
            out <= 4'b0; // Set to zero if sel is X
        end else if (sel == 0) begin
            out <= inA;
        end else begin
            out <= inB;
        end
    end
    
endmodule
