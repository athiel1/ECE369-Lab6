`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - pc_register.v
// Description - 32-Bit program counter (PC) register.
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module.  
// You need to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000H).
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(Address, PCResult, Rst, Clk, PCWrite);

	input [31:0] Address;
	input Rst, Clk;
	input PCWrite;

	output reg [31:0] PCResult;
	
	initial begin
	   PCResult <= 32'h00000000;
	end

    /* Please fill in the implementation here... */
	always @(posedge Clk or posedge Rst) begin
        if (Rst) begin
            PCResult <= 32'b0; // Reset the PC to 0
        end else begin
            if (PCWrite)
                PCResult <= Address; // Update PC with the Address
        end
        $display ("PC = %d", PCResult);
    end
    
    

endmodule

