//IF stage 
module ifetch (
   input  logic             clk, reset,
   input  logic         PCSrcE,
   input  logic  [31:0] PCTargetE,
   output logic  [31:0] InstrD,
   output logic  [31:0] PCD,PCPlus4D,   
   
   //hazard unit stuff
   input logic PCWrite, IF_IDWrite
   );

//signals
   logic [31:0] PCNext, PCF;
   logic [31:0] InstrF,PCPlus4F;

//initial begin 
//PCPlus4F <=0;
//end
   //instantiations
   mux2 #(32)  pcmux(PCPlus4F, PCTargetE, PCSrcE, PCNext); // PCNext == PCF in the diagram

   // next PC logic
  flopr #(32) pcreg(clk, reset, PCNext, PCF, PCWrite); 
  adder       pcadd4(PCF, 32'd4, PCPlus4F);
  
   // Fetch next Instruction 
  imem imem1(PCF, InstrF);
  
  // Ifetch pipeline register
   if_id  if_id1  (IF_IDWrite,clk, reset,InstrF, PCF,PCPlus4F,InstrD,PCD,PCPlus4D);

  
   initial begin
   
      $display("Time\t PCF\t PCD\t InstrF\t\t InstrD\t\t PCPlus4D");
      $monitor("%0d\t\t %0d\t\t %0d\t\t %h\t %h\t %h", $time, PCF, PCD, InstrF,InstrD,PCPlus4D);
      #150 $finish;
   end

endmodule // ifetch
