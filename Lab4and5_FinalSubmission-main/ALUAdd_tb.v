`timescale 1ns / 1ps

module ALUAdd_tb;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;

    // Outputs
    wire [31:0] ALUAddResult;

    // Instantiate the ALUAdd module
    ALUAdd uut (
        .A(A), 
        .B(B), 
        .ALUAddResult(ALUAddResult)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        A = 32'd0;
        B = 32'd0;
        #10;

        // Test Case 1: A = 5, B = 10
        A = 32'd5;
        B = 32'd10;  // 5 + 10 = 15
        #10;

        // Test Case 2: A = 1024, B = 2048
        A = 32'd1024;
        B = 32'd2048;  // 1024 + 2048 = 3072
        #10;

        // Test Case 3: A = -5, B = 10 (two's complement)
        A = -32'd5;
        B = 32'd10;  // -5 + 10 = 5
        #10;

        // Test Case 4: A = -10, B = -20
        A = -32'd10;
        B = -32'd20;  // -10 + -20 = -30
        #10;

        // Test Case 5: A = 32'hFFFFFFFF (which is -1), B = 1
        A = 32'hFFFFFFFF;
        B = 32'd1;  // -1 + 1 = 0
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time = %0d, A = %d, B = %d, ALUAddResult = %d", $time, A, B, ALUAddResult);
    end

endmodule
