`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 07:30:27 PM
// Design Name: 
// Module Name: 64BRCA
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


module SixtyFourBitRCA_str(
    output c_out,
    output [63:0] sum,
    input [63:0] a,
    input [63:0] b,
    input c_in
    );
        
    wire c_next;            // the carry out of the 32-bit adder that sums bits 31-0 of a and b
    
    ThirtyTwoBitRCA_str      ThirtyTwoBitRCA31_0        (.c_out(c_next), .sum(sum[31:0]), .a(a[31:0]), .b(b[31:0]), .c_in(c_in));       // compute sum of bits 31-0 of a and b with c_in using a 32-bit RCA
    ThirtyTwoBitRCA_str      ThirtyTwoBitRCA63_32       (.c_out(c_out), .sum(sum[63:32]), .a(a[63:32]), .b(b[63:32]), .c_in(c_next));   // compute sum of bits 63_32 of and ab with c_next using a 32-bit RCA
    
endmodule
