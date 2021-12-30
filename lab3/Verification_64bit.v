//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2021 01:39:37 PM
// Design Name: 
// Module Name: Verification_64bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Verify both 64-bit RCA and 64-bit Carry Select adders
// 
//////////////////////////////////////////////////////////////////////////////////

module Verification_64bit(
    input [63:0] a,
    input [63:0] b,
    input c_in,
    output [63:0] sum, 
    output c_out
    );
    
	assign {c_out, sum} = a + b + c_in;
    
endmodule