`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Megan Zupancic and Annie Thiel
// Percent Effort: 50/50
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(Instruction, WriteRegister, WriteData, RegWrite, Clk_in, ReadData1, ReadData2, RegWrite_JAL);
	//input[4:0] ReadRegister1, ReadRegister2;

	input [31:0]Instruction;
	input[4:0] WriteRegister;
	input[31:0] WriteData;
	input RegWrite;
	input RegWrite_JAL;
	//input [4:0] ReadRegister1;
	//input [4:0] ReadRegister2;
	input Clk_in;
	
	output reg [31:0] ReadData1, ReadData2;
    
	reg [31:0] RegisterFile[31:0];
	
	wire [4:0] ReadRegister1, ReadRegister2;
	
	assign ReadRegister1 = Instruction[25:21];
	assign ReadRegister2 = Instruction[20:16];
	
	initial begin
        RegisterFile[0] = 32'b0; // $zero
        // Initialize other registers if needed
        $display("RegisterFile[0] = %h", RegisterFile[000000]);
    end
    
    always @(posedge Clk_in) begin // posedge Clk
		if (RegWrite == 1 | RegWrite_JAL == 1) begin 
	       		//RegisterFile[WriteRegister] <= WriteData;
			RegisterFile[WriteRegister] <= WriteData;
			$display ("WriteRegister = %d", WriteRegister);
			$display ("WriteData = %d", WriteData);
			$display ("RegisterFile[WriteRegister] = %d", RegisterFile[WriteRegister]); 
	   	end else begin
	   	   $display ("RegWrite != 1");
	   	end
	end
	
    //$display("Read from Register %0d: %h", Instruction[25:21], ReadData1);
	always @(*) begin // negedge Clk
		//ReadData1 <= RegisterFile[ReadRegister1];
		ReadData1 <= RegisterFile[Instruction[25:21]];  // rs
		$display("Read1 from Register %0d: %h", Instruction[25:21], ReadData1);
		//ReadData2 <= RegisterFile[ReadRegister2];
		ReadData2 <= RegisterFile[Instruction[20:16]];  //rt
		$display("Read2 from Register %0d: %h", Instruction[20:16], ReadData2);
	end
	
	

endmodule



