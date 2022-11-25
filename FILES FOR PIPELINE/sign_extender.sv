`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: CSE 4010 Fall 2022
// Engineers: Nathan Bush, Axel Lira, Steve Flores
// 
// Create Date: 10/22/2022 09:41:33 PM
// Design Name: Sign Extender
// Module Name: sign_extender
// Project Name: Single Cycle Processor
// Description: A sign extender to generate an immediate value for use by other
//              modules in the processor design. Performs shift as well.
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module sign_extender(
    input logic[31:0] in,
    output logic [31:0] out,
    input logic [1:0]immSrc
    );
    
    always_comb
        if(immSrc[1:0] == 'b00) //lw instruction
            //last 12 bits are read and the last 20 bits is sign extended
            out <= {{20{in[31]}},in[31:20]};
        else if(immSrc[1:0]== 'b01) //sw instruction
            //bits 31:25 and 11:7 are read from imm values last 20 bits are extended
            out <= {{20{in[31]}}, in[31:25], in[11:7]};
        else if(immSrc[1:0] == 'b10) //beq instruction
            //bits 31|27:25 for the first imm and bits 11:7|30 are read for the second constraint_mode 20 bits are extended
            out <= {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0};
//        'b00: //ALU I-type ???
        else if(immSrc[1:0]== 'b11) //jal instruction
            // bits 31|21:12|22|30:23 are read remaining 12 bits are extended
            out <= {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0};
    
endmodule
