`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

    integer i;
	initial begin
	
    // Initialize signals
        MemWrite = 0;
        MemRead = 0;

        // Test 1: Write data to memory
        Address = 32'h00000000; // Write to address 0
        WriteData = 32'hDEADBEEF; // Data to write
        MemWrite = 1; // Enable write
        #20; // Wait for a clock cycle
        MemWrite = 0; // Disable write
        #20; // Wait for the next clock cycle

        // Test 2: Read data from memory
        Address = 32'h00000000; // Read from address 0
        MemRead = 1; // Enable read
        #20; // Wait for a clock cycle
        MemRead = 0; // Disable read
        // Display read data
        $display("Read from Address 0: %h", ReadData); // Should print DEADBEEF

        // Test 3: Write another value to memory
        Address = 32'h00000004; // Write to address 4
        WriteData = 32'hBEEFCAFE; // New data to write
        MemWrite = 1; // Enable write
        #20; // Wait for a clock cycle
        MemWrite = 0; // Disable write
        #20; // Wait for the next clock cycle

        // Test 4: Read data from memory
        Address = 32'h00000004; // Read from address 4
        MemRead = 1; // Enable read
        #20; // Wait for a clock cycle
        MemRead = 0; // Disable read
        // Display read data
        $display("Read from Address 4: %h", ReadData); // Should print BEEFCAFE

        // Test 5: Write and read multiple values
        for (i = 0; i < 5; i = i + 1) begin
            Address = 32'h00000008 + (i * 4); // Address 8, 12, 16, 20, 24
            WriteData = 32'hAABBCCDD + i; // Different data to write
            MemWrite = 1; // Enable write
            #20; // Wait for a clock cycle
            MemWrite = 0; // Disable write
            #20; // Wait for the next clock cycle

            // Read back the data
            MemRead = 1; // Enable read
            #20; // Wait for a clock cycle
            MemRead = 0; // Disable read
            // Display read data
            $display("Read from Address %0h: %h", Address, ReadData); // Should print the written data
        end

	end

endmodule
