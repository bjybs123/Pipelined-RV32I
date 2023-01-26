`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 12:06:59
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input clk, 
    input reset_n,
    input IF_IDWrite,
    input IF_IDFlush,
    input       [19:0] IF_PC,
    input		[19:0] IF_PCplus4,
    input       [31:0] IF_Instr,
    output reg  [19:0] ID_PC,
    output reg 	[19:0] ID_PCplus4,
    output reg [31:0] ID_Instr
    );
    
    always @ (posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            ID_PC <= 0;
            ID_PCplus4 <= 0;
            ID_Instr <= 0;
        end
        else begin
            if (IF_IDWrite) begin
            	if (IF_IDFlush) begin
            		ID_PC <= 0;
            		ID_Instr <= 0;
            		ID_PCplus4 <= 0;
        		end
        		else begin
            		ID_PC <= IF_PC;
            		ID_Instr <= IF_Instr;	
            		ID_PCplus4 <= IF_PCplus4;	
        		end
        	end
        	else begin
            	ID_PC <= ID_PC;
            	ID_PCplus4 <= ID_PCplus4;
            	ID_Instr <= ID_Instr;
        	end
        end
    end
    
endmodule
