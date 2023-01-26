`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 12:20:57
// Design Name: 
// Module Name: InstrMem
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


module InstrMem(
    input   [19:0]  addr,
    output  [31:0]  dout
    );
    
    reg [7:0]  mem [0:1048575];
    /*initialize memory*/
    integer i;
    initial begin
 
        {mem[3],  mem[2],  mem[1],  mem[0]}     <= 32'b0000000_00010_00001_000_00100_1100111;   //      ADDI x4, x0, 10
        
        for (i = 4; i < 1048576; i = i + 1) begin
            mem[i] <= 20'h0_0000;
        end
    end
    
    assign dout = {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};

endmodule

