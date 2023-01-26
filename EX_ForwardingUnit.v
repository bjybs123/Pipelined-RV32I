`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/25 14:27:50
// Design Name: 
// Module Name: ForwardingUnit
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


module EX_ForwardingUnit(
	input [6:0] EX_opcode,
	input WB_cntl_RegWrite,
	input MEM_cntl_RegWrite,
	input [4:0] WB_WriteRegNum, 
	input [4:0] MEM_WriteRegNum,
	input [4:0] EX_ReadRegNum1,
	input [4:0] EX_ReadRegNum2,
	output [1:0] ForwardA,
	output [1:0] ForwardB
    );
    
    wire WB_ForwardA;
    wire WB_ForwardB;
   
	wire MEM_ForwardA;
	wire MEM_ForwardB;

    		
    assign WB_ForwardA = 	((WB_cntl_RegWrite) &&
    						(WB_WriteRegNum != 0) &&
    						(EX_opcode != 7'b0110111 && EX_opcode != 7'b0010111 && EX_opcode != 7'b1101111) &&
    						(WB_WriteRegNum == EX_ReadRegNum1)) ? 1'b1 : 1'b0;
    						
    assign WB_ForwardB = 	((WB_cntl_RegWrite) &&
    						(WB_WriteRegNum != 0) &&
    						(EX_opcode == 7'b0100011 || EX_opcode == 7'b0110011) &&
    						(WB_WriteRegNum == EX_ReadRegNum2)) ? 1'b1 : 1'b0;
    
    assign MEM_ForwardA = 	((MEM_cntl_RegWrite) &&
    						(MEM_WriteRegNum != 0) &&
    						(EX_opcode != 7'b0110111 && EX_opcode != 7'b0010111 && EX_opcode != 7'b1101111) &&
    						(MEM_WriteRegNum == EX_ReadRegNum1)) ? 1'b1 : 1'b0;

    assign MEM_ForwardB = 	((MEM_cntl_RegWrite) &&
    						(MEM_WriteRegNum != 0) &&
    						(EX_opcode == 7'b0100011 || EX_opcode == 7'b0110011) &&
    						(MEM_WriteRegNum == EX_ReadRegNum2)) ? 1'b1 : 1'b0;
    						
    assign ForwardA = 	(WB_ForwardA && MEM_ForwardA) ? 2'b10 : 
    					(!WB_ForwardA && MEM_ForwardA) ? 2'b10 : 
    					(WB_ForwardA && !MEM_ForwardA) ? 2'b01 : 2'b00;
    					
    assign ForwardB = 	(WB_ForwardB && MEM_ForwardB) ? 2'b10 : 
    					(!WB_ForwardB && MEM_ForwardB) ? 2'b10 : 
    					(WB_ForwardB && !MEM_ForwardB) ? 2'b01 : 2'b00;
    
endmodule
