`timescale 1ns / 1ps

module stage_IF_tb;

    reg Rst;
    reg Clk_in;
    reg PCSrc;               // Initialize PCSrc
    reg [31:0] AddALU_out_MEM;
    reg JR;
    reg [31:0] ReadData1_ID;

    wire [31:0] Instruction_IF;
    wire [31:0] PCAdder_out_IF;

    // Instantiate the stage_IF module
    stage_IF DUT (
        .PCSrc(PCSrc),
        .AddALU_out_MEM(AddALU_out_MEM),
        .JR(JR),
        .ReadData1_ID(ReadData1_ID),
        .Instruction_IF(Instruction_IF),
        .PCAdder_out_IF(PCAdder_out_IF),
        .Clk_in(Clk_in),
        .Rst(Rst)
    );

    initial begin
        Clk_in = 0;          // Initialize clock
        Rst = 1;             // Apply reset
        PCSrc = 1'b0;        // Initialize PCSrc to 0
        AddALU_out_MEM = 32'h00000000; // Example initialization
        JR = 0;
        ReadData1_ID = 32'h00000000; // Example initialization
        
        #5 Rst = 0;         // Release reset
        #5 PCSrc = 1'b0;    // Set to known values as required

        // Clock generation
        forever #5 Clk_in = ~Clk_in; // Toggle clock every 5ns
    end

    always @(posedge Clk_in) begin
        $display("PCSrc = %b, AddALU_out_MEM = %h, JR = %b", PCSrc, AddALU_out_MEM, JR);
        // Add more signals to display as necessary
    end

endmodule
