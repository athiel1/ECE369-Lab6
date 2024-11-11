
`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module ZeroExtend5Bit(shamt, out);

    /* A 16-Bit input word */
    //input [15:0] in;
    input [4:0] shamt;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @(*) begin
            out = {27'b0, shamt};
    end
    
endmodule
