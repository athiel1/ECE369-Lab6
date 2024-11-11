`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk_in, MemWrite, MemRead, size, ReadData); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk_in;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    input [1:0] size;

    output reg [31:0] ReadData; // Contents of memory location at Address

    reg[31:0] memory[1023:0];
    
    initial begin
    
        //$readmemh("C:/Users/megzu/OneDrive - University of Arizona/ECE 369/Lab 4/MIPS tests/data_memory.mem", memory);
        //$readmemh("C:/Users/meganzupancic/Downloads/data_memory.mem", memory); 
        $readmemh("data_memory.mem", memory);
    
    end
    
    //always @(posedge Clk_in) begin
    always @(negedge Clk_in) begin  // store
        if (MemWrite == 1) begin
            case (size)
                2'b00:
                    memory[Address[11:2]] <= WriteData;  // store word
                2'b01:
                    memory[Address[11:2]][(Address[1:0] * 8) +: 8] <= WriteData[7:0];  // store byte
                2'b10:
                    memory[Address[11:2]][(Address[1] * 16) +: 16] <= WriteData[15:0];  // store halfword
            endcase
        end
        
        else if (MemRead == 1) begin
            case (size)
                2'b00:
                    ReadData <= memory[Address[11:2]];  // load word
                2'b01:
                    ReadData <= {{24{memory[Address[11:2]][(Address[1:0] * 8) + 7]}}, 
                                memory[Address[11:2]][(Address[1:0] * 8) +: 8]}; // Load byte (sign-extended)
                2'b10:
                    ReadData <= {{16{memory[Address[11:2]][(Address[1] * 16) + 15]}}, 
                                memory[Address[11:2]][(Address[1] * 16) +: 16]}; // Load halfword (sign-extended)
            endcase
        end 
        else begin
            ReadData <= 32'b0;
        end
    end
    

endmodule




////////////////NOTE ON SIGN EXTENDED//////////////////////////
//Loading the Halfword:

// memory[Address[11:2]] accesses the word in memory where the halfword is stored.
// Since memory is organized in 32-bit words, you access the correct word using the address bits [11:2].
// memory[Address[11:2]][15:0] extracts the lower 16 bits of that 32-bit word, which represents the halfword.
// Sign Extension:

// The expression {{16{memory[Address[11:2]][15]}}, memory[Address[11:2]][15:0]} does the sign extension.
// memory[Address[11:2]][15] checks the most significant bit of the halfword (the 16th bit of the lower 16 bits). 
// If this bit is 1, it indicates that the halfword represents a negative number in two's complement.
// {{16{...}}} creates a 16-bit value filled with either 1s (if the halfword is negative) or 0s (if it is positive). 
// This effectively extends the sign bit to fill the upper 16 bits of the final 32-bit result.

////////////////////////////////////////////
