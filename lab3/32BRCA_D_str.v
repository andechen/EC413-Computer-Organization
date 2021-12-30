`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 07:30:27 PM
// Design Name: 
// Module Name: 32BRCA
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

// Delayed 32-bit ripple carry adder
module ThirtyTwoBitRCA_D_str(
    output c_out,
    output [31:0] sum,
    input [31:0] a,
    input [31:0] b,
    input c_in
    );
    
    wire c_next;            // the carry out of the 16-bit adder that sums bits 15-0 of a and b
    
    //compute sum using 2 16-bit RCA's
    SixteenBitRCA_D_str      SixteenBitRCA15_0        (.c_out(c_next), .sum(sum[15:0]), .a(a[15:0]), .b(b[15:0]), .c_in(c_in));       // compute sum of bits 15-0 of a and b with c_in using a 16-bit RCA
    SixteenBitRCA_D_str      SixteenBitRCA31_16       (.c_out(c_out), .sum(sum[31:16]), .a(a[31:16]), .b(b[31:16]), .c_in(c_next));   // compute sum of bits 31-16 of a and b with c_next using a 16-bit RCA
    
endmodule