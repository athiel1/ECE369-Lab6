`timescale 1ns / 1ps

module ALU32Bit_tb;

    // Inputs
    reg [5:0] ALUControl;
    reg [5:0] A;
    reg [31:0] B;

    // Outputs
    wire [31:0] ALUResult;
    wire Zero;

    // Instantiate the ALU
    ALU32Bit uut (
        .ALUControl(ALUControl),
        .A(A),
        .B(B),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    // Test procedure
    initial begin
        // Test case 1: Addition
        A = 32'd10; B = 32'd20; ALUControl = 6'b100000; // ADD
        #10; // Wait for 10 ns
        $display("ADD: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 2: Subtraction
        A = 32'd30; B = 32'd20; ALUControl = 6'b100010; // SUB
        #10;
        $display("SUB: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 3: Multiplication
        A = 32'd3; B = 32'd7; ALUControl = 6'b011000; // MUL
        #10;
        $display("MUL: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 4: AND
        A = 32'd15; B = 32'd8; ALUControl = 6'b100100; // AND
        #10;
        $display("AND: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 5: OR
        A = 32'd5; B = 32'd3; ALUControl = 6'b100101; // OR
        #10;
        $display("OR: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 6: XOR
        A = 32'd12; B = 32'd7; ALUControl = 6'b100110; // XOR
        #10;
        $display("XOR: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 7: Shift Left Logical
        A = 32'd1; B = 32'd2; ALUControl = 6'b000000; // SLL
        #10;
        $display("SLL: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 8: Shift Right Logical
        A = 32'd4; B = 32'd1; ALUControl = 6'b000010; // SRL
        #10;
        $display("SRL: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 9: Set Less Than
        A = 32'd10; B = 32'd20; ALUControl = 6'b101010; // SLT
        #10;
        $display("SLT: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

        // Test case 10: Branch Equal
        A = 32'd5; B = 32'd5; ALUControl = 6'b000100; // BEQ
        #10;
        $display("BEQ: A=%d, B=%d, Zero=%b", A, B, Zero);

        // Test case 11: Branch Not Equal
        A = 32'd5; B = 32'd4; ALUControl = 6'b000101; // BNE
        #10;
        $display("BNE: A=%d, B=%d, Zero=%b", A, B, Zero);

        // Test case 12: Greater Than Zero
        A = 32'd1; ALUControl = 6'b000111; // BGTZ
        #10;
        $display("BGTZ: A=%d, Zero=%b", A, Zero);

        // Test case 13: Less Than or Equal to Zero
        A = 32'd0; ALUControl = 6'b000110; // BLEZ
        #10;
        $display("BLEZ: A=%d, Zero=%b", A, Zero);

        // End the simulation
        $finish;
    end

endmodule
