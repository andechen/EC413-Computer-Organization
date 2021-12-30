`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2021 07:50:53 AM
// Design Name: 
// Module Name: NBitRegister_Adder
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

// N-bit Register and Adder
module NBitRegister_Adder_str#(
    parameter N = 32
)(
    output [N-1:0] overall_out, // overall output of the ALU
    output c_out,               // carry out
    input [N-1:0] a,            // input 1
    input [N-1:0] b,            // input 2
    input c_in,                 // overall carry in
    input [2:0] oppcode,              // operation code
    input clk
    );
    
    wire [N-1:0] ADD;           // output of adder
    wire FA_cout;               // carry out of adder
    wire [N-1:0] NOT;           // output of the N-bit NOT module
    wire [N-1:0] mux_out;       // output of the mux
    wire mux_cout;              // carry out of mux
    
    NBitNOT_str         #(.N(N))    NOTa        (.out(NOT[N-1:0]), .in(a[N-1:0]));                                                   // get output of NOT operation
    NBitAdder_str       #(.N(N))    ADDER       (.sum(ADD[N-1:0]), .c_out(FA_cout), .a(a[N-1:0]), .b(b[N-1:0]), .c_in(c_in));        // use N-bit adder to generate sum and carry a
    
    mux_str             #(.N(N))    MUX         (.out(mux_out[N-1:0]), .NOT(NOT[N-1:0]), .ADD(ADD[N-1:0]), .ALUOp(oppcode[2:0]));    // mux to select between operations
    mux_str             #(.N(1))    MUX_carry   (.out(mux_cout), .NOT(0), .ADD(FA_cout), .ALUOp(oppcode[2:0]));                      // mux to select carry out
    
    NBitRegister_str    #(.N(N))    DFF_sum     (.Q(overall_out[N-1:0]), .D(mux_out[N-1:0]), .clk(clk));                             // store carry out in register
    dff                             DFF_carry   (.q(c_out), .d(mux_cout), .clk(clk));                                                // store sum in register
    
endmodule