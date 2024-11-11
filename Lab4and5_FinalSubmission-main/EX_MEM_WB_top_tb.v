`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 08:38:00 PM
// Design Name: 
// Module Name: EX_MEM_WB_top_tb
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


module EX_MEM_WB_top_tb;

    // Inputs
    reg [31:0] PCAddResult_in_IDEX; 
    reg [31:0] ReadData1_in_IDEX; 
    reg [31:0] ReadData2_in_IDEX; 
    reg [31:0] signExtend_in_IDEX; 
    reg [4:0] rt_in_IDEX; 
    reg [4:0] rd_in_IDEX; 
    reg RegWrite_in_IDEX; 
    reg MemtoReg_in_IDEX; 
    reg Branch_in_IDEX; 
    reg MemRead_in_IDEX; 
    reg MemWrite_in_IDEX; 
    reg RegDst_in_IDEX; 
    reg [5:0] ALUOp_in_IDEX; 
    reg ALUSrc_in_IDEX; 
    reg Clk_in_IDEX;

    // Outputs
    wire MemtoReg_out_MEM; 
    wire PCSrc_MEM; 
    wire [31:0] ALUResult_out_MEM; 
    wire [31:0] mux2_result_out_MEM; 
    wire [31:0] ReadData_MEM; 
    wire RegWrite_out_MEM; 
    wire Clk_out_MEM;

    // Instantiate the Unit Under Test (UUT)
    EX_MEM_WB_top uut (
        .PCAddResult_in_IDEX(PCAddResult_in_IDEX),
        .ReadData1_in_IDEX(ReadData1_in_IDEX),
        .ReadData2_in_IDEX(ReadData2_in_IDEX),
        .signExtend_in_IDEX(signExtend_in_IDEX),
        .rt_in_IDEX(rt_in_IDEX),
        .rd_in_IDEX(rd_in_IDEX),
        .RegWrite_in_IDEX(RegWrite_in_IDEX),
        .MemtoReg_in_IDEX(MemtoReg_in_IDEX),
        .Branch_in_IDEX(Branch_in_IDEX),
        .MemRead_in_IDEX(MemRead_in_IDEX),
        .MemWrite_in_IDEX(MemWrite_in_IDEX),
        .RegDst_in_IDEX(RegDst_in_IDEX),
        .ALUOp_in_IDEX(ALUOp_in_IDEX),
        .ALUSrc_in_IDEX(ALUSrc_in_IDEX),
        .Clk_in_IDEX(Clk_in_IDEX),
        .MemtoReg_out_MEM(MemtoReg_out_MEM),
        .PCSrc_MEM(PCSrc_MEM),
        .ALUResult_out_MEM(ALUResult_out_MEM),
        .mux2_result_out_MEM(mux2_result_out_MEM),
        .ReadData_MEM(ReadData_MEM),
        .RegWrite_out_MEM(RegWrite_out_MEM),
        .Clk_out_MEM(Clk_out_MEM)
    );

    // Clock Generation
    initial begin
        Clk_in_IDEX = 0;
        forever #5 Clk_in_IDEX = ~Clk_in_IDEX; // 10 time units clock period
    end

    // Stimulus
    initial begin
        // Initialize Inputs
        PCAddResult_in_IDEX = 32'h0;
        ReadData1_in_IDEX = 32'h0;
        ReadData2_in_IDEX = 32'h0;
        signExtend_in_IDEX = 32'h0;
        rt_in_IDEX = 5'b00000;
        rd_in_IDEX = 5'b00000;
        RegWrite_in_IDEX = 0;
        MemtoReg_in_IDEX = 0;
        Branch_in_IDEX = 0;
        MemRead_in_IDEX = 0;
        MemWrite_in_IDEX = 0;
        RegDst_in_IDEX = 0;
        ALUOp_in_IDEX = 0;
        ALUSrc_in_IDEX = 0;

        // Wait for global reset
        #10;
        
        // Test case 1: write (sw)
        
        //EXPECTED RESULTS//
        // ALUResult == 15
        // Address == 15
        // WriteData == 7
        
        ReadData1_in_IDEX = 32'd10;
        ReadData2_in_IDEX = 32'd7;
        signExtend_in_IDEX = 32'd5;
        rt_in_IDEX = 5'b00000;
        RegWrite_in_IDEX = 0;
        MemtoReg_in_IDEX = 0;
        MemRead_in_IDEX = 0;
        MemWrite_in_IDEX = 1;
        RegDst_in_IDEX = 0;
        ALUOp_in_IDEX = 6'b101011;
        ALUSrc_in_IDEX = 1;
        
        
        // Test case 2: Read Enable (lw)
        // ALUResult == 15
        // Address == 15
        // ReadData == 7
        ReadData1_in_IDEX = 32'd10;
        signExtend_in_IDEX = 32'd5;
        rt_in_IDEX = 5'b00000;
        RegWrite_in_IDEX = 1;
        MemtoReg_in_IDEX = 0;
        MemRead_in_IDEX = 1;
        MemWrite_in_IDEX = 0;
        RegDst_in_IDEX = 0;
        ALUOp_in_IDEX = 6'b100011;
        ALUSrc_in_IDEX = 1;
    end

endmodule
