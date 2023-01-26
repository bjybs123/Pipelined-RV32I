`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 12:07:18
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
	input clk, 
	input reset_n,
	input ID_EXFlush,
	input [6:0] ID_opcode,
	input ID_cntl_MemWrite,
	input ID_cntl_MemRead,
    input ID_cntl_RegWrite,
    input [2:0] ID_sel_MemToReg,      	//000: ALUResult, 001: DMemReadData_width, 010: immediate, 011: branchAddr, 100: PC + 4
    input [1:0] ID_sel_ALUSrc,
    input [3:0] ID_funct,
    input [3:0] ID_ALUOp,
    input [4:0] ID_ReadRegNum1,
    input [4:0] ID_ReadRegNum2,
    input [4:0] ID_WriteRegNum,
    input [31:0] ID_ReadRegData1,
    input [31:0] ID_ReadRegData2,
    input [31:0] ID_immediate,
    output reg [6:0] EX_opcode,
    output reg EX_cntl_MemWrite,
    output reg EX_cntl_MemRead,
    output reg EX_cntl_RegWrite,
    output reg [2:0] EX_sel_MemToReg,      	//000: ALUResult, 001: DMemReadData_width, 010: immediate, 011: branchAddr, 100: PC + 4
    output reg [1:0] EX_sel_ALUSrc,
    output reg [3:0] EX_funct,
    output reg [3:0] EX_ALUOp,
    output reg [4:0] EX_ReadRegNum1,
    output reg [4:0] EX_ReadRegNum2,
    output reg [4:0] EX_WriteRegNum,
    output reg [31:0] EX_ReadRegData1,
    output reg [31:0] EX_ReadRegData2,
    output reg [31:0] EX_immediate
    );
    
    always @ (posedge clk or negedge reset_n) begin
    	if(!reset_n) begin
    		EX_opcode <= 0;
    		EX_cntl_MemWrite <= 0;
    		EX_cntl_MemRead <= 0;
    		EX_cntl_RegWrite <=  0;
    		EX_sel_MemToReg <=  0;
    		EX_sel_ALUSrc <= 0;
    		EX_funct <= 0;
    		EX_ALUOp <=  0;
    		EX_ReadRegNum1 <=  0;
    		EX_ReadRegNum2 <=  0;
    		EX_WriteRegNum <= 0;
    		EX_ReadRegData1 <=  0;
    		EX_ReadRegData2 <=  0;
    		EX_immediate <=  0;
    	end
    	else begin
    		if (ID_EXFlush) begin
    			EX_opcode <= 0;
    			EX_cntl_MemWrite <= 0;
    			EX_cntl_MemRead <= 0;
				EX_cntl_RegWrite <= 0;
				EX_sel_MemToReg <= 0;
				EX_sel_ALUSrc <= 0;
				EX_funct <= 0;
				EX_ALUOp <= 0;
				EX_ReadRegNum1 <= 0;
				EX_ReadRegNum2 <= 0;
				EX_WriteRegNum <= 0;
				EX_ReadRegData1 <= 0;
				EX_ReadRegData2 <= 0;
				EX_immediate <= 0;
    		end
    		else begin
    			EX_opcode <= ID_opcode;
    			EX_cntl_MemWrite <= ID_cntl_MemWrite;
    			EX_cntl_MemRead <= ID_cntl_MemRead;
				EX_cntl_RegWrite <= ID_cntl_RegWrite;
				EX_sel_MemToReg <= ID_sel_MemToReg;
				EX_sel_ALUSrc <= ID_sel_ALUSrc;
				EX_funct <= ID_funct;
				EX_ALUOp <= ID_ALUOp;
				EX_ReadRegNum1 <= ID_ReadRegNum1;
				EX_ReadRegNum2 <= ID_ReadRegNum2;
				EX_WriteRegNum <= ID_WriteRegNum;
				EX_ReadRegData1 <= ID_ReadRegData1;
				EX_ReadRegData2 <= ID_ReadRegData2;
				EX_immediate <= ID_immediate;
    		end
    	end
    end
endmodule
