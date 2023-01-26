`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/25 14:06:12
// Design Name: 
// Module Name: BranchALU
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


module BranchALU(
	input [6:0] ID_opcode, 
	input [2:0] funct,
    input [31:0] op1, 
    input [31:0] op2, 
    output ExeBranch
    );
    
    /* ALU operation results */
    wire [31:0] sub_result;
    
    /* Carry */ 
    wire Cout;

    wire [31:0] BEQ;
    wire [31:0] BNE;
    wire [31:0] BLT;
    wire [31:0] BGE;
    wire [31:0] BLTU;
    wire [31:0] BGEU;
    
    assign {Cout, sub_result} = {1'b0, op1} + ~{1'b0, op2} + 1'b1;
 
    assign BEQ = (sub_result == 32'b0) ? 32'h0000_0001 : 32'h0000_0000;
    
    assign BNE = (sub_result != 32'b0) ? 32'h0000_0001 : 32'h0000_0000;
    
    assign BLT = (sub_result[31] == 1'b1) ? 32'h0000_0001 : 32'h0000_0000;
    
    assign BGE = (sub_result[31] == 1'b0) ? 32'h0000_0001 : 32'h0000_0000;
    
    assign BLTU = (Cout == 1) ? 32'h0000_0001 : 32'h0000_0000;
    
    assign BGEU = (Cout == 0) ? 32'h0000_0001 : 32'h0000_0000;
    
    assign ExeBranch =  ((ID_opcode == 7'b1100011) && (funct == 3'b000)) ? BEQ : 
                        ((ID_opcode == 7'b1100011) && (funct == 3'b001)) ? BNE : 
                        ((ID_opcode == 7'b1100011) && (funct == 3'b100)) ? BLT : 
                        ((ID_opcode == 7'b1100011) && (funct == 3'b101)) ? BGE : 
                        ((ID_opcode == 7'b1100011) && (funct == 3'b110)) ? BLTU : 
                        ((ID_opcode == 7'b1100011) && (funct == 3'b111)) ? BGEU : 1'b0;
    
endmodule

