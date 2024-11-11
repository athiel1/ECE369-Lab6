`timescale 1ns / 1ps

module ALUControl_tb;

    // Inputs
    reg [5:0] ALUOp;
    reg [5:0] funct;

    // Output
    wire [5:0] ALUControl;

    // Instantiate the ALUControl module
    ALUControl uut (
        .ALUOp(ALUOp), 
        .funct(funct), 
        .ALUControl(ALUControl)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        ALUOp = 6'b000000;  // R-type instruction
        funct = 6'b100000;  // ADD function
        #10; // Wait for 10 ns

        // Test Case 1: R-type instruction, ADD (funct = 100000)
        ALUOp = 6'b000000; 
        funct = 6'b100000;  // Expected ALUControl = 6'b100000 (ADD)
        #10;

        // Test Case 2: R-type instruction, SUB (funct = 100010)
        ALUOp = 6'b000000; 
        funct = 6'b100010;  // Expected ALUControl = 6'b100010 (SUB)
        #10;

        // Test Case 3: R-type instruction, AND (funct = 100100)
        ALUOp = 6'b000000; 
        funct = 6'b100100;  // Expected ALUControl = 6'b100100 (AND)
        #10;

        // Test Case 4: LW instruction (ALUOp = 100011)
        ALUOp = 6'b100011; 
        funct = 6'bxxxxxx;  // Expected ALUControl = 6'b100000 (ADD for load/store)
        #10;

        // Test Case 5: BEQ instruction (ALUOp = 000100)
        ALUOp = 6'b000100; 
        funct = 6'bxxxxxx;  // Expected ALUControl = 6'b000100 (BEQ)
        #10;

        // Test Case 6: J instruction (ALUOp = 000010)
        ALUOp = 6'b000010; 
        funct = 6'bxxxxxx;  // Expected ALUControl = 6'b000010 (J)
        #10;

        // Test Case 7: ORI instruction (ALUOp = 001101)
        ALUOp = 6'b001101; 
        funct = 6'bxxxxxx;  // Expected ALUControl = 6'b100101 (ORI)
        #10;

        // Test Case 8: MUL instruction (R-type funct = 011000)
        ALUOp = 6'b000000; 
        funct = 6'b011000;  // Expected ALUControl = 6'b011000 (MUL)
        #10;

        // Finish the simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time = %0d, ALUOp = %b, funct = %b, ALUControl = %b", $time, ALUOp, funct, ALUControl);
    end

endmodule
