`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2021 08:10:52 PM
// Design Name: 
// Module Name: Stage1Reg
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

module Stage1Reg#(
    parameter N = 32
)(
    output reg [4:0] S1_RS1,        // 5-bit Read Select 1, specify first register to read
    output reg [4:0] S1_RS2,        // 5-bit Read Select 2, specify second register to read
    output reg [15:0] S1_IMM,       // 16-bit Immediate, specify immediate value (I Format)
    output reg S1_DS,               // 1-bit Data Source, specify I or R format
    output reg [2:0] S1_ALUOp,      // 3-bit ALU Operation Code, specify which ALU operation to perform
    output reg [4:0] S1_WS,         // 5-bit Write Select, specify which register to write ALU output
    output reg S1_WE,               // 1-bit Write Enable, specify if WS register can be updated
    input [N-1:0] InstrIn,          // 32-bit Instruction
    input Reset,
    input Clk,
    input WriteEnable
    );
    
    // Instanitate registers for Stage1
    always @ (posedge Clk)                          // Update register values on next positive edge of clock
        if (Reset) begin                            // If Reset signal is 1, set register values to 0
            S1_RS1 <= 1'b0;
            S1_RS2 <= 1'b0;
            S1_IMM <= 1'b0;
            S1_DS <= 1'b0;
            S1_ALUOp <= 1'b0;
            S1_WS <= 1'b0;
        end
        else begin
            if(WriteEnable)                         // If WriteEnable signal is 1, set register values
                S1_RS1 <= InstrIn[20:16];           // Read Select 1 is bits 20-16 of 32-bit instruction
                S1_RS2 <= InstrIn[15:11];           // Read Select 2 is bits 15-11 of 32-bit instruction
                S1_IMM <= InstrIn[15:0];            // Read Select 1 is bits 15-0 of 32-bit instruction
                S1_DS <= InstrIn[29];               // Read Select 1 is bit 29 of 32-bit instruction
                S1_ALUOp <= InstrIn[28:26];         // Read Select 1 is bits 28-26 of 32-bit instruction
                S1_WS <= InstrIn[25:21];            // Read Select 1 is bits 25-21 of 32-bit instruction
                S1_WE <= WriteEnable;
            end       
endmodule