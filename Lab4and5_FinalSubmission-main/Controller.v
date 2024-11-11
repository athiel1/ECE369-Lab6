`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 05:34:15 PM
// Design Name: 
// Module Name: controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller(Instruction, RegDst, ALUOp, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, RegWrite, JR, JAL, size, RegWrite_JAL, special_rt, j_and_jal);
    //input wire Clk;
    //input wire Rst;
    
    input [31:0] Instruction;
    //input Zero; might become isEqual later 
    
    output reg RegDst;
    output reg [5:0] ALUOp;
    //output reg ALUZero; // ??
    output reg ALUSrc;
    output reg Branch;
    output reg MemRead;
    output reg MemWrite;
    output reg MemtoReg;
    output reg RegWrite;
    output reg JR;
    output reg JAL;
    output reg j_and_jal;
    output reg [1:0] size;
    output reg RegWrite_JAL;
    output reg special_rt;

    wire [5:0] operation;
    assign operation = Instruction[31:26];
    

    //always @(posedge Clk or posedge Rst) begin
    always @(*) begin
       // if (Rst) begin
        //    RegDst <= 0;
         //   ALUOp <= 6'b000000;
         //   ALUSrc <= 0;
          //  Branch <= 0;
         //   MemRead <= 0;
          //  MemWrite <= 0;
         //   MemtoReg <= 0;
         //   RegWrite <= 0;
       //// end 
      //  else begin
            RegDst <= 0;
            ALUOp <= 6'b000000;
            ALUSrc <= 0;
            Branch <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            RegWrite <= 0;  
            JR <= 0;  
            JAL <= 0;
            size <= 0;
            RegWrite_JAL <= 0;
            special_rt <= 0;
            j_and_jal <= 0;
            
    

        $display("operation: %b", operation);
    
            case (Instruction[31:26]) 
                6'b000000: begin // R-Type
                    RegDst <= 1;
                    ALUOp <= 6'b000000;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 0;
                    Branch <= 0;      
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    JR <= 0;
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= 0;       //doesn't matter
                    if (Instruction[5:0] == 6'b001000) begin
                        JR <= 1;
                    end
                end
                
                6'b011100: begin  // MUL
                    RegDst <= 1;
                    ALUOp <= 6'b011100;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 0;
                    Branch <= 0;      
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    JR <= 0;
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= 0;       //doesn't matter
                end
                
                6'b001000: begin // ADDI
                    RegDst <= 0;      // result goes to register rt [20:16]
                    ALUOp <= 6'b001000;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;      // takes the 'imm' value at the mux
                    Branch <= 0;      
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b001100: begin // ANDI
                    RegDst <= 0;      // result goes to register rt [20:16]
                    ALUOp <= 6'b001100;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;      // takes the 'imm' value at the mux
                    Branch <= 0;      
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b001101: begin // ORI
                    RegDst <= 0;      // result goes to register rt [20:16]
                    ALUOp <= 6'b001101;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;      // takes the 'imm' value at the mux
                    Branch <= 0;      
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b001110: begin // XORI
                    RegDst <= 0;      // result goes to register rt [20:16]
                    ALUOp <= 6'b001110;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;      // takes the 'imm' value at the mux
                    Branch <= 0;      
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b001010: begin // SLTI
                    RegDst <= 0;      // result goes to register rt [20:16]
                    ALUOp <= 6'b001010;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;      // takes the 'imm' value at the mux
                    Branch <= 0;      
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;
                    MemtoReg <= 1;
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b100011: begin // Load
                    RegDst <= 0;
                    ALUOp <= 6'b100011;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;
                    Branch <= 0;      
                    MemRead <= 1;
                    MemWrite <= 0;
                    MemtoReg <= 0;  
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    size <= 2'b00;
                    //PCSrc <= 0;       //doesn't matter
                    //Select_size <= 0, 1, 2
                            // 0 - Word [32 bits]
                            // 1 - half [16 bits]
                            // 2 - byte [8 bits]
                end
                6'b101011: begin // Store
                    RegDst <= 0;
                    ALUOp <= 6'b101011;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;
                    Branch <= 0;      //doesn't matter
                    MemRead <= 0;
                    MemWrite <= 1;
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    size <= 2'b00;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b101000: begin // Store Byte
                    RegDst <= 0;
                    ALUOp <= 6'b101000;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;
                    Branch <= 0;      //doesn't matter
                    MemRead <= 0;
                    MemWrite <= 1;
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    size <= 2'b01;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b100000: begin // Load Byte
                    RegDst <= 0;
                    ALUOp <= 6'b100000;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;
                    Branch <= 0;      
                    MemRead <= 1;
                    MemWrite <= 0;
                    MemtoReg <= 0;  
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    size <= 2'b01;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b101001: begin // Store half
                    RegDst <= 0;
                    ALUOp <= 6'b101001;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;
                    Branch <= 0;      //doesn't matter
                    MemRead <= 0;
                    MemWrite <= 1;
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    size <= 2'b10;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b100001: begin // Load half
                    RegDst <= 0;
                    ALUOp <= 6'b100001;
                    //ALUZero <= 0;     //doesn't matter
                    ALUSrc <= 1;
                    Branch <= 0;      
                    MemRead <= 1;
                    MemWrite <= 0;
                    MemtoReg <= 0;  
                    RegWrite <= 1;
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    size <= 2'b10;
                    //PCSrc <= 0;       //doesn't matter
                end
                6'b000001: begin // BGEZ & BLTZ
                    RegDst <= 0;
                    ALUOp <= 6'b000001;
                    //ALUZero <= 1;     
                    ALUSrc <= 0;      //want to pass rt. if rt = 0, bltz. if rt = 1, bgez
                    Branch <= 1;     
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;    //has to be 0 so we don't overwrite
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;    //has to be zero so we don't overwrite
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    special_rt <= 1;
                    //PCSrc <= Branch & Zero;       
                end
                6'b000100: begin // BEQ
                    RegDst <= 0;
                    ALUOp <= 6'b000100;
                    //ALUZero <= 1;     
                    ALUSrc <= 0;      
                    Branch <= 1;     
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;    //has to be 0 so we don't overwrite
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;    //has to be zero so we don't overwrite
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= Branch & Zero;       
                end
                6'b000101: begin // BNE
                    RegDst <= 0;
                    ALUOp <= 6'b000101;
                    //ALUZero <= 1;     
                    ALUSrc <= 0;      
                    Branch <= 1;     
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;    //has to be 0 so we don't overwrite
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;    //has to be zero so we don't overwrite
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= Branch & Zero;       
                end
                6'b000111: begin // BGTZ
                    RegDst <= 0;
                    ALUOp <= 6'b000111;
                    //ALUZero <= 1;     
                    ALUSrc <= 0;      // doesn't matter, only rs (A) will be compared to 0 in ALU     
                    Branch <= 1;     
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;    //has to be 0 so we don't overwrite
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;    //has to be zero so we don't overwrite
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= Branch & Zero;       
                end
                6'b000110: begin // BLEZ
                    RegDst <= 0;
                    ALUOp <= 6'b000110;
                    //ALUZero <= 1;     
                    ALUSrc <= 0;      //doesn't matter, only rs (A) will be compared to 0 in ALU      
                    Branch <= 1;     
                    MemRead <= 0;     //doesn't matter
                    MemWrite <= 0;    //has to be 0 so we don't overwrite
                    MemtoReg <= 0;    //doesn't matter
                    RegWrite <= 0;    //has to be zero so we don't overwrite
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    //PCSrc <= Branch & Zero;       
                end
                
                
                6'b000010: begin // j
                    RegDst <= 0;
                    ALUOp <= 6'b000010;
                    //ALUZero <= 1;     
                    ALUSrc <= 1;           
                    Branch <= 0;     
                    MemRead <= 0;     
                    MemWrite <= 0;    
                    MemtoReg <= 1;    
                    RegWrite <= 0;   
                    JR <= 0;  
                    JAL <= 0; 
                    j_and_jal <= 1;
                    //PCSrc <= Branch & Zero;
                end
                6'b000011: begin // jal  FIXME!
                    RegDst <= 0;
                    ALUOp <= 6'b000011;
                    //ALUZero <= 1;     
                    ALUSrc <= 1;            
                    Branch <= 0;     
                    MemRead <= 0;     
                    MemWrite <= 0;    
                    MemtoReg <= 1;   
                    RegWrite <= 1;  
                    JR <= 0;  
                    JAL <= 1; 
                    j_and_jal <= 1;
                    RegWrite_JAL <= 1; 
                    //PCSrc <= Branch & Zero;
                end
                default: begin
                    RegDst <= 0;
                    ALUOp <= 6'b000000;
                    ALUSrc <= 0;
                    Branch <= 0;
                    MemRead <= 0;
                    MemWrite <= 0;
                    MemtoReg <= 0;
                    RegWrite <= 0;  
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    RegWrite_JAL <= 0;
                end
                
            endcase
            if (Instruction == 32'b0) begin
                RegDst <= 0;
                    ALUOp <= 6'b000000;
                    ALUSrc <= 0;
                    Branch <= 0;
                    MemRead <= 0;
                    MemWrite <= 0;
                    MemtoReg <= 0;
                    RegWrite <= 0;  
                    JR <= 0;  
                    JAL <= 0;
                    j_and_jal <= 0;
                    size <= 0;
                    RegWrite_JAL <= 0;
                    special_rt <= 0;
            end
        end
   // end


endmodule
