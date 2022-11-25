`timescale 1ns / 1ps
module pipeline ();


  logic        clk;
  logic        reset;

  //logic [31:0] WriteData, DataAdr;
 //logic        MemWrite;
  
  // initialize test
  initial
    begin
      reset <= 1; # 5; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end



//~~~~~~~~~~~~~~~~~iFetch Module~~~~~~~~~~~~~~~~~~~~~~

  logic [31:0] tb_InstrD,tb_PCD,tb_PCPlus4D;
  logic tb_PCSrcE;
  logic [31:0]tb_PCTargetE;


  ifetch ifetch1(clk, reset,tb_PCSrcE,tb_PCTargetE,tb_InstrD,tb_PCD,tb_PCPlus4D, tb_PCWrite, tb_IF_IDWrite); 
  
  
  
//~~~~~~~~~~~~~~~~~iDecode Module~~~~~~~~~~~~~~~~~~~~~~
  logic [31:0] tb_PCE, tb_PCPlus4E, tb_RD1E, tb_RD2E, tb_ImmExtE;
  logic [4:0] tb_RdE;
  logic [2:0] tb_AluControlE;
  logic [1:0] tb_ResultSrcE;
  logic tb_RegWriteE, tb_MemWriteE,tb_MemReadE, tb_JumpE, tb_BranchE, tb_ALUSrcE;
  logic tb_RegWriteW;
  logic [31:0]tb_ResultW;
  logic [4:0]tb_RdW;
  //forwarding wires
  logic [4:0] tb_Rs1E,tb_Rs2E;
  
  idecode decode(.clk(clk),.reset(reset),.regWriteW(tb_RegWriteW),.PCD(tb_PCD),.InstrD(tb_InstrD),.PCPlus4D (tb_PCPlus4D),.ResultW(tb_ResultW),.RDW(tb_RdW[4:0]),
    .PCE(tb_PCE), .PCPlus4E(tb_PCPlus4E), .RD1E(tb_RD1E), .RD2E(tb_RD2E), .ImmExtE(tb_ImmExtE),.RdE(tb_RdE), .AluControlE(tb_AluControlE), .ResultSrcE(tb_ResultSrcE), 
    .RegWriteE(tb_RegWriteE), .MemWriteE(tb_MemWriteE),.MemReadE(tb_MemReadE), .JumpE(tb_JumpE), .BranchE(tb_BranchE), .ALUSrcE(tb_ALUSrcE),
    .Rs1E(tb_Rs1E), .Rs2E(tb_Rs2E), .Control_mux(tb_Control_mux)
    );

  //~~~~~~~~~~~~~~~~~iExecute Module~~~~~~~~~~~~~~~~~~~~~~
    //data path M
    logic[31:0] tb_ALUResultM, tb_WriteDataM, tb_PCPlus4M;
    logic [4:0] tb_RdM;
    //control M
    logic tb_RegWriteM, tb_MemWriteM;
    logic[1:0] tb_ResultSrcM;
    
    ixecute exec(
        clk,reset,
        tb_RD1E,tb_RD2E,tb_PCE,tb_ImmExtE, tb_PCPlus4E, 
        tb_RdE,
        tb_RegWriteE, tb_MemWriteE, tb_JumpE,tb_BranchE,tb_ALUSrcE,
        tb_ResultSrcE,
        tb_AluControlE,
        tb_ALUResultM, tb_WriteDataM, tb_PCPlus4M, tb_PCTargetE, 
        tb_RdM,
        tb_PCSrcE, tb_RegWriteM, tb_MemWriteM,
        tb_ResultSrcM,
        //forwarding wires
        tb_ForwardA, tb_ForwardB,
        tb_ResultW
    );
  //~~~~~~~~~~~~~~~~~iMemory Module~~~~~~~~~~~~~~~~~~~~~~
    logic [1:0] tb_ResultSrcW;
    logic [31:0] tb_ALUResultW;
    logic [31:0] tb_ReadDataW;
    logic [31:0] tb_PCPlus4W;
  
    imemStage memory(
        .clk(clk),.reset(reset),
        .RegWriteM (tb_RegWriteM),
        .ResultSrcM(tb_ResultSrcM),
        .MemWriteM(tb_MemWriteM),
        .ALUResultM(tb_ALUResultM),
        .WriteDataM(tb_WriteDataM),
        .RdM(tb_RdM),
        .PCPlus4M(tb_PCPlus4M),
        .RegWriteW(tb_RegWriteW),
        .ResultSrcW(tb_ResultSrcW),
        .ALUResultW(tb_ALUResultW),
        .ReadDataW(tb_ReadDataW),
        .RdW(tb_RdW),
        .PCPlus4W(tb_PCPlus4W)
    );

    //~~~~~~~~~~~~~~~~~iWriteBack Module~~~~~~~~~~~~~~~~~~~~~~
    iWB write_back(
        clk, reset,
        tb_ResultSrcW,
        tb_ALUResultW, tb_ReadDataW, tb_PCPlus4W,
        tb_ResultW
        );                  

    //~~~~~~~~~~~~~~~~~Forwarding Unit~~~~~~~~~~~~~~~~~~~~~~
    logic[1:0] tb_ForwardA, tb_ForwardB;
    
    forwarding_unit frwd_unit(.Rs1E(tb_Rs1E),.Rs2E(tb_Rs2E), .RdW(tb_RdW), .RdM(tb_RdM),
        .RegWriteM(tb_RegWriteM), .RegWriteW(tb_RegWriteW),
        .ForwardA(tb_ForwardA), .ForwardB(tb_ForwardB)
    );
    //~~~~~~~~~~~~~~~~~Hazard Detection Unit~~~~~~~~~~~~~~~~~~~~~~
    logic tb_Control_mux, tb_IF_IDWrite, tb_PCWrite;
    
    hazard_detection_unit hazard_unit(.reset(reset),.RdE(tb_RdE),.Rs1D(tb_InstrD[19:15]), .Rs2D(tb_InstrD[24:20]), .MemReadE(tb_MemReadE),
        .Control_mux(tb_Control_mux), .IF_IDWrite(tb_IF_IDWrite), .PCWrite(tb_PCWrite)
    );

initial begin
      tb_Control_mux <= 0;
      tb_IF_IDWrite <= 0;
      tb_PCWrite <= 0;
      tb_RegWriteW <= 0;
      tb_ResultW <= 0;
      tb_RdW <= 0;
    end
endmodule // pipeline
