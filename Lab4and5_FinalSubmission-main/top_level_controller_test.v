`timescale 1ns / 1ps

module top_level_controller_test(Clk, Rst, Instruction, A, B, ALUResult, PCSrc);

    input wire Clk;
    input wire Rst;
    input [31:0] Instruction; // Instruction input to Controller
    input [5:0] A;           // Operand A to ALU
    input [31:0] B;           // Operand B to ALU

    wire [5:0] funct;
    wire Zero;
    wire [5:0] ALUControlSignal; // Control signal from ALUControl to ALU
    wire [5:0] ALUOp;            // ALUOp signal from Controller to ALUControl
    wire ALUSrc, RegDst, Branch, MemWrite, MemRead, MemtoReg, RegWrite;
    
    output [31:0] ALUResult;  // Result from ALU
    output PCSrc;

    assign funct = Instruction[5:0];

    //Controller(Clk, Rst, Instruction, RegDst, ALUOp, ALUZero, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite)
    Controller b1(Clk, Rst, Instruction, RegDst, ALUOp, ALUZero, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite);

    //ALUControl(ALUOp, funct, ALUControl)
    ALUControl b2(ALUOp, funct, ALUControlSignal);

    //ALU32Bit(ALUControl, A, B, ALUResult, Zero)
    ALU32Bit b3(ALUControlSignal, A, B, ALUResult, Zero);

    //Branch(Branch, Zero, PCSrc)
    Branch b4(Branch, Zero, PCSrc);


endmodule
