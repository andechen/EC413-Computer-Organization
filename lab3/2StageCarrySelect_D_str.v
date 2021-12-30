`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 08:04:41 PM
// Design Name: 
// Module Name: 2StageCarrySelect
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

// Delayed 2 Stage 64-bit Carry Select Adder
module TwoStageCarrySelect_D_str(
    output c_out,               // the overall carry out of the 2 stage 64-bit carry select adder
    output [63:0] sum,          // the overall sum of the 2 stage 64-bit carry select adder
    input [63:0] a,             // input 1
    input [63:0] b,             // input 2
    input c_in                  // carry in
    );

    wire c_next;                // the c_out from the sum of bits 31-0 of a and b
    wire [31:0] sum_0;          // the sum if the c_in of the adder for bits 63-32 of a and b is 0
    wire [31:0] sum_1;          // the sum if the c_in of the adder for bits 63-32 of a and b is 1
    wire c_0;                   // the c_out if the c_in of the adder for bits 63-32 of a and b is 0
    wire c_1;                   // the c_out if the c_in of the adder for bits 63-32 of a and b is 1

    // compute the sum of bits 0-31 of a and b
    ThirtyTwoBitRCA_D_str      ThirtyTwoBitRCA31_0     (.c_out(c_next), .sum(sum[31:0]), .a(a[31:0]), .b(b[31:0]), .c_in(c_in));
    
    // compute the sum of bits 32-64 of a and b if the carry in is 0
    ThirtyTwoBitRCA_D_str      ThirtyTwoBitRCA0        (.c_out(c_0), .sum(sum_0[31:0]), .a(a[63:32]), .b(b[63:32]), .c_in(0));
    // compute the sum of bits 32-64 of a and b if the carry in is 1
    ThirtyTwoBitRCA_D_str      ThirtyTwoBitRCA1        (.c_out(c_1), .sum(sum_1[31:0]), .a(a[63:32]), .b(b[63:32]), .c_in(1));
    
    // use a mux that takes sum_0, sum_1, and c_next to select the correct sum
    mux_str                  mux_sum                 (.out(sum[63:32]), .s(c_next), .in_0(sum_0[31:0]), .in_1(sum_1[31:0]));
    
    // use a mux that takes c_0 and c_1 to select the correct carry out
    //mux_str                  mux_cout                (.out(c_out), .s(c_next), .in_0(c_0), .in_1(c_1));
    assign c_out = c_next ? c_1 : c_0;
    
endmodule