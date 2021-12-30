`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2021 08:14:24 PM
// Design Name: 
// Module Name: 4BFA_str
// Project Name: Four Bit Full Adder
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


module FBFA_str(
    output c_out,
    output [3:0] sum,
    input [3:0] a,
    input [3:0] b,
    input c_in
    );
    
    wire c0, c1, c2;
    
    // compute sum
    FA_str      FA0     (.c_out(c0), .sum(sum[0]), .a(a[0]), .b(b[0]), .c_in(c_in));
    FA_str      FA1     (.c_out(c1), .sum(sum[1]), .a(a[1]), .b(b[1]), .c_in(c0));
    FA_str      FA2     (.c_out(c2), .sum(sum[2]), .a(a[2]), .b(b[2]), .c_in(c1));
    FA_str      FA3     (.c_out(c_out), .sum(sum[3]), .a(a[3]), .b(b[3]), .c_in(c2));
    
endmodule
