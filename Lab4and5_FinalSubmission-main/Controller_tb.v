`timescale 1ns / 1ps

module Controller_tb;

    // Inputs
    reg Clk;
    reg Rst;
    reg [31:0] Instruction;
    reg Zero;

    // Outputs
    wire RegDst;
    wire [1:0] ALUOp;
    wire ALUZero;
    wire ALUSrc;
    wire Branch;
    wire MemRead;
    wire MemWrite;
    wire MemtoReg;
    wire RegWrite;
    wire PCSrc;
    wire Debug; // Include debug signal

    // Instantiate the Unit Under Test (UUT)
    Controller uut (
        .Clk(Clk), 
        .Rst(Rst), 
        .Instruction(Instruction), 
        .Zero(Zero), 
        .RegDst(RegDst), 
        .ALUOp(ALUOp), 
        .ALUZero(ALUZero), 
        .ALUSrc(ALUSrc), 
        .Branch(Branch), 
        .MemRead(MemRead), 
        .MemWrite(MemWrite), 
        .MemtoReg(MemtoReg), 
        .RegWrite(RegWrite), 
        .PCSrc(PCSrc),
        .Debug(Debug) // Connect debug signal
    );

    // Clock Generation
    always #5 Clk = ~Clk;

    initial begin
        // Initialize Inputs
        Clk = 0;
        Rst = 0;
        Instruction = 32'b0;
        Zero = 0;

        // Test Reset Behavior
        Rst = 1; // Assert reset
        #10;     // Wait for 10 time units
        Rst = 0; // Release reset
        #10;     // Wait for 10 time units
        

        // Test R-Type instruction (e.g., add)
        Instruction = 32'b000000_00000_00000_00000_00000_100000; // R-type (funct=100000 for ADD)
        #10;
        $display("R-Type Instruction:");
        $display("RegDst: %b, ALUOp: %b, ALUSrc: %b, Branch: %b, MemRead: %b, MemWrite: %b, MemtoReg: %b, RegWrite: %b, PCSrc: %b, Debug: %b", 
            RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, Debug);

        // Test Load instruction (lw)
        Instruction = 32'b100011_00000_00001_00000_00000_000000; // opcode=100011 for lw
        #10;
        $display("Load Instruction (lw):");
        $display("RegDst: %b, ALUOp: %b, ALUSrc: %b, Branch: %b, MemRead: %b, MemWrite: %b, MemtoReg: %b, RegWrite: %b, PCSrc: %b, Debug: %b", 
            RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, Debug);

        // Test Store instruction (sw)
        Instruction = 32'b101011_00000_00001_00000_00000_000000; // opcode=101011 for sw
        #10;
        $display("Store Instruction (sw):");
        $display("RegDst: %b, ALUOp: %b, ALUSrc: %b, Branch: %b, MemRead: %b, MemWrite: %b, MemtoReg: %b, RegWrite: %b, PCSrc: %b, Debug: %b", 
            RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, Debug);

        // Test Branch instruction (beq)
        Instruction = 32'b000100_00000_00001_00000_00000_000000; // opcode=000100 for beq
        Zero = 1; // Simulate Zero signal from ALU for branch to be taken
        #10;
        $display("Branch Instruction (beq):");
        $display("RegDst: %b, ALUOp: %b, ALUSrc: %b, Branch: %b, MemRead: %b, MemWrite: %b, MemtoReg: %b, RegWrite: %b, PCSrc: %b, Debug: %b", 
            RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, Debug);

        // Test with an invalid instruction to hit the default case
        Instruction = 32'b111111_11111_11111_11111_11111_111111; // Invalid opcode
        #10;
        $display("Invalid Instruction:");
        $display("RegDst: %b, ALUOp: %b, ALUSrc: %b, Branch: %b, MemRead: %b, MemWrite: %b, MemtoReg: %b, RegWrite: %b, PCSrc: %b, Debug: %b", 
            RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite, PCSrc, Debug);

        // Finish the simulation
        // $stop; // End the simulation
    end

endmodule
