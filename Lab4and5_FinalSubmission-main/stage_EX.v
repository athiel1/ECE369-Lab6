`timescale 1ns / 1ps
module stage_EX (RegWrite_in_EX, MemtoReg_in_EX, Branch_in_EX, MemRead_in_EX, MemWrite_in_EX, RegDst_EX, 
                 ALUOp_EX, ALUSrc_EX, PCAddResult_EX, ReadData1_EX, ReadData2_in_EX, SignExtResult_EX, 
                 rt_EX, rd_EX, RegWrite_out_EX, MemtoReg_out_EX, 
                 Branch_out_EX, MemRead_out_EX, MemWrite_out_EX, ALUAddResult_EX, Zero_EX, ALUResult_EX, 
                 ReadData2_out_EX, mux2_result_EX, size_in_EX, size_out_EX, JR_in_EX, JR_out_EX, special_rt_EX, j_and_jal_in_EX, j_and_jal_out_EX);

  input RegWrite_in_EX;
  input MemtoReg_in_EX;
  input Branch_in_EX;
  input MemRead_in_EX;
  input MemWrite_in_EX;
  input RegDst_EX;
  input [5:0] ALUOp_EX;
  input ALUSrc_EX;
  input [31:0] PCAddResult_EX;
  input [31:0] ReadData1_EX;
  input [31:0] ReadData2_in_EX;
  input [31:0] SignExtResult_EX;
  input [4:0] rt_EX;
  input [4:0] rd_EX;
  input [1:0] size_in_EX;
  input JR_in_EX;
  input j_and_jal_in_EX;
  input special_rt_EX;
  //input Clk_in;

  output RegWrite_out_EX;
  output MemtoReg_out_EX;
  output Branch_out_EX;
  output MemRead_out_EX;
  output MemWrite_out_EX;
  output [31:0] ALUAddResult_EX;
  output Zero_EX;
  output [31:0] ALUResult_EX;
  output [31:0] ReadData2_out_EX;
  output [4:0] mux2_result_EX;
  output [1:0] size_out_EX;
  output JR_out_EX;
  output j_and_jal_out_EX;

  wire [31:0] SL_result_EX;
  wire [31:0] mux1_result_EX;
  wire [5:0] ALUControl_EX;
  wire shift_sel;
  wire [31:0] mux8_result_EX;
  wire [31:0] out_ze;
  wire [31:0] rt_extended;
  wire [31:0] mux9_result_EX;

  assign RegWrite_out_EX = RegWrite_in_EX;
  assign MemtoReg_out_EX = MemtoReg_in_EX;
  assign Branch_out_EX = Branch_in_EX;
  assign MemRead_out_EX = MemRead_in_EX;
  assign MemWrite_out_EX = MemWrite_in_EX;
  assign ReadData2_out_EX = ReadData2_in_EX;
  assign size_out_EX = size_in_EX;
  assign JR_out_EX = JR_in_EX;
  assign j_and_jal_out_EX = j_and_jal_in_EX;

  //ShiftLeft2(in, out);
  //ShiftLeft2 c1(SignExtResult_EX, SL_result_EX);
  
  //ALUAdd(A, B, ALUAddResult);
  //ALUAdd c2(PCAddResult_EX, SL_result_EX, ALUAddResult_EX);

  //Mux32Bit2To1(inA, inB, sel, out);
  Mux32Bit2To1 c3(ReadData2_in_EX, SignExtResult_EX, ALUSrc_EX, mux1_result_EX);
  
  //ZeroExtend5Bit(shamt, out);
  ZeroExtend5Bit ze(SignExtResult_EX[10:6], out_ze);
  
  //Mux32Bit2To1(inA, inB, sel, out);
  Mux32Bit2To1 mux8(ReadData1_EX, out_ze, shift_select, mux8_result_EX);

  //ALUControl(ALUOp, funct, ALUControl, shift_select);
  ALUControl c4(ALUOp_EX, SignExtResult_EX[5:0], ALUControl_EX, shift_select);    // if there is an error, we want 6 bits from SignExtResult

  //ALU32Bit(ALUControl, A, B, ALUResult, Zero);
  ALU32Bit c5(ALUControl_EX, mux8_result_EX, mux9_result_EX, ALUResult_EX, Zero_EX);

  //Mux5Bit2To1(inA, inB, sel, out);
  Mux5Bit2To1 c6(rt_EX, rd_EX, RegDst_EX, mux2_result_EX);
  
  //ZeroExtend5Bit(shamt, out);
  ZeroExtend5Bit zert(rt_EX, rt_extended);
  
  //Mux32Bit2To1(inA, inB, sel, out);
  Mux32Bit2To1 mux9(mux1_result_EX, rt_extended, special_rt_EX, mux9_result_EX);

  

endmodule
