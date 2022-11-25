`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2022 12:46:48 AM
// Design Name: 
// Module Name: hazard_detection_unit
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


module hazard_detection_unit(
    input logic reset,
    input logic[4:0] RdE, Rs1D, Rs2D,
    input logic MemReadE,
    output logic Control_mux, IF_IDWrite, PCWrite
    );
    
    
    always_comb begin
        if(MemReadE & ((RdE == Rs1D) | (RdE == Rs2D)) & !reset)
            begin
                Control_mux <= 1;
                IF_IDWrite <= 1;
                PCWrite <=1;
            end
        else 
            begin
                Control_mux <= 0;
                IF_IDWrite <= 0;
                PCWrite <=0;
            end  
    
    end
endmodule
