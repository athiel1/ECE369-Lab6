`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 10:46:46 AM
// Design Name: 
// Module Name: stage_ID_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module stage_ID_tb();

    // reg the inputs
    reg [31:0] PCAddResult_in_ID_tb;
    reg [31:0] Instruction_ID_tb;
    reg [4:0] WriteRegister_ID_tb;
    reg [31:0] WriteData_ID_tb;
    reg RegWrite_in_ID_tb;
    reg Clk_ID_tb;
    
    // wire the outputs
    wire RegWrite_out_ID_tb;
    wire MemtoReg_ID_tb;
    wire Branch_ID_tb;
    wire MemRead_ID_tb;
    wire MemWrite_ID_tb;
    wire RegDst_ID_tb;
    wire [5:0] ALUOp_ID_tb;
    wire ALUSrc_ID_tb;
    wire PCSrc_ID_tb;
    wire PCAddResult_out_ID_tb;
    wire [31:0] ReadData1_ID_tb;
    wire [31:0] ReadData2_ID_tb;
    wire [31:0] SignExtResult_ID_tb;
    wire [4:0] rt_ID_tb;
    wire [4:0] rd_ID_tb;
    wire JR_ID_tb;
    wire JAL_ID_tb;
    
    //stage_ID (PCAddResult_in_ID, Instruction_ID, WriteRegister_ID, WriteData_ID, RegWrite_in_ID, RegWrite_out_ID, MemtoReg_ID, Branch_ID, MemRead_ID, MemWrite_ID, RegDst_ID, ALUOp_ID, 
                 //ALUSrc_ID, PCSrc_ID, PCAddResult_out_ID, ReadData1_ID, ReadData2_ID, SignExtResult_ID, rt_ID, rd_ID, JR_ID, JAL_ID, Clk_ID);
    stage_ID a1(PCAddResult_in_ID_tb, Instruction_ID_tb, WriteRegister_ID_tb, WriteData_ID_tb, RegWrite_in_ID_tb, RegWrite_out_ID_tb, MemtoReg_ID_tb, Branch_ID_tb, MemRead_ID_tb, MemWrite_ID_tb, RegDst_ID_tb, ALUOp_ID_tb, 
                 ALUSrc_ID_tb, PCSrc_ID_tb, PCAddResult_out_ID_tb, ReadData1_ID_tb, ReadData2_ID_tb, SignExtResult_ID_tb, rt_ID, rd_ID_tb, JR_ID_tb, JAL_ID_tb, Clk_ID_tb);
    
    always begin
        Clk_ID_tb <= 0; #100; 
        Clk_ID_tb <= 1; #100;
    end
    
    initial begin
        Instruction_ID_tb <= 32'b00100000000010000000000000000000;  // addi $t0, $zero, 0 -> reg 8 = 0 + 0
        PCAddResult_in_ID_tb <= 32'b00000000000000000000000000000100; // PCAddResult = 4 (next line)
        WriteRegister_ID_tb <= 5'b01000; // $t0 (register 8)
        WriteData_ID_tb <= 32'b00000000000000000000000000000000; // puts 0 into $t0
        RegWrite_in_ID_tb <= 1; // sets RegWrite to 1
        @(posedge Clk_ID_tb);
        Instruction_ID_tb <= 32'b00100001000010000000000000001001; // addi $t0, $t0, 9 -> reg 8 = (reg 8) + 9 = 9
        PCAddResult_in_ID_tb <= 32'b00000000000000000000000000001000; // PCAddResult = 8 (next line)
        WriteRegister_ID_tb <= 5'b01000; // $t0 (register 8)
        WriteData_ID_tb <= 32'b00000000000000000000000000001001; // puts 0 into $t0
        RegWrite_in_ID_tb <= 1; // sets RegWrite to 1
        @(posedge Clk_ID_tb);
    end



endmodule
