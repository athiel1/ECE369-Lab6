`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;


	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

    integer i;
    integer j;
	initial begin
	
        RegWrite <= 0;
        WriteRegister <= 5'b0;
        WriteData <= 32'b0;
        ReadRegister1 <= 5'b0;
        ReadRegister2 <= 5'b0;
        
        
        #20;
        
        RegWrite <= 1'b1;
        
        for (i = 8; i <= 25; i = i + 1) begin
            WriteRegister <= i;
            WriteData <= i * 32'h11111111;
            #20;
            $display("Writing %h to Register %0d", WriteData, WriteRegister);
        end
        
        RegWrite <= 1'b0;
        
        #20
        
        for (j = 8; j <= 24; j = j + 2) begin
            ReadRegister1 <= j;
            ReadRegister2 <= j + 1;
            #20;
            
            $display("Read from Register %0d: %h", j, ReadData1);
            $display("Read from Register %0d: %h", j+1, ReadData2);
        end
        
        
	end

endmodule
