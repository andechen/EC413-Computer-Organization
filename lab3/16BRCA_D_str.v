`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 07:30:27 PM
// Design Name: 
// Module Name: 16BRCA
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

// Delayed 16-bit ripple carry adder
module SixteenBitRCA_D_str(
    output c_out,
    output [15:0] sum,
    input [15:0] a,
    input [15:0] b,
    input c_in
    );
    
    wire c_next;            // the carry out of the 8-bit adder that sums bits 7-0 of a and b
    
    //compute sum using 2 8-bit RCA's
    EightBitRCA_D_str      EightBitRCA7_0        (.c_out(c_next), .sum(sum[7:0]), .a(a[7:0]), .b(b[7:0]), .c_in(c_in));       // compute sum of bits 7-0 of a and b with c_in using a 8-bit RCA
    EightBitRCA_D_str      EightBitRCA15_8       (.c_out(c_out), .sum(sum[15:8]), .a(a[15:8]), .b(b[15:8]), .c_in(c_next));   // compute sum of bits 15-8 of a and b with c_next using a 8-bit RCA
    
endmodule