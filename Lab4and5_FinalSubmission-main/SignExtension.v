`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(Instruction, out);

    /* A 16-Bit input word */
    //input [15:0] in;
    input [31:0] Instruction;

    wire [15:0]in;

    assign in = Instruction[15:0];
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @(*) begin
        if (in[15] == 1'b1) begin
            out = {16'b1111111111111111, in};
        end
        else begin
            out = {16'b0, in};
        end
    end
    
endmodule
