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


module Hazard(MemRead, RegisterRt, RegisterRd, rs, rt, IFIDWrite, PCWrite, hazardControl);
    input MemRead;
    input [4:0] RegisterRt;
    input [4:0] RegisterRd;
    input [4:0] rs;
    input [4:0] rt;
    
    output reg IFIDWrite;
    output reg PCWrite;
    output reg hazardControl;
    
    always @(*) begin
        if (MemRead) begin
            if ((RegisterRt == rs) | (RegisterRt == rt)) begin
                PCWrite <= 0;
                IFIDWrite <= 1;
                hazardControl = 1;
            end
        end
        else if ((RegisterRd == rs) | (RegisterRd == rt)) begin
                PCWrite <= 0;
                IFIDWrite <= 1;
                hazardControl = 1;
        end
    end 


endmodule
