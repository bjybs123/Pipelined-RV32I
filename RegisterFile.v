`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 12:52:55
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input clk,
    input [4:0] ReadRegNum1,
    input [4:0] ReadRegNum2,
    input [4:0] WriteRegNum,
    input [31:0] WriteRegData,
    input RegWrite,
    output [31:0] ReadRegData1,
    output [31:0] ReadRegData2
    );
    
    reg [31:0]  regs [0:31];
    
    /*initialize memory*/
    integer i;
    initial begin
        regs[0] <= 32'h0000_0000;
        regs[1] <= 32'h0000_00FF;
        regs[2] <= 32'h0000_0000;
        regs[3] <= 32'h0000_0000;
        for (i = 4; i < 32; i = i + 1) begin
            regs[i] <= 32'h0000_0000;
        end
    end
    
    always @ (posedge clk) begin
        if (RegWrite) begin
            regs[WriteRegNum] <= WriteRegData;
        end
        else begin
            regs[WriteRegNum] <= regs[WriteRegNum];
        end
    end
    
    //bypass
    assign ReadRegData1 = (RegWrite && (ReadRegNum1 == WriteRegNum)) ? WriteRegData : regs[ReadRegNum1];
    assign ReadRegData2 = (RegWrite && (ReadRegNum2 == WriteRegNum)) ? WriteRegData : regs[ReadRegNum2];
    
endmodule

