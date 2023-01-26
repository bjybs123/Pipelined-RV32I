`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 13:23:18
// Design Name: 
// Module Name: ImmediateGen
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


module ImmediateGen(
    input [31:0] currInstr,
    output [31:0] immediate
    );
    
    wire [31:0] I_imm;
    wire [31:0] S_imm;
    wire [31:0] B_imm;
    wire [31:0] J_imm;
    
    assign I_imm = $signed({currInstr[31:20], 20'b0}) >>> 20;
    assign S_imm = $signed({currInstr[31:25], currInstr[11:7], 20'b0}) >>> 20;
    assign B_imm = $signed({currInstr[31], currInstr[7], currInstr[30:25], currInstr[11:8], 20'b0}) >>> 19;
    assign J_imm = $signed({currInstr[31], currInstr[19:12], currInstr[20], currInstr[30:21], 12'b0}) >>> 11;
    
    assign immediate =  (currInstr[6:0] == 7'b011_0111 || currInstr[6:0] == 7'b001_0111) ? {currInstr[31:12], 12'b0} : 
                        (currInstr[6:0] == 7'b110_1111) ? J_imm : 
                        (currInstr[6:0] == 7'b110_0111) ? I_imm : 
                        (currInstr[6:0] == 7'b110_0011) ? B_imm : 
                        (currInstr[6:0] == 7'b000_0011) ? (currInstr[14:12] == 3'b100 || currInstr[14:12] == 3'b101) ? {20'b0, currInstr[31:20]} : I_imm : 
                        (currInstr[6:0] == 7'b010_0011) ? S_imm : 
                        (currInstr[6:0] == 7'b001_0011) ? (currInstr[14:12] == 3'b011) ? {20'b0, currInstr[31:20]} : I_imm : 32'hxxxx_xxxx;

endmodule
