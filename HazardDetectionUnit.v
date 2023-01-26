`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/25 16:17:37
// Design Name: 
// Module Name: HazardDetectionUnit
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


module HazardDetectionUnit(
	input EX_cntl_MemRead,
	input EX_cntl_RegWrite,
	input MEM_cntl_MemRead,
	input [6:0] ID_opcode,
	input [4:0] EX_WriteRegNum,
	input [4:0] MEM_WriteRegNum,
	input [4:0] ID_ReadRegNum1,
	input [4:0] ID_ReadRegNum2,
	output PCWrite, 
	output IF_IDWrite, 
	output ID_EXFlush
    );
    
    wire EX_Stall;
    wire Branch_EX_Stall;
    wire Branch_MEM_Stall;
    wire Jalr_EX_Stall;
    wire Jalr_MEM_Stall;
    
    //Load Stall
    assign EX_Stall = 	((ID_opcode != 7'b0110111) && (ID_opcode != 7'b0010111) && (ID_opcode != 7'b1101111) && 
    					(EX_cntl_MemRead) && 
    					((EX_WriteRegNum == ID_ReadRegNum1) || (EX_WriteRegNum == ID_ReadRegNum2))) ? 1'b1 : 1'b0;

    /* Stall for JALR comparison on ID stage */
    //ALU operation Stall and Load Stall
    assign Jalr_EX_Stall = 	((ID_opcode == 7'b1100111) &&
    						(EX_cntl_MemRead) && 
    						(EX_WriteRegNum == ID_ReadRegNum1)) ? 1'b1 : 1'b0;
	
	//Load Stall
    assign Jalr_MEM_Stall = ((ID_opcode == 7'b1100111) &&
    						(MEM_cntl_MemRead) && 
    						(MEM_WriteRegNum == ID_ReadRegNum1)) ? 1'b1 : 1'b0;
 
    /* Stall for Branch comparison on ID stage */
    //ALU operation Stall and Load Stall
    assign Branch_EX_Stall = 	((ID_opcode == 7'b1100011) && 
    							(EX_cntl_RegWrite) && 
    							((EX_WriteRegNum == ID_ReadRegNum1) || (EX_WriteRegNum == ID_ReadRegNum2))) ? 1'b1 : 1'b0;
	
	//Load Stall
    assign Branch_MEM_Stall = 	((ID_opcode == 7'b1100011) &&
    							(MEM_cntl_MemRead) && 
    							((MEM_WriteRegNum == ID_ReadRegNum1) || (MEM_WriteRegNum == ID_ReadRegNum2))) ? 1'b1 : 1'b0; 		
   
   assign {PCWrite, IF_IDWrite, ID_EXFlush} = (EX_Stall || Branch_EX_Stall || Branch_MEM_Stall || Jalr_EX_Stall || Jalr_MEM_Stall) ? 3'b001 : 3'b110;

endmodule
