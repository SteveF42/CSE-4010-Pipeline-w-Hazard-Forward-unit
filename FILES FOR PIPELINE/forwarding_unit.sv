`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 08:30:34 PM
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
    input logic [4:0]Rs1E, Rs2E, RdW, RdM,
    input logic RegWriteM, RegWriteW,
    output logic [1:0] ForwardA, ForwardB
    );
    
    //assume default is 'b00
    
    
    always_comb 
    begin
        ForwardA <= 'b00;
        ForwardB <= 'b00;
    //EX hazard; Write back register is equal to writeback in Mem and WB stage
        if (RegWriteM & 
            (RdM != 'b0) & 
            (RdM == Rs1E))
                ForwardA <= 'b10;
        if (RegWriteM & 
            (RdM != 'b0) & 
            (RdM == Rs2E))
                ForwardB <= 'b10;
        
        //MEM hazard; 
         if (RegWriteW & (RdW !=  'b0) & !(RegWriteM & (RdM != 'b0) & (RdM == Rs1E)) & (RdW == Rs1E))
            ForwardA <= 'b01;
     
         if (RegWriteW & (RdW !=  'b0) & !(RegWriteM & (RdM != 'b0) & (RdM == Rs2E)) & (RdW == Rs2E))
            ForwardB <= 'b01;
    end
        
endmodule
