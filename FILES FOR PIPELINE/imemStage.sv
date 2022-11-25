`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 08:59:48 PM
// Design Name: 
// Module Name: iMem
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


module imemStage(
    input clk, reset,
    input RegWriteM,
    input [1:0] ResultSrcM,
    input MemWriteM,
    input [31:0] ALUResultM,
    input [31:0] WriteDataM,
    input [4:0] RdM,
    input [31:0] PCPlus4M,
    output RegWriteW,
    output [1:0] ResultSrcW,
    output [31:0] ALUResultW,
    output [31:0] ReadDataW,
    output [4:0] RdW,
    output [31:0] PCPlus4W
    );
    logic [31:0] ReadDataM;
    dmem dm(.clk(clk), .we(MemWriteM), .a(ALUResultM), .wd(WriteDataM), .rd(ReadDataM));
    
    mem_wb mem_reg(
    .clk(clk), .reset(reset),
    .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .ALUResultM(ALUResultM), .ReadDataM(ReadDataM),.PCPlus4M(PCPlus4M),.RdM(RdM), 
    .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW), .ALUResultW(ALUResultW), .ReadDataW(ReadDataW),.PCPlus4W(PCPlus4W),.RdW(RdW)
    );

endmodule
