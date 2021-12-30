`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 07:30:27 PM
// Design Name: 
// Module Name: 8BRCA
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


module EightBitRCA_str(
    output c_out,
    output [7:0] sum,
    input [7:0] a,
    input [7:0] b,
    input c_in
    );
    
    wire c_next;            // the carry out of the 4-bit adder that sums bits 3-0 of a and b
    
    //compute sum using 2 4-bit RCA's
    FBFA_str      FBFA3_0     (.c_out(c_next), .sum(sum[3:0]), .a(a[3:0]), .b(b[3:0]), .c_in(c_in));       // compute sum of bits 3-0 of a and b with c_in using a 4-bit RCA
    FBFA_str      FBFA7_4     (.c_out(c_out), .sum(sum[7:4]), .a(a[7:4]), .b(b[7:4]), .c_in(c_next));      // compute sum of bits 7-4 of a and b with c_next using a 4-bit RCA  
    
endmodule
