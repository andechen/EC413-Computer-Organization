`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2021 08:10:52 PM
// Design Name: 
// Module Name: Stage2Reg
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

module Stage2Reg#(
    parameter N = 32
)(
    output reg [N-1:0] S2_RD1,        // 5-bit Read Select 1, specify first register to read
    output reg [N-1:0] S2_RD2,        // 5-bit Read Select 2, specify second register to read
    output reg [15:0] S2_IMM,         // 16-bit Immediate, specify immediate value (I Format)
    output reg S2_DS,                 // 1-bit Data Source, specify I or R format
    output reg [2:0] S2_ALUOp,        // 3-bit ALU Operation Code, specify which ALU operation to perform
    output reg [4:0] S2_WS,           // 5-bit Write Select, specify which register to write ALU output
    output reg S2_WE,                 // 1-bit Write Enable, specify if WS register can be updated
    input [N-1:0] RF_RD1,             // 32-bit Read Data 1, contents of regsiter specified by ReadSelect1
    input [N-1:0] RF_RD2,             // 32-bit Read Data 2, contents of regsiter specified by ReadSelect2
    input [15:0] S1_IMM,              // 16-bit Immediate, specify immediate value (I Format)
    input S1_DS,                      // 1-bit Data Source, specify I or R format
    input [2:0] S1_ALUOp,             // 3-bit ALU Operation Code, specify which ALU operation to perform
    input [4:0] S1_WS,                // 5-bit Write Select, specify which register to write ALU output
    input S1_WE,                      // 1-bit Write Enable, specify if WS register can be updated
    input Reset,
    input Clk,
    input WriteEnable
    );
    
    // Instanitate registers for Stage2
    always @ (posedge Clk)                          // Update register values on next positive edge of clock
        if (Reset) begin                            // If Reset signal is 1, set register values to 0
            S2_RD1 <= 1'b0;
            S2_RD2 <= 1'b0;
            S2_IMM <= 1'b0;
            S2_DS <= 1'b0;
            S2_ALUOp <= 1'b0;
            S2_WS <= 1'b0;
        end
        else begin
            if(WriteEnable)                         // If WriteEnable signal is 1, set register values
                S2_RD1 <= RF_RD1;                   // Read Data 1 is Read Data 1 output from register file
                S2_RD2 <= RF_RD2;                   // Read Data 2 is Read Data 2 output from register file
                S2_IMM <= S1_IMM;                   // Immediate is Immediate from Stage1
                S2_DS <= S1_DS;                     // Data Source is Data Source from Stage1
                S2_ALUOp <= S1_ALUOp;               // ALUOp is ALUOp from Stage1
                S2_WS <= S1_WS;                     // WriteSelect is WriteSelect from Stage1
                S2_WE <= S1_WE;                     // WriteEnable is WriteEnable from Stage1
            end       
    
endmodule