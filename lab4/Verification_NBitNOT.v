//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 07:10:48 PM
// Design Name: 
// Module Name: Verification_NBitNOT
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


module Verification_NBitNOT#(
    parameter N = 32
)(
    output [N-1:0] out,               // output
    input [N-1:0] in,                  // input
    input clk
    );
        
    genvar i;
    
    for(i = 0; i < N; i = i+1)
        begin
            not     notN    (out[i], in[i]);        // bitwise not
    end
    
endmodule
