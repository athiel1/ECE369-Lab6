`timescale 1ns / 1ps

module ShiftLeft2(in, out);

    input [31:0] in;
    
    output reg [31:0] out;
    
    always @(*) begin 
        out <= in * 4;
    end

endmodule
