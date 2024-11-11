`timescale 1ns / 1ps

module stage_EX_tb;

    // Inputs
    reg RegWrite_in_EX;
    reg MemtoReg_in_EX;
    reg Branch_in_EX;
    reg MemRead_in_EX;
    reg MemWrite_in_EX;
    reg RegDst_EX;
    reg [5:0] ALUOp_EX;
    reg ALUSrc_EX;
    reg [31:0] PCAddResult_EX;
    reg [31:0] ReadData1_EX;
    reg [31:0] ReadData2_in_EX;
    reg [31:0] SignExtResult_EX; // For funct input
    reg [4:0] rt_EX;
    reg [4:0] rd_EX;

    // Outputs
    wire RegWrite_out_EX;
    wire MemtoReg_out_EX;
    wire Branch_out_EX;
    wire MemRead_out_EX;
    wire MemWrite_out_EX;
    wire [31:0] ALUAddResult_EX;
    wire Zero_EX;
    wire [31:0] ALUResult_EX;
    wire [31:0] ReadData2_out_EX;
    wire [4:0] mux2_result_EX;

    // Instantiate the stage_EX module
    stage_EX uut (
        .RegWrite_in_EX(RegWrite_in_EX),
        .MemtoReg_in_EX(MemtoReg_in_EX),
        .Branch_in_EX(Branch_in_EX),
        .MemRead_in_EX(MemRead_in_EX),
        .MemWrite_in_EX(MemWrite_in_EX),
        .RegDst_EX(RegDst_EX),
        .ALUOp_EX(ALUOp_EX),
        .ALUSrc_EX(ALUSrc_EX),
        .PCAddResult_EX(PCAddResult_EX),
        .ReadData1_EX(ReadData1_EX),
        .ReadData2_in_EX(ReadData2_in_EX),
        .SignExtResult_EX(SignExtResult_EX),
        .rt_EX(rt_EX),
        .rd_EX(rd_EX),
        .RegWrite_out_EX(RegWrite_out_EX),
        .MemtoReg_out_EX(MemtoReg_out_EX),
        .Branch_out_EX(Branch_out_EX),
        .MemRead_out_EX(MemRead_out_EX),
        .MemWrite_out_EX(MemWrite_out_EX),
        .ALUAddResult_EX(ALUAddResult_EX),
        .Zero_EX(Zero_EX),
        .ALUResult_EX(ALUResult_EX),
        .ReadData2_out_EX(ReadData2_out_EX),
        .mux2_result_EX(mux2_result_EX)
    );

    // Test Procedure
    initial begin
        // Test case 1: ADD
        RegWrite_in_EX = 1; MemtoReg_in_EX = 0; Branch_in_EX = 0; 
        MemRead_in_EX = 0; MemWrite_in_EX = 0; RegDst_EX = 1; 
        ALUOp_EX = 6'b000000; ALUSrc_EX = 0; 
        PCAddResult_EX = 32'd4; ReadData1_EX = 32'd10; 
        ReadData2_in_EX = 32'd15; SignExtResult_EX = 32'b100000; 
        rt_EX = 5'b00000; rd_EX = 5'b00001; // rd = 1
        #10; // Wait for results
        $display("Test 1 - ADD: ALUResult = %d, Zero = %b", ALUResult_EX, Zero_EX); // Expect 25, Zero = 0

        // Test case 2: SUB
        ALUOp_EX = 6'b000000; ReadData1_EX = 32'd25; ReadData2_in_EX = 32'd5; SignExtResult_EX = 32'h00000022;
        #10; // Wait for results
        $display("Test 2 - SUB: ALUResult = %d, Zero = %b", ALUResult_EX, Zero_EX); // Expect 20, Zero = 0
        
        // Test case 3: BEQ
        ReadData1_EX = 32'd10; // Set ReadData1 to 10
        ReadData2_in_EX = 32'd10; // Set ReadData2 to 10 for equality
        ALUOp_EX = 6'b000100; // Set ALU for BEQ
        #10; // Wait for results
        $display("Test 7 - BEQ: ALUResult = %d, Zero = %b", ALUResult_EX, Zero_EX); // Expect ALUResult = irrelevant, Zero = 1
        

        
    end
endmodule
