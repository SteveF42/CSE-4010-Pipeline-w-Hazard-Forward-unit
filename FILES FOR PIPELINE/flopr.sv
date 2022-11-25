module flopr #(parameter WIDTH = 8)
              (input  logic             clk, reset,
               input  logic [WIDTH-1:0] d, 
               output logic [WIDTH-1:0] q,
               //hazard stuff
               input logic PCWrite
               );

  always_ff @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       
        if(PCWrite) q <= q;
        else    q <= d;
endmodule