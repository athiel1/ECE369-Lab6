`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Team Members: Megan Zupancic, Annie Thiel
// Overall percent effort of each team meber: Megan - 50%, Annie - 50%
// 
// ECE369A - Computer Architecture
// Laboratory 3 (PostLab)
// Module - InstructionFetchUnit.v
// Description - Fetches the instruction from the instruction memory based on 
//               the program counter (PC) value.
// INPUTS:-
// Reset: 1-Bit input signal. 
// Clk: Input clock signal.
//
// OUTPUTS:-
// Instruction: 32-Bit output instruction from the instruction memory. 
//              Decimal value diplayed 
// PCResult: 32-Bit output PCResult from the program counter. 
//              Decimal value diplayed 
// FUNCTIONALITY:-
// Please connect up the following implemented modules to create this
// 'InstructionFetchUnit':-
//   (a) ProgramCounter.v
//   (b) PCAdder.v
//   (c) InstructionMemory.v
// Connect the modules together in a testbench so that the instruction memory
// outputs the contents of the next instruction indicated by the memory location
// in the PC at every clock cycle. Please initialize the instruction memory with
// some preliminary values for debugging purposes.
//
// @@ The 'Reset' input control signal is connected to the program counter (PC) 
// register which initializes the unit to output the first instruction in 
// instruction memory.
// @@ The 'Instruction' output port holds the output value from the instruction
// memory module.
// @@ The 'Clk' input signal is connected to the program counter (PC) register 
// which generates a continuous clock pulse into the module.
////////////////////////////////////////////////////////////////////////////////

module stage_IF(PCSrc, AddALU_out_MEM, JR, ReadData1_ID, Instruction_IF, 
                        PCAdder_out_IF, Clk_in, Rst, PC_pin, j_and_jal, mux3_result);  

    input Rst, Clk_in;
    input PCSrc;
    input [31:0] AddALU_out_MEM;
    input JR;
    input [31:0] ReadData1_ID;
    input j_and_jal;
    input [31:0] mux3_result;
    
    output [31:0] Instruction_IF;
    output [31:0] PCAdder_out_IF;
    output [31:0] PC_pin;

    wire [31:0] mux4_result_IF;
    wire [31:0] mux5_result_IF;
    wire [31:0] mux10_result_IF;
    wire [31:0] PCResult_IF;
    
    //always @(posedge Clk_in) begin
        //$display("Mux 4 Result = %h", mux4_result_IF);
        //$display("Mux 5 Result = %h", mux5_result_IF);
        //$display("PCSrc = %b", PCSrc);
        //$display("PCAdder_out_IF = %h", PCAdder_out_IF);
    //end
    
    //wire ClkOut;
    //wire [31:0] PCResult; //do we need to declare this again?
    

    //Mux32Bit2To1(inA, inB, sel, out);
    Mux32Bit2To1 mux4(PCAdder_out_IF, AddALU_out_MEM, PCSrc, mux4_result_IF);
    
    //Mux32Bit2To1(inA, inB, sel, out);
    Mux32Bit2To1 mux5(mux4_result_IF, mux3_result, JR, mux5_result_IF);
    
    //Mux32Bit2To1(inA, inB, sel, out);
    Mux32Bit2To1 mux10(mux5_result_IF, mux3_result, j_and_jal, mux10_result_IF);
    
    //ProgramCounter(Address, PCResult, Rst, Clk);
    ProgramCounter a3(mux10_result_IF, PCResult_IF, Rst, Clk_in);
    
    //PCAdder(PCResult, PCAddResult);
    PCAdder a4(PCResult_IF, PCAdder_out_IF);
    
    //InstructionMemory(Address, Instruction, Clk_in);
    InstructionMemory a5(PCResult_IF, Instruction_IF);
    
    assign PC_pin = PCResult_IF;
    
    
endmodule
