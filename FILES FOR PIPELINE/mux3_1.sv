`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: CSE 4010 Fall 2022
// Engineers: Nathan Bush, Axel Lira, Steve Flores
// 
// Create Date: 10/23/2022 04:57:05 PM
// Design Name: 3 to 1 Multiplexer
// Module Name: mux3_1
// Project Name: Single Cycle Processor
// Description: A 3x1 multiplexer.
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module mux3_1(
input logic [31:0]input1, 
input logic [31:0]input2, 
input logic [31:0]input3,
input logic [0:1]select, 
output logic [31:0]cout
);

always_comb
    case(select)
        2'b00: cout = input1;
        2'b01: cout = input2;
        2'b10: cout = input3;
        default: cout = 0;
    endcase
endmodule

