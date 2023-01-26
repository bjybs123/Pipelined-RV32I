`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 12:07:28
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
	input clk, 
	input reset_n,
	input EX_cntl_MemWrite,
    input EX_cntl_RegWrite,
    input EX_cntl_MemRead,
    input [2:0] EX_sel_MemToReg,      	//000: ALUResult, 001: DMemReadData_width, 010: immediate, 011: branchAddr, 100: PC + 4
    input [2:0] EX_funct,
    input [31:0] EX_ALUResult,
    input [4:0] EX_WriteRegNum,
    input [31:0] EX_WriteMemData,
    output reg MEM_cntl_MemWrite,
    output reg MEM_cntl_RegWrite,
    output reg MEM_cntl_MemRead,
    output reg [2:0] MEM_sel_MemToReg,      	//000: ALUResult, 001: DMemReadData_width, 010: immediate, 011: branchAddr, 100: PC + 4
    output reg [2:0] MEM_funct,
    output reg [31:0] MEM_ALUResult,
    output reg [4:0] MEM_WriteRegNum,
    output reg [31:0] MEM_WriteMemData
    );
    
    always @ (posedge clk or negedge reset_n) begin
    	if (!reset_n) begin
    		MEM_cntl_MemWrite <= 0;
    		MEM_cntl_RegWrite <= 0;
    		MEM_cntl_MemRead <= 0;
    		MEM_sel_MemToReg <= 0;
    		MEM_funct <= 0;
    		MEM_ALUResult <= 0;
    		MEM_WriteRegNum <= 0;
    		MEM_WriteMemData <= 0;
    	end
    	else begin
    		MEM_cntl_MemWrite <= EX_cntl_MemWrite;
    		MEM_cntl_RegWrite <= EX_cntl_RegWrite;
    		MEM_cntl_MemRead <= EX_cntl_MemRead;
    		MEM_sel_MemToReg <= EX_sel_MemToReg;
    		MEM_funct <= EX_funct;
    		MEM_ALUResult <= EX_ALUResult;
    		MEM_WriteRegNum <= EX_WriteRegNum;
    		MEM_WriteMemData <= EX_WriteMemData;
    	end
    end
    
endmodule
