`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: CSE 4010 Fall 2022
// Engineers: Nathan Bush, Axel Lira, Steve Flores
// 
// Create Date: 10/22/2022 07:07:14 PM
// Design Name: 2 to 1 Multiplexer
// Module Name: mux2_1
// Project Name: Single Cycle Processor
// Description: A 2x1 multiplexer.
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module mux2_1(
input logic [31:0]input1, 
input logic [31:0]input2, 
input logic select, 
output logic [31:0]cout
);

    assign cout = select ? input2 : input1;

endmodule
