//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2021 08:52:48 PM
// Design Name: 
// Module Name: Verification_4bit
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


module Verification_4bit(
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] sum, 
    output c_out
    );
    
	assign {c_out, sum} = a + b + c_in;
    
endmodule
