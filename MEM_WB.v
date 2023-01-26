`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 12:07:40
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
	input clk, 
	input reset_n,
    input MEM_cntl_RegWrite,
    input [2:0] MEM_sel_MemToReg,      	//000: ALUResult, 001: DMemReadData_width, 010: immediate, 011: branchAddr, 100: PC + 4
    input [2:0] MEM_funct,
    input [31:0] MEM_ReadMemData,
    input [31:0] MEM_ALUResult,
    input [4:0] MEM_WriteRegNum,
    output reg WB_cntl_RegWrite,
    output reg [2:0] WB_sel_MemToReg,      	//000: ALUResult, 001: DMemReadData_width, 010: immediate, 011: branchAddr, 100: PC + 4
    output reg [2:0] WB_funct,
    output reg [31:0] WB_ReadMemData,
    output reg [31:0] WB_ALUResult,
    output reg [4:0] WB_WriteRegNum
    );
    
    always @ (posedge clk or negedge reset_n) begin
    	if (!reset_n) begin
    		WB_cntl_RegWrite <= 0;
    		WB_sel_MemToReg <= 0;
    		WB_funct <= 0;
    		WB_ReadMemData <= 0;
    		WB_ALUResult <= 0;
    		WB_WriteRegNum <= 0;
    	end
    	else begin
    		WB_cntl_RegWrite <= MEM_cntl_RegWrite;
    		WB_sel_MemToReg <= MEM_sel_MemToReg;
    		WB_funct <= MEM_funct;
    		WB_ReadMemData <= MEM_ReadMemData;
    		WB_ALUResult <= MEM_ALUResult;
    		WB_WriteRegNum <= MEM_WriteRegNum;
    	end
    end
 
endmodule
