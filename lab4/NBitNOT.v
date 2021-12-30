`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2021 07:50:53 AM
// Design Name: 
// Module Name: NBitNOT
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

// N-bit NOT
module NBitNOT_str#(
    parameter N = 32
)(
    output [N-1:0] out,               // output
    input [N-1:0] in                  // input
    );
    
    genvar i;
    
    for(i = 0; i < N; i = i+1)
        begin
            not     NOT_N    (out[i], in[i]);        // bitwise not out = ~in
    end
     
endmodule