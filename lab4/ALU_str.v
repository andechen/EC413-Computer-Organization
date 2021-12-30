`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 09:54:46 PM
// Design Name: 
// Module Name: ALU_str
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


module ALU_str#(
    parameter N = 32
)(
    output [N-1:0] overall_out,         // overall output of the ALU (R1)
    output c_out,                       // overall carry out of the ALU
    input [N-1:0] a,                    // N-bit input a (R2)
    input [N-1:0] b,                    // N-bit input b (R3)
    input c_in,                         // overall carry in
    input [2:0] ALUOp,                  // 3-bit operation code (ALUOp)
    input clk                           // clock for registers
    );
    
    wire [N-1:0] MOV;                   // output of MOV module
    wire [N-1:0] NOT;                   // output of NOT module
    wire [N-1:0] ADD;                   // output of ADD module
    wire [N-1:0] ADD_cout;              // carry out of ADD module
    wire [N-1:0] SUB;                   // output of SUB module
    wire [N-1:0] SUB_cout;              // carry out of SUB module
    wire [N-1:0] OR;                    // output of OR module
    wire [N-1:0] AND;                   // output of AND module
    wire [N-1:0] SLT;                   // output of SLT module
    
    wire [N-1:0] MUX;                   // appropriate output selected by MUX
    wire [N-1:0] MUX_cout;              // appropriate oarry out selected by MUX
    
    // MOV: return input a
    assign MOV[N-1:0] = a[N-1:0];
    
    // NOT - Pre-Lab 4: Bitwise NOT of input a
    NBitNOT_str            #(.N(N))    NOTa        (.out(NOT[N-1:0]), .in(a[N-1:0]));
    
    // ADD - Pre-Lab 4: N-bit addition of a and b
    NBitAdder_str          #(.N(N))    ADDa_b      (.sum(ADD[N-1:0]), .c_out(ADD_cout), .a(a[N-1:0]), .b(b[N-1:0]), .c_in(c_in));
    
    // SUB: N-bit subtraction of a and b
    NBitSubtractor_str     #(.N(N))    SUBa_b      (.sum(SUB[N-1:0]), .c_out(SUB_cout), .a(a[N-1:0]), .b(b[N-1:0]), .c_in(c_in));
    
    // OR: Bitwise OR of inputs a and b
    NBitOR_str             #(.N(N))    ORa_b       (.out(OR[N-1:0]), .input1(a[N-1:0]), .input2(b[N-1:0]));
    
    // AND: Bitwise AND of inputs a and b
    NBitAND_str            #(.N(N))    ANDa_b      (.out(AND[N-1:0]), .input1(a[N-1:0]), .input2(b[N-1:0]));
    
    // SLT: Extra Credit TODO
    //NBitSLT_str             #(.N(N))    SLTa_b     (.out(SLT[N-1:0]), .input1(a[N-1:0]), .input2(b[N-1:0]));
    
    // MUX - Pre-Lab 4: use a 3-8 MUX to select correct output based on operation code
    mux_str                #(.N(N))    MUX_ops     (.out(MUX[N-1:0]), .MOV(MOV[N-1:0]), .NOT(NOT[N-1:0]), .ADD(ADD[N-1:0]), .SUB(SUB[N-1:0]), .OR(OR[N-1:0]), .AND(AND[N-1:0]), .ALUOp(ALUOp[2:0]));       // mux to select between operations
    mux_str                #(.N(1))    MUX_carry   (.out(MUX_cout[N-1:0]), .MOV(0), .NOT(0), .ADD(ADD_cout), .SUB(SUB_cout), .OR(0), .AND(0), .ALUOp(ALUOp[2:0]));                  
    
    // Registers - Pre-Lab 4: update overall output and overall carry out in registers on posedge of clock
    NBitRegister_str       #(.N(N))    DFF_out     (.Q(overall_out[N-1:0]), .D(MUX[N-1:0]), .clk(clk));
    dff                                DFF_carry   (.q(c_out), .d(MUX_cout), .clk(clk));      
    
endmodule