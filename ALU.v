`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 14:32:35
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [2:0] funct,
    input [31:0] op1, 
    input [31:0] op2, 
    input [3:0] ALUcntl, 
    output [31:0] ALUResult
    );
    
    /* signed operand 1 */
    wire signed [31:0] signed_op1;
    
    /* ALU operation results */
    wire [31:0] and_result;
    wire [31:0] or_result;
    wire [31:0] xor_result;
    wire [31:0] lsl_result;
    wire [31:0] rsl_result;
    wire [31:0] rsa_result;
    wire [31:0] add_result;
    wire [31:0] sub_result;
    
    /* Carry */ 
    wire Cout;
    
    /* Branch wires */
    wire signed [31:0] signed_ALUResult;
    
    assign signed_op1 = op1;
    
    assign and_result = op1 & op2;
    assign or_result =  op1 | op2;
    assign xor_result = op1 ^ op2;
    assign lsl_result = op1 << op2;
    assign rsl_result = op1 >> op2;
    assign rsa_result = signed_op1 >>> op2;
    assign add_result = op1 + op2;
    
    assign {Cout, sub_result} = {1'b0, op1} + ~{1'b0, op2} + 1'b1;
     
    assign ALUResult =  (ALUcntl == 4'b0000) ?  and_result : 
                        (ALUcntl == 4'b0001) ?  or_result : 
                        (ALUcntl == 4'b0010) ?  xor_result : 
                        (ALUcntl == 4'b0011) ?  lsl_result : 
                        (ALUcntl == 4'b0100) ?  rsl_result : 
                        (ALUcntl == 4'b0101) ?  rsa_result : 
                        (ALUcntl == 4'b0110) ?  add_result : 
                        (ALUcntl == 4'b0111) ?  (funct == 3'b010) ? (sub_result[31] == 0) ? 32'h0000_0000 : 32'h0000_0001 : 
                                                (funct == 3'b011) ? (Cout == 0) ? 32'h0000_0000 : 32'h0000_0001 : 
                                                sub_result : 
                                                32'hxxxx_xxxx;
    
endmodule
