// ID/EX Pipeline

module id_ex (
   input logic          clk, reset,
   input logic [31:0]   PCD, PCPlus4D, RD1D, RD2D, ImmExtD,
   input logic [4:0]    RdD,
   input logic [2:0]    AluControlD,
   input logic [1:0]    ResultSrcD,
   input logic          RegWriteD, MemWriteD, JumpD, BranchD, ALUSrcD,
   output logic [31:0]  PCE, PCPlus4E, RD1E, RD2E, ImmExtE,
   output logic [4:0]   RdE,
   output logic [2:0]   AluControlE,
   output logic [1:0]   ResultSrcE,
   output logic         RegWriteE, MemWriteE, JumpE, BranchE, ALUSrcE,
   //forwarding unit wires
   input logic [4:0]Rs1D, Rs2D,
   output logic [4:0]Rs1E,Rs2E,
   //hazard
   input logic MemReadD,
   output logic MemReadE
   );
  
  always_ff @(posedge clk, posedge reset)
  begin
    if (reset) begin
		// set all variables to 0 here
		PCE <= 0;
		PCPlus4E <= 0;
		RD1E <= 0;
		RD2E <= 0;
		ImmExtE <= 0;
		RdE <= 0;
		AluControlE <= 0;
		ResultSrcE <= 0;
		RegWriteE <= 0;
		MemWriteE <= 0;
		MemReadE <= 0;
		JumpE <= 0;
		BranchE <= 0;
		ALUSrcE <= 0;
		Rs1E <=0;
		Rs2E<=0;
	end
	else begin
		// pass through all variables here
	   	PCE <= PCD;
        PCPlus4E <= PCPlus4D;
        RD1E <= RD1D;
        RD2E <= RD2D;
        ImmExtE <= ImmExtD;
        RdE <= RdD;
        AluControlE <= AluControlD;
        ResultSrcE <= ResultSrcD;
        RegWriteE <= RegWriteD;
        MemWriteE <= MemWriteD;
        MemReadE <= MemReadD;
        JumpE <= JumpD;
        BranchE <= BranchD;
        ALUSrcE <= ALUSrcD;
        Rs1E <=Rs1D;
		Rs2E <=Rs2D;
	end
	end
	
endmodule 