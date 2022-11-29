`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 07:07:05 PM
// Design Name: 
// Module Name: ixecute
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


module ixecute(
    input logic clk, reset,
    
    //data path E
    input logic[31:0] RD1E, RD2E, PCE,ImmExtE,PCPlus4E,
    logic [4:0] RdE,
    //control E
    input logic RegWriteE,MemWriteE,JumpE,BranchE,ALUSrcE,
    input logic[1:0] ResultSrcE,
    input logic[2:0] ALUControlE,
    
    //data path M
    output logic[31:0] ALUResultM, WriteDataM,PCPlus4M, PCTargetE,
    logic [4:0] RdM,
    //control M
    output logic PCSrcE, RegWriteM,MemWriteM,
    output logic[1:0] ResultSrcM,
    //forwarding unit
    input logic[1:0] forwardA, forwardB,
    input logic[31:0]ResultW
    );
    
    logic [31:0] SrcB, ALUResultE;
    logic zeroFlag;
    
    //fowarding mux wires
    logic [31:0] forwardAResult, forwardBResult;
    
    mux3_1 mux_forwardA(.input1(RD1E), .input2(ResultW), .input3(ALUResultM), .select(forwardA), .cout(forwardAResult));
    mux3_1 mux_forwardB(.input1(RD2E), .input2(ResultW), .input3(ALUResultM), .select(forwardB), .cout(forwardBResult));
    
    
    mux2_1 ALUSrc_mux(.input1(forwardBResult),.input2(ImmExtE),.select(ALUSrcE),.cout(SrcB));
    
    pc_target pc(.pc(PCE),.offset(ImmExtE),.target(PCTargetE));    
    
    ALU alu(.src1(forwardAResult), .src2(SrcB), .control(ALUControlE), .result(ALUResultE), .zero(zeroFlag));
    
    ex_mem execute_reg(
    .clk(clk), .reset(reset),
    .RegWriteE(RegWriteE), .ResultSrcE(ResultSrcE), .MemWriteE(MemWriteE), .ALUResultE(ALUResultE), .WriteDataE(forwardBResult), .RdE(RdE), .PCPlus4E(PCPlus4E),
    .RegWriteM(RegWriteM), .ResultSrcM(ResultSrcM), .MemWriteM(MemWriteM), .ALUResultM(ALUResultM), .WriteDataM(WriteDataM), .RdM(RdM), .PCPlus4M(PCPlus4M)
    );

    assign PCSrcE = BranchE & zeroFlag | JumpE;
    
    
endmodule
