`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 15:30:05
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input   clk, 
    input   reset_n, 
    input   MemWrite,
    input   [19:0]  addr,
    input   [31:0]  din,
    output  [31:0]  dout
    );

    reg [7:0] mem [0:1048575];
    
    /* initialize memory */
    integer i;
    initial begin
        {mem[3],  mem[2],  mem[1],  mem[0]}     <= 32'h0000_0003;       //3 
        {mem[7],  mem[6],  mem[5],  mem[4]}     <= 32'h0000_0001;       //1
        {mem[11], mem[10], mem[9],  mem[8]}     <= 32'h0000_002C;       //44
        {mem[15], mem[14], mem[13], mem[12]}    <= 32'hF9FF_FFF7;       //-73
        {mem[19], mem[18], mem[17], mem[16]}    <= 32'h0000_0000;       //0
        {mem[23], mem[22], mem[21], mem[20]}    <= 32'h0000_0041;       //65
        {mem[27], mem[26], mem[25], mem[24]}    <= 32'h0000_0144;       //324
        {mem[31], mem[30], mem[29], mem[28]}    <= 32'hFFFF_FFE1;       //-31
        {mem[35], mem[34], mem[33], mem[32]}    <= 32'h0000_0004;       //4
        {mem[39], mem[38], mem[37], mem[36]}    <= 32'hFFFF_FFF9;       //-7
        {mem[43], mem[42], mem[41], mem[40]}    <= 32'h0000_0000;
        for (i = 44; i < 1048576; i = i + 1) begin
            mem[i] <= 8'hF0;
        end
    end
    
    always @ (posedge clk) begin
        if (MemWrite) begin
            {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]} <= din;
        end
        else begin
            {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]} <= {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};
        end
    end
    
    assign dout = {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]};
  
endmodule
