`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2021 08:10:52 PM
// Design Name: 
// Module Name: Stage3Reg
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


module Stage3Reg#(
    parameter N = 32
)(
    output reg [N-1:0] ALUOut,          // N-bit overall output of pipeline ALUOut
    output reg [N-1:0] S3_ALUOut,       // N-bit wire connecting ALU output back to Register File WriteData
    output reg [4:0] S3_WS,             // 5-bit Write Select, specify which register to write ALU output
    output reg S3_WE,                   // 1-bit Write Enable, specify if WS register can be updated
    input [N-1:0] ALU_out,              // N-bit output of ALU module
    input [4:0] S2_WS,                  // 5-bit Write Select, specify which register to write ALU output
    input S2_WE,                        // 1-bit Write Enable, specify if WS register can be updated
    input Reset,
    input Clk,
    input WriteEnable
    );
    
    // Instanitate registers for Stage3
    always @ (posedge Clk)                          // Update register values on next positive edge of clock
        if (Reset) begin                            // If Reset signal is 1, set register values to 0
            ALUOut <= 1'b0;
            S3_ALUOut <= 1'b0;
            S3_WS <= 1'b0;
            S3_WE <= 1'b0;
        end
        else begin
            if(WriteEnable)                         // If WriteEnable signal is 1, set register values
                ALUOut <= ALU_out;                  // Overall output of pipeline ALUOut is contents of ALU_out register
                S3_ALUOut <= ALU_out;               // WriteData in Register File is contents of ALU_out register
                S3_WS <= S2_WS;                     // WriteSeelct is WriteSelect from Stage2
                S3_WE <= S2_WE;                     // WriteEnable is WriteEnable from Stage2
            end    
endmodule
