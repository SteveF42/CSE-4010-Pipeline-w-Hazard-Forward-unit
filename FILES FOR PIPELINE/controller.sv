`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: CSE 4010 Fall 2022
// Engineers: Nathan Bush, Axel Lira, Steve Flores
// 
// Create Date: 10/26/2022 11:39:57 AM
// Design Name: Control Unit Module
// Module Name: controller
// Project Name: Single Cycle Processor
// Description: Control unit module, instantiating the main decoder, ALU decoder,
//              and containing output logic for the PCSrc control signal
// Dependencies: main_decoder.sv, ALU_decoder.sv
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module controller(input  logic [6:0] op,
                  input  logic [2:0] funct3,
                  input  logic       funct7b5,
                  output logic       Branch,
                  output logic [1:0] ResultSrc,
                  output logic       MemWrite, MemRead,
                  output logic       ALUSrc,
                  output logic       RegWrite, Jump,
                  output logic [1:0] ImmSrc,
                  output logic [2:0] ALUControl);

  logic [1:0] ALUOp;
  
  initial begin
    Branch<= 0;
    ResultSrc<= 0;
    MemWrite<= 0;
    MemRead <= 0;
    ALUSrc<= 0;
    RegWrite<= 0;
    Jump<= 0;
    ImmSrc<= 0;
    ALUControl<= 0;
  end

  main_decoder md(.opCode(op), .resultSrc(ResultSrc), .memWrite(MemWrite),.memRead(MemRead), .branch(Branch), .ALUSrc(ALUSrc),
                  .regWrite(RegWrite), .jump(Jump), .immSrc(ImmSrc), .ALUOp(ALUOp));
  ALU_decoder  ad(.op5(op[5]), .funct3(funct3), .funct7(funct7b5), .ALUop(ALUOp), .ALUControl(ALUControl));

  
endmodule
