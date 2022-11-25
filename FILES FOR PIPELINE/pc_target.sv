`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: CSE 4010 Fall 2022
// Engineers: Nathan Bush, Axel Lira, Steve Flores
// 
// Create Date: 10/23/2022 11:29:11 AM
// Design Name: Program Counter + Offset
// Module Name: pc_target
// Project Name: Single Cycle Processor
// Description: Adds value of PC to sign extended target value to pc_target
//              possible branch/jump target.
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module pc_target(
    input logic [31:0]pc, offset,
    output logic [31:0]target
    );
    
    assign target = pc + offset;
    
endmodule
