//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 02:40:36 PM
// Design Name: 
// Module Name: Verification_NBit
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

// Verification module for N bit addition & register
module Verification_NBitAdd#(
    parameter N = 32
)(
    output [N-1:0] sum,
    output c_out,
    input [N-1:0] a,
    input [N-1:0] b,
    input c_in,
    input clk
    );
    
    assign {c_out, sum} = a + b + c_in;
    
endmodule
