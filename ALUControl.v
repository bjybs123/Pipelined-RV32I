`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/20 14:46:26
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input [3:0] funct,
    input [3:0] ALUOp,
    output reg [3:0] ALUcntl
    );
    /* ALU control parameters */
    parameter AND = 4'b0000;
    parameter OR = 4'b0001;
    parameter XOR = 4'b0010;
    parameter LSL = 4'b0011;
    parameter RSL = 4'b0100;
    parameter RSA = 4'b0101;
    parameter ADD = 4'b0110;
    parameter SUB = 4'b0111;
    
    always @ (funct or ALUOp) begin
        case (ALUOp) 
            //LB, LH, LW, LBU, LHU
            4'b0000: begin
                ALUcntl <= ADD;
            end
            //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
            4'b0001: begin
                case (funct[2:0])
                    //ADDI
                    3'b000: begin
                        ALUcntl <= ADD;
                    end
                    3'b001: begin
                        //SLLI
                        if (funct[3] == 0) begin
                            ALUcntl <= LSL;
                        end
                        else begin
                            ALUcntl <= 4'bxxxx;
                        end
                    end
                    //SLTI
                    3'b010: begin
                        ALUcntl <= SUB;
                    end
                    //SLTIU
                    3'b011: begin
                        ALUcntl <= SUB;
                    end
                    //XORI
                    3'b100: begin
                        ALUcntl <= XOR;
                    end
                    3'b101: begin
                        //SRLI
                        if (funct[3] == 0) begin
                            ALUcntl <= RSL;
                        end
                        //SRAI
                        else begin
                            ALUcntl <= RSA;
                        end
                    end
                    //ORI
                    3'b110: begin
                        ALUcntl <= OR;
                    end
                    //ANDI
                    3'b111: begin
                        ALUcntl <= AND;
                    end
                    default: begin
                        ALUcntl <= 4'bxxxx;
                    end
                endcase
            end
            //AUIPC
            4'b0010: begin
                ALUcntl <= ADD;
            end
            //SB, SH, SW
            4'b0011: begin
                if (funct[2:0] == 3'b000 || funct[2:0] == 3'b001 || funct[2:0] == 3'b010) begin
                    ALUcntl <= ADD;
                end
                else begin
                    ALUcntl <= 4'bxxxx;
                end
            end
            //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
            4'b0100: begin
                case (funct[2:0])
                    3'b000: begin
                       //ADD
                        if (funct[3] == 0) begin
                            ALUcntl <= ADD;
                        end
                        //SUB
                        else begin
                            ALUcntl <= SUB;
                        end
                    end
                    //SLL
                    3'b001: begin
                        ALUcntl <= LSL;
                    end
                    //SLT
                    3'b010: begin
                        ALUcntl <= SUB;
                    end
                    //SLTU
                    3'b011: begin
                        ALUcntl <= SUB;
                    end
                    //XOR
                    3'b100: begin
                        ALUcntl <= XOR;
                    end
                    3'b101: begin
                        //SRL
                        if (funct[3] == 0) begin
                            ALUcntl <= RSL;
                        end
                        //SRA
                        else begin
                            ALUcntl <= RSA;
                        end
                    end
                    //OR
                    3'b110: begin
                        ALUcntl <= OR;
                    end
                    //AND
                    3'b111: begin
                        ALUcntl <= AND;
                    end
                    default: begin
                        ALUcntl <= 4'bxxxx;
                    end
                endcase
            end
            default: begin
                ALUcntl <= 4'bxxxx;
            end
        endcase
    
    end 
endmodule
