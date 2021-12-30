`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2021 07:50:53 AM
// Design Name: 
// Module Name: NBitOR
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

// N-bit OR
module NBitOR_str#(
    parameter N = 32
)(
    output [N-1:0] out,               // output
    input [N-1:0] input1,             // input 1
    input [N-1:0] input2              // input 2
    );
    
    genvar i;
    
    for(i = 0; i < N; i = i+1)
        begin
            or     OR_N    (out[i], input1[i], input2[i]);        // bitwise OR
    end
     
endmodule