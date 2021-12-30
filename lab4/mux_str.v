`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 06:22:19 PM
// Design Name: 
// Module Name: mux_str
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


module mux_str#(
    parameter N = 32
)(
    output reg [N-1:0] out,
    input [N-1:0] MOV,
    input [N-1:0] NOT,
    input [N-1:0] ADD,
    input [N-1:0] SUB,
    input [N-1:0] OR,
    input [N-1:0] AND,
    input [N-1:0] SLT,
    input [2:0] ALUOp
    );
    
    always @ *
    begin
        case (ALUOp)
            3'b000:     out[N-1:0] = MOV[N-1:0];
            3'b001:     out[N-1:0] = NOT[N-1:0];
            3'b010:     out[N-1:0] = ADD[N-1:0];
            3'b011:     out[N-1:0] = SUB[N-1:0];
            3'b100:     out[N-1:0] = OR[N-1:0];
            3'b101:     out[N-1:0] = AND[N-1:0];
            3'b110:     out[N-1:0] = SLT[N-1:0];
        endcase
    end
    
endmodule