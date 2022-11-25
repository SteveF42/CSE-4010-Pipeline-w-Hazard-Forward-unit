// Instruction Decode Stage
module idecode(
    input logic clk, reset, regWriteW,
    input logic [31:0] PCD, InstrD, PCPlus4D, ResultW,
    input logic [4:0] RDW,
    output logic [31:0] PCE, PCPlus4E, RD1E, RD2E,ImmExtE,
    output logic [4:0] RdE,
    output logic [2:0] AluControlE,
    output logic [1:0] ResultSrcE,
    output logic RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE,
    //forward unit wires
    output logic [4:0] Rs1E,Rs2E,
    //hazard unit
    input Control_mux,
    output MemReadE
    );
    
    // internal signals
    //datapath wires
    logic[31:0] RD1D, RD2D, ImmExtD;
    initial 
    begin
        RD1D <= 0;
        RD2D <= 0;
        ImmExtD <=0;
    end
    
    //control wires
    logic RegWriteD;
    logic[1:0] ResultSrcD;
    logic MemWriteD, MemReadD;
    logic JumpD;
    logic BranchD;
    logic[2:0] ALUControlD;
    logic ALUSrcD;
    logic [1:0]ImmSrcD;
    logic [4:0] Rs1, Rs2;
    
    //assign Rs1 and Rs2 for forwarding unit
    logic [4:0]Rs1D, Rs2D;
    //hazard unit
    logic [31:0] MuxOut;
    
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    
    //hazard mux
    mux2_1 ctrl_mux(.input1(InstrD), .input2(32'b0), .select(Control_mux), .cout(MuxOut));
    
    
    
    // instantiations

    controller ctrl(
        .op(MuxOut[6:0]),
        .funct3(MuxOut[14:12]),
        .funct7b5(MuxOut[30]),
        .Branch(BranchD),
        .ResultSrc(ResultSrcD),
        .MemWrite(MemWriteD),
        .MemRead(MemReadD),
        .ALUSrc(ALUSrcD),
        .RegWrite(RegWriteD),
        .Jump(JumpD),
        .ImmSrc(ImmSrcD),
        .ALUControl(ALUControlD));
        
     register_file rf(
        .clk(clk), 
        .WE3(regWriteW), 
        .A1(Rs1D),
        .A2(Rs2D),
        .A3(RDW),
        .WD3(ResultW),
        .RD1(RD1D),
        .RD2(RD2D));
    sign_extender extender(.in(InstrD), .out(ImmExtD), .immSrc(ImmSrcD));
    
    id_ex ff(
        .clk(clk), .reset(reset), 
        .PCD(PCD), .PCPlus4D(PCPlus4D), .RD1D(RD1D), .RD2D(RD2D), .ImmExtD(ImmExtD), 
        .RdD(InstrD[11:7]), 
        .AluControlD(ALUControlD), 
        .ResultSrcD(ResultSrcD), 
        .RegWriteD(RegWriteD), .MemWriteD (MemWriteD), .JumpD(JumpD), .BranchD(BranchD), .ALUSrcD(ALUSrcD), 
        .PCE(PCE), .PCPlus4E(PCPlus4E), .RD1E(RD1E), .RD2E(RD2E), .ImmExtE(ImmExtE), 
        .RdE(RdE), 
        .AluControlE(AluControlE), 
        .ResultSrcE(ResultSrcE),
        .RegWriteE(RegWriteE), .MemWriteE(MemWriteE), .JumpE(JumpE), .BranchE(BranchE), .ALUSrcE(ALUSrcE),
        //forwarding unit
        .Rs1D(Rs1D), .Rs2D(Rs2D),
        .Rs1E(Rs1E), .Rs2E(Rs2E),
        //hazard unit
        .MemReadD(MemReadD), .MemReadE(MemReadE)
        );
    

endmodule



