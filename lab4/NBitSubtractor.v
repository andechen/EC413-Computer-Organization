`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2021 07:50:53 AM
// Design Name: 
// Module Name: NBitSubtractor
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

// N-bit Subtractor
module NBitSubtractor_str#(
    parameter N = 32
)(
    output [N-1:0] sum,         // sum
    output c_out,               // carry out
    input [N-1:0] a,            // input 1
    input [N-1:0] b,            // input 2
    input c_in                  // carry in
    );
    
    wire [N-1:0] c_next;        // carry out of middle adders
    wire [N-1:0] B_NOT;         // bitwise NOT of input b
    wire [N-1:0] B_comp;        // 2's complement of input b
    wire [N-1:0] B_comp_out;    // carry out of computing 2's complement of b
    
    genvar i;                   // loop counter
    
    // Find the 2's Complement of input b (~b + 1)
    NBitNOT_str         #(.N(N))    NOTb        (.out(B_NOT[N-1:0]), .in(b[N-1:0]));    // flip the bits
    NBitAdder_str       #(.N(N))    ADDb_1      (.sum(B_comp[N-1:0]), .c_out(B_comp_out), .a(B_NOT[N-1:0]), .b(1), .c_in(0));

    // Calculate subtraction by summing a + B_comp
    generate
        for(i = 0; i < N; i = i+1)
            begin: generate_NBitAdder_str
                if(i == 0)
                    FA_str      FA0     (.c_out(c_next[0]), .sum(sum[0]), .a(a[0]), .b(B_comp[0]), .c_in(c_in));          // for least signficant bit adder, take the overall carry in
                else
                    FA_str      FAi     (.c_out(c_next[i]), .sum(sum[i]), .a(a[i]), .b(B_comp[i]), .c_in(c_next[i-1]));   // for each ith adder, take the previous adder's carry out as its carry in
        end
        assign c_out = c_next[N-1];                                                                                       // take the carry out of the most significant bit adder as the overall carry out
     endgenerate 
     
endmodule