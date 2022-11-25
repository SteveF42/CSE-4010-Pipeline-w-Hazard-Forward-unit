`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: CSE 4010 Fall 2022
// Engineers: Nathan Bush, Axel Lira, Steve Flores
// 
// Create Date: 10/23/2022 04:00:04 PM
// Design Name: Main Instruction Decoder
// Module Name: main_decoder
// Project Name: Single Cycle Processor
// Description: Decoder for the main instruction control signals passed by the 
//              controller.
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module main_decoder(
    input logic[6:0] opCode,
    output logic [1:0]resultSrc,
    output logic memWrite,
    output logic [1:0]immSrc,
    output logic ALUSrc,
    output logic regWrite,
    output logic [1:0]ALUOp,
    output logic jump,
    output logic branch,
    //hazard detection needs read
    output logic memRead
    );
   

    //opcode truth table   
    always_comb
    if(opCode == 'b0000011)begin //lw
        regWrite <= 'b1;
        immSrc[1:0] <= 'b00;
        ALUSrc <= 'b1;
        memWrite <= 'b0;
        memRead <= 'b1;
        resultSrc[1:0] <= 'b01;
        branch <= 'b0;
        ALUOp <= 'b00;
        jump <= 'b0;
    end
    else if(opCode == 'b0100011)begin //sw
        regWrite <= 'b0;
        immSrc[1:0] <= 'b01;
        ALUSrc <= 'b1;
        memWrite <= 'b1;
        memRead <= 'b0;
        branch <= 'b0;
        ALUOp <= 'b00;
        jump <= 'b0;
    end
    else if(opCode == 'b0110011)begin //R-type
        regWrite <= 'b1;
        ALUSrc <= 'b0;
        memWrite <= 'b0;
        memRead <= 'b0;
        resultSrc[1:0] <= 'b00;
        branch <= 'b0;
        ALUOp <= 'b10;
        jump <= 'b0;
    end //R-type
    else if(opCode == 'b1100011)begin //beq
        regWrite <= 'b0;
        immSrc[1:0] <= 'b10;
        ALUSrc <= 'b0;
        memRead <= 'b0;
        memWrite <= 'b0;
        branch <= 'b1;
        ALUOp <= 'b01;
        jump <= 'b0;
    end //beq
    else if(opCode == 'b0010011)begin //I=type
        regWrite <= 'b1;
        immSrc[1:0] <= 'b00;
        ALUSrc <= 'b1;
        memWrite <= 'b0;
        memRead <= 'b0;
        resultSrc[1:0] <= 'b00;
        branch <= 'b0;
        ALUOp <= 'b10;
        jump <= 'b0;
    end
    else if(opCode == 'b1101111)begin // Jal
        regWrite <= 'b1;
        immSrc[1:0] <= 'b11;
        memWrite <= 'b0;
        memRead <= 'b0;
        resultSrc[1:0] <= 'b10;
        branch <= 'b0;
        jump <= 'b1;
    end
    else begin
        regWrite <= 'b0;
        immSrc[1:0] <= 'b00;
        ALUSrc <= 'b0;
        memWrite <= 'b0;
        memRead <= 'b0;
        resultSrc[1:0] <= 'b00;
        branch <= 'b0;
        ALUOp <= 'b00;
        jump <= 'b0;            
    end
      
endmodule
