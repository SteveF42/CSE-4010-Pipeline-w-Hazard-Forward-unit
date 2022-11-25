`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 09:17:54 PM
// Design Name: 
// Module Name: mem_wb
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


module mem_wb(
    input logic clk, reset,
    input logic RegWriteM,
    input logic [1:0] ResultSrcM,
    input logic [31:0] ALUResultM, ReadDataM, PCPlus4M,
    input logic [4:0] RdM,
    
    output logic RegWriteW,
    output logic [1:0] ResultSrcW,
    output logic [31:0] ALUResultW, ReadDataW, PCPlus4W,
    output logic [4:0] RdW
    );
    
    always_ff @(posedge clk, posedge reset)
      begin
        if (reset) begin
            // set all variables to 0 here
            RegWriteW <=0;
            ResultSrcW<=0;
            ALUResultW<=0;
            ReadDataW<=0;
            RdW<=0;
            PCPlus4W<=0;
        end
        else begin
            // pass through all variables here
            RegWriteW <=RegWriteM;
            ResultSrcW<=ResultSrcM;
            ALUResultW<=ALUResultM;
            ReadDataW<=ReadDataM;
            RdW<=RdM;
            PCPlus4W<=PCPlus4M;
        end
      end
endmodule
