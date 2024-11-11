module stage_WB (ReadData_WB, ALUResult_WB, MemtoReg_WB, mux3_result_WB);

  input [31:0] ReadData_WB;
  input [31:0] ALUResult_WB;
  input MemtoReg_WB;
  output [31:0] mux3_result_WB;

  //Mux32Bit2To1(inA, inB, sel, out);
  Mux32Bit2To1 e1(ReadData_WB, ALUResult_WB, MemtoReg_WB, mux3_result_WB);
  

endmodule
