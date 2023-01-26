`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 20:57:08
// Design Name: 
// Module Name: WidthControl
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


module WidthControl(
    input [2:0] funct,
    input [31:0] word,
    output [31:0] OutputWord
    );
    
    /* signed operand 1 */
    wire signed [31:0] singed_word;
    
    wire signed [31:0] singed_byte;
    wire signed [31:0] singed_halfword;
    
    assign singed_word = word;
    
    assign singed_byte = (singed_word << 24) >>> 24;
    assign singed_halfword = (singed_word << 16) >>> 16;
    
    assign OutputWord = (funct == 3'b000) ? singed_byte : 
                        (funct == 3'b001) ? singed_halfword :
                        (funct == 3'b010) ? word : 
                        (funct == 3'b100) ? {24'b0, word[7:0]} :
                        (funct == 3'b101) ? {16'b0, word[15:0]} :32'hxxxx_xxxx;    
endmodule
