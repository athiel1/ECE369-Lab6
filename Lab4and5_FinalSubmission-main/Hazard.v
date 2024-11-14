`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 02:15:45 PM
// Design Name: 
// Module Name: Hazard
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


module Hazard(MemRead, RegisterRt, RegisterRd, rs, rt, IFIDWrite, PCWrite, hazardControl, Clk);
    input MemRead;
    input [4:0] RegisterRt;
    input [4:0] RegisterRd;
    input [4:0] rs;
    input [4:0] rt;
    input Clk;
    
    output reg IFIDWrite;
    output reg PCWrite;
    output reg hazardControl;
    
    reg enable;
    
    initial begin
        PCWrite <= 1;
        IFIDWrite <= 1;
        hazardControl <= 0;
        enable = 0;
        repeat(4) @(posedge Clk);
        enable = 1;
    end
    
    always @(*) begin
        if (enable) begin
            PCWrite <= 1;
            IFIDWrite <= 1;
            hazardControl <= 0;
            
            if (MemRead) begin
                if ((RegisterRt == rs) | (RegisterRt == rt)) begin
                    PCWrite <= 0;
                    IFIDWrite <= 0;
                    hazardControl = 1;
                end
            end
            else if ((RegisterRd == rs) | (RegisterRd == rt)) begin
                    PCWrite <= 0; 
                    IFIDWrite <= 0; 
                    hazardControl = 1;
            end
        end
    end 


endmodule
