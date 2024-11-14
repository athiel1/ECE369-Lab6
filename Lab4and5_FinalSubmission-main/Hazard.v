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
    
    initial begin
        PCWrite <= 1;
        IFIDWrite <= 1;
        hazardControl <= 0;
        repeat(2) @(posedge Clk);
    end
    
    always @(*) begin
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


endmodule
