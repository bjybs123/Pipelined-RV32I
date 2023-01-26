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


module ID_ForwardingUnit(
	input [6:0] ID_opcode,
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
    
    assign WB_ForwardA = 	((ID_opcode == 7'b1100011) &&
    						(WB_cntl_RegWrite) && 
    						(WB_WriteRegNum != 0) && 
    						(WB_WriteRegNum == EX_ReadRegNum1)) ? 1'b1 : 1'b0;
    						
 	assign WB_ForwardB = 	((ID_opcode == 7'b1100011) &&
 							(WB_cntl_RegWrite) && 
    						(WB_WriteRegNum != 0) && 
    						(WB_WriteRegNum == EX_ReadRegNum2)) ? 1'b1 : 1'b0;
    
    assign MEM_ForwardA = 	((ID_opcode == 7'b1100011) &&
    						(MEM_cntl_RegWrite) && 
    						(MEM_WriteRegNum != 0) && 
    						(MEM_WriteRegNum == EX_ReadRegNum1)) ? 1'b1 : 1'b0;
    						
 	assign MEM_ForwardB = 	((ID_opcode == 7'b1100011) &&
 							(MEM_cntl_RegWrite) && 
    						(MEM_WriteRegNum != 0) && 
    						(MEM_WriteRegNum == EX_ReadRegNum2)) ? 1'b1 : 1'b0;
    
    assign ForwardA = 	(WB_ForwardA && MEM_ForwardA) ? 2'b10 : 
    					(!WB_ForwardA && MEM_ForwardA) ? 2'b10 : 
    					(WB_ForwardA && !MEM_ForwardA) ? 2'b01 : 2'b00;
    					
    assign ForwardB = 	(WB_ForwardB && MEM_ForwardB) ? 2'b10 : 
    					(!WB_ForwardB && MEM_ForwardB) ? 2'b10 : 
    					(WB_ForwardB && !MEM_ForwardB) ? 2'b01 : 2'b00;
    
endmodule
