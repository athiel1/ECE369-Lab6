`timescale 1ns / 1ps

module ALUAdd(A, B, ALUAddResult);
    
    input [31:0] A;
    input [31:0] B;
    
    output reg [31:0] ALUAddResult;
    
    always @(*) begin
        ALUAddResult <= A + B;
    end

endmodule
