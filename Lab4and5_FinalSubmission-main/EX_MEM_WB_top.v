`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 08:38:21 PM
// Design Name: 
// Module Name: EX_MEM_WB_top
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


module EX_MEM_WB_top(
    
    input [31:0] PCAddResult_in_IDEX, 
    input [31:0] ReadData1_in_IDEX, 
    input [31:0] ReadData2_in_IDEX, 
    input [31:0] signExtend_in_IDEX, 
    input [4:0] rt_in_IDEX, 
    input [4:0] rd_in_IDEX, 
    input RegWrite_in_IDEX, 
    input MemtoReg_in_IDEX, 
    input Branch_in_IDEX, 
    input MemRead_in_IDEX, 
    input MemWrite_in_IDEX, 
    input RegDst_in_IDEX, 
    input [5:0] ALUOp_in_IDEX, 
    input ALUSrc_in_IDEX,
    input Clk_in_IDEX,



///////when doing up to EXMEM/////
    //output MemWrite_out_EXMEM, 
    //output MemRead_out_EXMEM, 
    //output Branch_out_EXMEM, 
    //output MemtoReg_out_EXMEM, 
    //output RegWrite_out_EXMEM, 
    //output [31:0] ALUAddResult_out_EXMEM, 
    //output Zero_out_EXMEM, ALUResult_out_EXMEM, 
    //output [31:0] ReadData2_out_EXMEM, 
    //output [31:0] mux2_Result_out_EXMEM,
    //output Clk_out_EXMEM

//////////////////////
    output MemtoReg_out_MEM, 
    //output [31:0] ALUAddResult_out_MEM, 
    output PCSrc_MEM, ALUResult_out_MEM, 
    output [31:0] mux2_result_out_MEM, 
    output [31:0] ReadData_MEM, 
    output RegWrite_out_MEM,
    output Clk_out_MEM
                     
                     );
                     
                     
    /////wires for ID_EX output
    wire [31:0] ReadData1_out_IDEX;
    wire [31:0] ReadData2_out_IDEX;
    wire [31:0] PCAddResult_out_IDEX;
    wire [5:0] ALUOp_out_IDEX;
    wire [31:0] signExtend_out_IDEX;
    wire [4:0] rt_out_IDEX;
    wire [4:0] rd_out_IDEX;
    wire ALUSrc_out_IDEX;
    wire RegDst_out_IDEX;
    
    //////wires for EX_MEM output
    wire MemWrite_out_EXMEM;
    wire MemRead_out_EXMEM;
    wire Branch_out_EXMEM;
    wire [31:0] ALUAddResult_out_EXMEM; 
    wire Zero_out_EXMEM;
    wire [31:0] ALUResult_out_EXMEM;
    wire [31:0] ReadData2_out_EXMEM;
    
    
    
    //ID_EX(PCAddResult_in_IDEX, ReadData1_in_IDEX, ReadData2_in_IDEX, signExtend_in_IDEX, rt_in_IDEX, rd_in_IDEX, RegWrite_in_IDEX, 
    //         MemtoReg_in_IDEX, Branch_in_IDEX, MemRead_in_IDEX, MemWrite_in_IDEX, RegDst_in_IDEX, ALUOp_in_IDEX, ALUSrc_in_IDEX, 
    //         PCAddResult_out_IDEX, ReadData1_out_IDEX, ReadData2_out_IDEX, signExtend_out_IDEX, 
    //         rt_out_IDEX, rd_out_IDEX, RegWrite_out_IDEX, MemtoReg_out_IDEX, Branch_out_IDEX, MemRead_out_IDEX, MemWrite_out_IDEX, 
    //         RegDst_out_IDEX, ALUOp_out_IDEX, ALUSrc_out_IDEX,
    //         Clk_in_IDEX, Clk_out_IDEX); 
    ID_EX a1(PCAddResult_in_IDEX, ReadData1_in_IDEX, ReadData2_in_IDEX, signExtend_in_IDEX, rt_in_IDEX, rd_in_IDEX, RegWrite_in_IDEX, 
             MemtoReg_in_IDEX, Branch_in_IDEX, MemRead_in_IDEX, MemWrite_in_IDEX, RegDst_in_IDEX, ALUOp_in_IDEX, ALUSrc_in_IDEX, 
             PCAddResult_out_IDEX, ReadData1_out_IDEX, ReadData2_out_IDEX, signExtend_out_IDEX, 
             rt_out_IDEX, rd_out_IDEX, RegWrite_out_IDEX, MemtoReg_out_IDEX, Branch_out_IDEX, MemRead_out_IDEX, MemWrite_out_IDEX, 
             RegDst_out_IDEX, ALUOp_out_IDEX, ALUSrc_out_IDEX,
             Clk_in_IDEX, Clk_out_IDEX);
             
    
    //module stage_EX (RegWrite_in_EX, MemtoReg_in_EX, Branch_in_EX, MemRead_in_EX, MemWrite_in_EX, RegDst_EX, ALUOp_EX, 
    //             ALUSrc_EX, 
    //             PCAddResult_EX, ReadData1_EX, ReadData2_in_EX, SignExtResult_EX, rt_EX, rd_EX, 
    //             RegWrite_out_EX, MemtoReg_out_EX, 
    //             Branch_out_EX, MemRead_out_EX, MemWrite_out_EX, ALUAddResult_EX, Zero_EX, ALUResult_EX, ReadData2_out_EX, 
    //             mux2_result_EX, Clk_in_EX, Clk_out_EX);
    stage_EX a2(RegWrite_out_IDEX, MemtoReg_out_IDEX, Branch_out_IDEX, MemRead_out_IDEX, MemWrite_out_IDEX, RegDst_out_IDEX, ALUOp_out_IDEX, 
                ALUSrc_out_IDEX, 
                PCAddResult_out_IDEX, ReadData1_out_IDEX, ReadData2_out_IDEX, signExtend_out_IDEX, rt_out_IDEX, rd_out_IDEX,
                RegWrite_out_EX, MemtoReg_out_EX, 
                Branch_out_EX, MemRead_out_EX, MemWrite_out_EX, ALUAddResult_EX, Zero_EX, ALUResult_EX, ReadData2_out_EX, 
                mux2_result_EX, Clk_out_IDEX, Clk_out_EX);
                
                
    //module EX_MEM(MemWrite_in_EXMEM, MemRead_in_EXMEM, Branch_in_EXMEM, MemtoReg_in_EXMEM, RegWrite_in_EXMEM, 
    //              ALUAddResult_in_EXMEM, Zero_in_EXMEM, ALUResult_in_EXMEM, ReadData2_in_EXMEM, mux2_Result_in_EXMEM,
    //              MemWrite_out_EXMEM, MemRead_out_EXMEM, Branch_out_EXMEM, MemtoReg_out_EXMEM, RegWrite_out_EXMEM, ALUAddResult_out_EXMEM, 
    //              Zero_out_EXMEM, ALUResult_out_EXMEM, 
    //              ReadData2_out_EXMEM, mux2_Result_out_EXMEM,
    //              Clk_in_EXMEM, Clk_out_EXMEM);
    EX_MEM a3(MemWrite_out_EX, MemRead_out_EX, Branch_out_EX, MemtoReg_out_EX, RegWrite_out_EX,
              ALUAddResult_EX, Zero_EX, ALUResult_EX, ReadData2_out_EX, mux2_result_EX, 
              MemWrite_out_EXMEM, MemRead_out_EXMEM, Branch_out_EXMEM, MemtoReg_out_EXMEM, RegWrite_out_EXMEM, ALUAddResult_out_EXMEM, 
              Zero_out_EXMEM, ALUResult_out_EXMEM, 
              ReadData2_out_EXMEM, mux2_Result_out_EXMEM,
              Clk_out_EX, Clk_out_EXMEM);
              
              
    //stage_MEM (MemWrite_MEM, MemRead_MEM, Branch_MEM, MemtoReg_in_MEM, RegWrite_in_MEM, ALUAddResult_in_MEM, 
    //             Zero_MEM, ALUResult_in_MEM, ReadData2_MEM, 
    //             mux2_result_in_MEM, MemtoReg_out_MEM, PCSrc_MEM, ALUResult_out_MEM, mux2_result_out_MEM, ReadData_MEM, RegWrite_out_MEM,
    //             Clk_in_MEM, Clk_out_MEM);
    stage_MEM a4(MemWrite_out_EXMEM, MemRead_out_EXMEM, Branch_out_EXMEM, MemtoReg_out_EXMEM, RegWrite_out_EXMEM, ALUAddResult_out_EXMEM,
                 Zero_out_EXMEM, ALUResult_out_EXMEM, ReadData2_out_EXMEM, 
                 mux2_Result_out_EXMEM, MemtoReg_out_MEM, PCSrc_MEM, ALUResult_out_MEM, mux2_result_out_MEM, ReadData_MEM, RegWrite_out_MEM,
                 Clk_out_EXMEM, Clk_out_MEM);



endmodule
