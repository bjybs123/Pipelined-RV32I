`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 11:11:14
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset_n,
    input PCWrite,
    input [19:0] nextPC,
    output reg [19:0] IF_PC
    );
    
    always @ (posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            IF_PC <= 0;
        end
        else begin
        	if (PCWrite) begin
            	IF_PC <= nextPC;
            end
            else begin
            	IF_PC <= IF_PC;
            end
        end
    end
    
endmodule

