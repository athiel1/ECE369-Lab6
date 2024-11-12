`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// ECE 369 - Lab 4
//
// Names: Megan Zupancic and Annie Thiel
// Percent Effort: 50/50
// 
//////////////////////////////////////////////////////////////////////////////////


//module Top_Level(Reset, Clk, out7, en_out);
module Top_Level(Reset, ClkOut, PC_pin_out, write_data_pin);

    input Reset;
    //input Clk;
    input ClkOut;
    
    //wire [31:0] PC_pin_out;
    //wire [31:0] write_data_pin;
    //wire ClkOut;
    
    //output [6:0] out7;
    //output [7:0] en_out;
    
    output [31:0] PC_pin_out;
    output [31:0] write_data_pin;
    
    wire [31:0] Instruction_IF;
    wire [31:0] PCAdder_out_IF;
    wire [31:0] PCAdder_out_IFID;
    wire [31:0] Instruction_out_IFID;
    wire [4:0] WriteRegister;
    wire [5:0] ALUOp_ID;
    wire [31:0] ReadData1_out_ID;
    wire [31:0] ReadData2_out_ID;
    wire [31:0] SignExtResult_ID;
    wire [31:0] PCAddResult_out_ID;
    wire [4:0] rs_ID;
    wire [4:0] rt_ID;
    wire [4:0] rd_ID;
    wire [31:0] PCAddResult_out_IDEX;
    wire [31:0] ReadData1_out_IDEX;
    wire [31:0] ReadData2_out_IDEX;
    wire [31:0] signExtend_out_IDEX;
    wire [4:0] rt_out_IDEX;
    wire [4:0] rd_out_IDEX;
    wire [5:0] ALUOp_out_IDEX;
    wire [31:0] ALUAddResult_EX;
    wire [31:0] ALUResult_EX;
    wire [31:0] ReadData2_out_EX;
    wire [4:0] mux2_result_EX;
    wire [31:0] ALUAddResult_out_EXMEM;
    wire [31:0] ALUResult_out_EXMEM;
    wire [31:0] ReadData2_out_EXMEM;
    wire [4:0] mux2_Result_out_EXMEM;
    wire [31:0] ALUResult_out_MEM;
    wire [4:0] mux2_result_out_MEM;
    wire [31:0] ReadData_MEM;
    wire [31:0] ReadData2_out_MEM;
    wire [31:0] ALUResult_out_MEMWB;
    wire [31:0] ReadData_out_MEMWB;
    wire [4:0] mux2_result_out_MEMWB;
    wire [31:0] mux3_result_WB;
    wire [1:0] size_ID;
    wire [1:0] size_out_IDEX;
    wire [1:0] size_out_EX;
    wire [1:0] size_out_EXMEM;
    wire [31:0] ALUAddResult_ID;
    
    
    //ClkDiv(Clk, Rst, ClkOut);
    //ClkDiv clock(Clk, Reset, ClkOut);
    
    
    //stage_IF(PCSrc, AddALU_out_MEM, JR, ReadData1_ID, Instruction_IF, 
    //         PCAdder_out_IF, Clk_in, Rst, PC_pin);
    stage_IF top1(PCSrc_MEM, ALUAddResult_ID, JR_out_MEMWB, mux3_result_WB, Instruction_IF, 
                    PCAdder_out_IF, ClkOut, Reset, PC_pin_out, j_and_jal_out_MEMWB, mux3_result_WB);
    
    
    //IF_ID(PCAdder_in_IFID, Instruction_in_IFID, PCAdder_out_IFID, Instruction_out_IFID, Clk_in);
    IF_ID top2(PCAdder_out_IF, Instruction_IF, PCAdder_out_IFID, Instruction_out_IFID, ClkOut, Reset);
    
    //IF_ID(PCAdder_in_IFID, Instruction_in_IFID, PCAdder_out_IFID, Instruction_out_IFID, Clk_in, Rst);
    
    
    //stage_ID (PCAddResult_in_ID, Instruction_ID, RegWrite_in, WriteRegister_in, WriteData_in,
                    //RegWrite_out_ID, MemtoReg_ID, Branch_ID, MemRead_ID, MemWrite_ID, RegDst_ID, ALUOp_ID, 
                    //ALUSrc_ID, PCAddResult_out_ID, ReadData1_out_ID, ReadData2_out_ID, SignExtResult_ID, 
                    //rt_ID, rd_ID, JR_ID, size_ID, Clk_in, write_data_pin, special_rt_ID, j_and_jal_ID,
                    //ALUAddResult_ID, rs_IFID, rt_IFID, MemRead_IDEX, RegisterRt_IDEX, RegisterRd_IDEX, PCWrite_ID, IFIDWrite_ID);
    stage_ID top3(PCAdder_out_IFID, Instruction_out_IFID, RegWrite_out_MEMWB, mux2_result_out_MEMWB, mux3_result_WB,
                    RegWrite_out_ID, MemtoReg_ID, Branch_ID, MemRead_ID, MemWrite_ID, RegDst_ID, ALUOp_ID, 
                    ALUSrc_ID, PCAddResult_out_ID, ReadData1_out_ID, ReadData2_out_ID, SignExtResult_ID, 
                    rt_ID, rd_ID, JR_ID, size_ID, ClkOut, write_data_pin, special_rt_ID, j_and_jal_ID,
                    ALUAddResult_ID, rs_ID, rt_ID, MemRead_out_IDEX, rt_out_IDEX, rd_out_IDEX, PCWrite_ID, IFIDWrite_ID);
                    
    //ID_EX(PCAddResult_in_IDEX, ReadData1_in_IDEX, ReadData2_in_IDEX, signExtend_in_IDEX, rt_in_IDEX, 
    //            rd_in_IDEX, RegWrite_in_IDEX, MemtoReg_in_IDEX, Branch_in_IDEX, MemRead_in_IDEX, 
    //            MemWrite_in_IDEX, RegDst_in_IDEX, ALUOp_in_IDEX, ALUSrc_in_IDEX, 
    //            PCAddResult_out_IDEX, ReadData1_out_IDEX, ReadData2_out_IDEX, signExtend_out_IDEX, 
    //            rt_out_IDEX, rd_out_IDEX, RegWrite_out_IDEX, MemtoReg_out_IDEX, Branch_out_IDEX, 
    //            MemRead_out_IDEX, MemWrite_out_IDEX, RegDst_out_IDEX, ALUOp_out_IDEX, ALUSrc_out_IDEX,
    //           size_in_IDEX, size_out_IDEX, Clk_in, Rst);  
    ID_EX top4(/*PCAddResult_out_ID,*/ ReadData1_out_ID, ReadData2_out_ID, SignExtResult_ID, rt_ID,
                rd_ID, RegWrite_out_ID, MemtoReg_ID, Branch_ID, MemRead_ID,
                MemWrite_ID, RegDst_ID, ALUOp_ID, ALUSrc_ID,
                /*PCAddResult_out_IDEX,*/ ReadData1_out_IDEX, ReadData2_out_IDEX, signExtend_out_IDEX, 
                rt_out_IDEX, rd_out_IDEX, RegWrite_out_IDEX, MemtoReg_out_IDEX, Branch_out_IDEX, 
                MemRead_out_IDEX, MemWrite_out_IDEX, 
                RegDst_out_IDEX, ALUOp_out_IDEX, ALUSrc_out_IDEX,
                size_ID, size_out_IDEX, ClkOut, Reset, JR_ID, JR_out_IDEX, special_rt_ID, special_rt_out_IDEX, j_and_jal_ID, j_and_jal_out_IDEX);
                
                
     //stage_EX (RegWrite_in_EX, MemtoReg_in_EX, Branch_in_EX, MemRead_in_EX, MemWrite_in_EX, RegDst_EX, 
     //            ALUOp_EX, ALUSrc_EX, PCAddResult_EX, ReadData1_EX, ReadData2_in_EX, SignExtResult_EX, 
     //            rt_EX, rd_EX, RegWrite_out_EX, MemtoReg_out_EX, 
     //            Branch_out_EX, MemRead_out_EX, MemWrite_out_EX, ALUAddResult_EX, Zero_EX, ALUResult_EX, 
     //            ReadData2_out_EX, mux2_result_EX, size_in_EX, size_out_EX, Clk_in);
     stage_EX top5(RegWrite_out_IDEX, MemtoReg_out_IDEX, Branch_out_IDEX, MemRead_out_IDEX, MemWrite_out_IDEX, RegDst_out_IDEX,
                    ALUOp_out_IDEX, ALUSrc_out_IDEX, PCAddResult_out_IDEX, ReadData1_out_IDEX, ReadData2_out_IDEX, signExtend_out_IDEX,
                    rt_out_IDEX, rd_out_IDEX, RegWrite_out_EX, MemtoReg_out_EX, 
                    Branch_out_EX, MemRead_out_EX, MemWrite_out_EX, /*ALUAddResult_EX,*/ Zero_EX, ALUResult_EX, 
                    ReadData2_out_EX, mux2_result_EX, size_out_IDEX, size_out_EX, JR_out_IDEX, JR_out_EX, special_rt_out_IDEX,
                    j_and_jal_out_IDEX, j_and_jal_out_EX);
                    
                    
     //EX_MEM(MemWrite_in_EXMEM, MemRead_in_EXMEM, Branch_in_EXMEM, MemtoReg_in_EXMEM, 
     //           RegWrite_in_EXMEM, ALUAddResult_in_EXMEM, Zero_in_EXMEM, ALUResult_in_EXMEM, 
     //           ReadData2_in_EXMEM, mux2_Result_in_EXMEM,
     //           MemWrite_out_EXMEM, MemRead_out_EXMEM, Branch_out_EXMEM, MemtoReg_out_EXMEM, 
     //           RegWrite_out_EXMEM, ALUAddResult_out_EXMEM, Zero_out_EXMEM, ALUResult_out_EXMEM, 
     //           ReadData2_out_EXMEM, mux2_Result_out_EXMEM,
     //           size_in_EXMEM, size_out_EXMEM, Clk_in, Rst);
     EX_MEM top6(MemWrite_out_EX, MemRead_out_EX, Branch_out_EX, MemtoReg_out_EX, 
                RegWrite_out_EX, /*ALUAddResult_EX,*/ Zero_EX, ALUResult_EX, 
                ReadData2_out_EX, mux2_result_EX, 
                MemWrite_out_EXMEM, MemRead_out_EXMEM, Branch_out_EXMEM, MemtoReg_out_EXMEM, 
                RegWrite_out_EXMEM, /*ALUAddResult_out_EXMEM,*/ Zero_out_EXMEM, ALUResult_out_EXMEM, 
                ReadData2_out_EXMEM, mux2_Result_out_EXMEM,
                size_out_EX, size_out_EXMEM, ClkOut, Reset, JR_out_EX, JR_out_EXMEM, j_and_jal_out_EX, j_and_jal_out_EXMEM);
                
                
      
      //stage_MEM (MemWrite_MEM, MemRead_MEM, Branch_MEM, MemtoReg_in_MEM, RegWrite_in_MEM, 
      //              /*ALUAddResult_in_MEM,*/ Zero_MEM, ALUResult_in_MEM, ReadData2_MEM, 
      //              mux2_result_in_MEM, MemtoReg_out_MEM, PCSrc_MEM, ALUResult_out_MEM, 
      //              mux2_result_out_MEM, ReadData_MEM, RegWrite_out_MEM, ReadData2_out_MEM,
      //              size_MEM, Clk_in, Rst);
      stage_MEM top7(MemWrite_out_EXMEM, MemRead_out_EXMEM, Branch_out_EXMEM, MemtoReg_out_EXMEM, RegWrite_out_EXMEM,
                        /*ALUAddResult_out_EXMEM,*/ Zero_out_EXMEM, ALUResult_out_EXMEM, ReadData2_out_EXMEM,
                        mux2_Result_out_EXMEM, MemtoReg_out_MEM, PCSrc_MEM, ALUResult_out_MEM, 
                        mux2_result_out_MEM, ReadData_MEM, RegWrite_out_MEM, ReadData2_out_MEM,
                        size_out_EXMEM, ClkOut, JR_out_EXMEM, JR_out_MEM, j_and_jal_out_EXMEM, j_and_jal_out_MEM);
                        
                        
      //MEM_WB(MemtoReg_in_MEMWB, RegWrite_in_MEMWB, ALUResult_in_MEMWB, 
      //         ReadData_in_MEMWB, mux2_result_in_MEMWB, 
      //         MemtoReg_out_MEMWB, RegWrite_out_MEMWB, ALUResult_out_MEMWB, 
      //         ReadData_out_MEMWB, mux2_result_out_MEMWB,
      //         Clk_in);
      MEM_WB top8(MemtoReg_out_MEM, RegWrite_out_MEM, ALUResult_out_MEM, 
                    ReadData_MEM, mux2_result_out_MEM, 
                    MemtoReg_out_MEMWB, RegWrite_out_MEMWB, ALUResult_out_MEMWB, 
                    ReadData_out_MEMWB, mux2_result_out_MEMWB,
                    ClkOut, Reset, JR_out_MEM, JR_out_MEMWB, j_and_jal_out_MEM, j_and_jal_out_MEMWB);
                    
                    
       //stage_WB (ReadData_WB, ALUResult_WB, MemtoReg_WB, mux3_result_WB);
       stage_WB top9(ReadData_out_MEMWB, ALUResult_out_MEMWB, MemtoReg_out_MEMWB, mux3_result_WB);
       
       
       //Two4DigitDisplay(Clk, NumberA, NumberB, out7, en_out);
       //Two4DigitDisplay display(ClkOut, write_data_pin, PC_pin_out, out7, en_out);
                   

endmodule
