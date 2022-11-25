`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 07:44:23 PM
// Design Name: 
// Module Name: ex_mem
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


module ex_mem(
    input logic clk, reset,

    input logic RegWriteE,
    input logic [1:0] ResultSrcE,
    input logic MemWriteE,
    input logic [31:0] ALUResultE,
    input logic [31:0] WriteDataE,
    input logic [4:0] RdE,
    input logic [31:0] PCPlus4E,
    
    output logic RegWriteM,
    output logic [1:0] ResultSrcM,
    output logic MemWriteM,
    output logic [31:0] ALUResultM,
    output logic [31:0] WriteDataM,
    output logic [4:0] RdM,
    output logic [31:0] PCPlus4M
    );
    
  always_ff @(posedge clk, posedge reset)
  begin
    if (reset) begin
		// set all variables to 0 here
        RegWriteM <=0;
        ResultSrcM<=0;
        MemWriteM<=0;
        ALUResultM<=0;
        WriteDataM<=0;
        RdM<=0;
        PCPlus4M<=0;
	end
	else begin
		// pass through all variables here
        RegWriteM <=RegWriteE;
        ResultSrcM<=ResultSrcE;
        MemWriteM<=MemWriteE;
        ALUResultM<=ALUResultE;
        WriteDataM<=WriteDataE;
        RdM<=RdE;
        PCPlus4M<=PCPlus4E;
	end
	end
endmodule
