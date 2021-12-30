`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 08:02:31 PM
// Design Name: 
// Module Name: mux
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


module mux_str(out, s, in_0, in_1);
    output reg [31:0] out;                 // 32-bit output out
    input s;                               // the select line
    input [31:0] in_0;                     // 32-bit inputs for in_0 and in_1
    input [31:0] in_1;

    always @ (in_0 or in_1 or s)
    begin
        if(s)
            out = in_1;                    // if the select is 1, choose input 1   
        else
            out = in_0;                    // if the select is 0, choose input 0
        end
    
endmodule
