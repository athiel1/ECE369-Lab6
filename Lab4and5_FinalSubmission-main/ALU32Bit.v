`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [5:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A;	    // inputs
	input [31:0] B;

	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0

    /* Please fill in the implementation here... */

	// Add: add, addi, lw, sw, sb, lh, lb, sh
	// Subtract: sub, beq, bne, slt, slti
	// Multiply: mul
	// Branch if greater than or equal to zero: bgez
	// Branch on greater than zero: bgtz
	// Branch on less than or equal to zero: blez
	// Branch on less than zero: bltz
	// Logical ands: and, andi
	// Logical or: or, ori
	// Logical nor: nor
	// Logical xor: xor, xori
	// Shift left logical: sll
	// Shift right logical: srl


	always @(*) begin
	
	   ALUResult <= 0;  // default value
	   Zero <= 0;

		case (ALUControl)
			6'b100000: // ADD, Load byte, Store byte, Store half, Load half
				ALUResult <= A + B;
			6'b100010: // SUB
				ALUResult <= A - B;  // might have to change
			6'b011000: // MUL
				ALUResult <= A * B;
			6'b100100: // AND
				ALUResult <= A & B;
			6'b100101: // OR
				ALUResult <= A | B;
			6'b100111: // NOR
				ALUResult <= ~($signed(A | B));
			6'b100110: // XOR
				ALUResult <= A ^ B;
			6'b000000: // sll
				ALUResult <= B * (2**A);
			6'b111111: // srl               // manually changed to all 1s 
				ALUResult <= B / (2**A);
			6'b101010: // slt
				ALUResult <= (A < B) ? 32'b1 : 32'b0;
			6'b001000: // jr
				ALUResult <= A;

			6'b000001: begin // BGEZ & BLTZ
				if (B == 1) begin  //BGEZ
					Zero <= ($signed(A) >= 0) ? 1'b1 : 1'b0;
				end
				else if (B == 0) begin  //BLTZ
					Zero <= ($signed(A) < 0) ? 1'b1 : 1'b0;
				end
			end
			///////////////////
		  	//6'b000100: // BEQ
			//	ALUResult = (A == B) ? 32'b0 : 32'b1;
		  	//6'b000101: // BNE
			//	ALUResult = (A != B) ? 32'b0 : 32'b1;
		  	//6'b000111: // BGTZ
			//	ALUResult = (A > 0) ? 32'b0 : 32'b1;
		  	//6'b000110: // BLEZ
			//	ALUResult = (A <= 0) ? 32'b0 : 32'b1;

			
			6'b000100: // BEQ
    				Zero <= ($signed(A) == $signed(B)) ? 1'b1 : 1'b0;
			6'b000101: // BNE
   				    Zero <= ($signed(A) != $signed(B)) ? 1'b1 : 1'b0;
			6'b000111: // BGTZ
    				Zero <= ($signed(A) > 0) ? 1'b1 : 1'b0;
			6'b000110: // BLEZ
    				Zero <= ($signed(A) <= 0) ? 1'b1 : 1'b0;
			
		  	6'b000010: begin // J
			  	ALUResult <= B * 4;
			  	Zero <= 1'b1;
			end
		  	6'b000011: begin // JAL
			  	ALUResult <= B * 4;
			  	Zero <= 1'b1;
			end
			default: begin
				ALUResult <= 32'b0;
				Zero <= 1'b0;
			end
			
		endcase
		
	end

endmodule





			
