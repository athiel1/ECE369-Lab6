`timescale 1ns / 1ps

module ShiftLeft2_tb;

    // Inputs
    reg [31:0] in;

    // Outputs
    wire [31:0] out;

    // Instantiate the ShiftLeft2 module
    ShiftLeft2 uut (
        .in(in),
        .out(out)
    );

    // Test stimulus
    initial begin
        // Initialize input
        in = 32'd0;
        #10;

        // Test Case 1: Shift value 1
        in = 32'd1;  // 1 * 4 = 4
        #10;
        
        // Test Case 2: Shift value 3
        in = 32'd3;  // 3 * 4 = 12
        #10;

        // Test Case 3: Shift value 1024
        in = 32'd1024;  // 1024 * 4 = 4096
        #10;

        // Test Case 4: Shift value -5 (two's complement)
        in = -32'd5;  // -5 * 4 = -20
        #10;

        // Test Case 5: Shift maximum 32-bit value
        in = 32'hFFFFFFFF;  // 0xFFFFFFFF * 4 = 0xFFFFFFFC (-1 becomes -4)
        #10;

        // Finish simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time = %0d, Input = %d, Output = %d", $time, in, out);
    end

endmodule
