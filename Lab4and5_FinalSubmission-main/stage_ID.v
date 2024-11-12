module stage_ID (PCAddResult_in_ID, Instruction_ID, RegWrite_in, WriteRegister_in, WriteData_in,
                    RegWrite_out_ID, MemtoReg_ID, Branch_ID, MemRead_ID, MemWrite_ID, RegDst_ID, ALUOp_ID, 
                    ALUSrc_ID, PCAddResult_out_ID, ReadData1_out_ID, ReadData2_out_ID, SignExtResult_ID, 
                    rt_ID, rd_ID, JR_ID, size_ID, Clk_in, write_data_pin, special_rt_ID, j_and_jal_ID,
                    ALUAddResult_ID, rs_IFID, rt_IFID, MemRead_IDEX, RegisterRt_IDEX, RegisterRd_IDEX, PCWrite_ID, IFIDWrite_ID);

  input [31:0] PCAddResult_in_ID;
  input [31:0] Instruction_ID;
  input RegWrite_in;
  input [4:0] WriteRegister_in;
  input [31:0] WriteData_in;
  input Clk_in;
  input rs_IFID;
  input rt_IFID;
  input MemRead_IDEX;
  input RegisterRt_IDEX;
  input RegisterRd_IDEX;
  
  wire [4:0] mux6_result_ID;
  wire [31:0] mux7_result_ID;  
  wire JAL_ID;
  wire RegWrite_JAL;
  //wire [31:0] SignExtResult_ID;
  wire [31:0] SL_result_ID;
  // HAZARD CONTROL
  wire hazardControl_ID;

  output RegWrite_out_ID;
  output MemtoReg_ID;
  output Branch_ID;
  output MemRead_ID;
  output MemWrite_ID;
  output RegDst_ID;
  output [5:0] ALUOp_ID;
  output ALUSrc_ID;
  output [31:0] PCAddResult_out_ID;
  output [31:0] ReadData1_out_ID;
  output [31:0] ReadData2_out_ID;
  output [31:0] SignExtResult_ID;
  output [4:0] rt_ID;
  output [4:0] rd_ID;
  output JR_ID;
  output j_and_jal_ID;
  output special_rt_ID;
  output [1:0] size_ID;
  output [31:0] write_data_pin;
  output [31:0] ALUAddResult_ID;
  output PCWrite_ID;
  output IFIDWrite_ID;

  assign PCAddResult_out_ID = PCAddResult_in_ID;
  assign rt_ID = Instruction_ID[20:16];
  assign rd_ID = Instruction_ID[15:11];
  
 //RegisterFile(Instruction, WriteRegister, WriteData, RegWrite, Clk_in, ReadData1, ReadData2, RegWrite_JAL);
  RegisterFile b1(Instruction_ID, mux6_result_ID, mux7_result_ID, RegWrite_in, Clk_in, ReadData1_out_ID, ReadData2_out_ID, RegWrite_JAL);

  //SignExtension(Instruction, out);
  SignExtension b2(Instruction_ID, SignExtResult_ID);
  
  //Hazard(MemRead, RegisterRt, RegisterRd, rs, rt, IFIDWrite, PCWrite, hazardControl);
  Hazard(MemRead_IDEX, RegisterRt_IDEX, RegisterRd_IDEX, rs_IFID, rt_IFID, IFIDWrite_ID, PCWrite_ID, hazardControl_ID); 

  //Controller(Instruction, RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite, JR, JAL, size, RegWrite_JAL, special_rt);
  Controller b3(Instruction_ID, hazardControl_ID, RegDst_ID, ALUOp_ID, ALUSrc_ID, Branch_ID, MemRead_ID, MemWrite_ID, MemtoReg_ID, RegWrite_out_ID, JR_ID, JAL_ID, size_ID, RegWrite_JAL, special_rt_ID, j_and_jal_ID);
  //Controller b3(Instruction_ID, RegDst_ID, ALUOp_ID, ALUSrc_ID, Branch_ID, MemRead_ID, MemWrite_ID, MemtoReg_ID, RegWrite_out_ID);
  
  //Mux32Bit2To1(inA, inB, sel, out);
  Mux5Bit2To1 b4(WriteRegister_in, 5'b11111, JAL_ID, mux6_result_ID);
  
  //Mux32Bit2To1(inA, inB, sel, out);
  Mux32Bit2To1 b5(WriteData_in, PCAddResult_in_ID, JAL_ID, mux7_result_ID);
  
  //ShiftLeft2(in, out);
  ShiftLeft2 b6(SignExtResult_ID, SL_result_ID);
  
  //ALUAdd(A, B, ALUAddResult);
  ALUAdd b7(PCAddResult_in_ID, SL_result_ID, ALUAddResult_ID);
  
  assign write_data_pin = mux7_result_ID;

endmodule
