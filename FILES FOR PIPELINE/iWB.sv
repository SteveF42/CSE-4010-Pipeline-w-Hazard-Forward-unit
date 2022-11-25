`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 12:29:58 AM
// Design Name: 
// Module Name: iWB
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


module iWB(
    input clk, reset,
    input [1:0] ResultSrcW,
    
    input [31:0] ALUResultW, ReadDataW,PCPlus4W,
    output [31:0]ResultW
    );
    
    mux3_1 mux3x1(.input1(ALUResultW), .input2(ReadDataW), .input3(PCPlus4W), .select(ResultSrcW), .cout(ResultW));
endmodule
