`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2021 03:20:11 PM
// Design Name: 
// Module Name: datapath
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

module Pipeline#(
parameter DATA_WIDTH = 32,
parameter REG_SELECT_WIDTH = 5
)(
    output [DATA_WIDTH-1:0] ALUOut,          // 32-bit overall output of pipeline (output of ALU)
    input [DATA_WIDTH-1:0] InstrIn,          // 32-bit instruction input
    input Reset,
    input Clk,
    input WriteEnable
    );
    
    // Wires connecting Stage 1 to Register File
    wire [4:0] S1_RS1;                       // 5-bit Read Select 1
    wire [4:0] S1_RS2;                       // 5-bit Read Select 2
    
    // Wires connecting Stage 1 to Stage 2
    wire [15:0] S1_IMM;                      // 16 -bit Immediate
    wire S1_DS;                              // 1-bit Data Source
    wire [2:0] S1_ALUOp;                     // 3-bit ALU Operation
    wire [4:0] S1_WS;                        // 5-bit Write Select
    wire S1_WE;                              // 1-bit Write Enable
    
    // Wires connecting Register File to Stage 2
    wire [DATA_WIDTH-1:0] RF_RD1;            // N-bit Read Data 1
    wire [DATA_WIDTH-1:0] RF_RD2;            // N-bit Read Data 2
    
    // Wires connecting Stage 2 to MUX and ALU
    wire [DATA_WIDTH-1:0] S2_RD1;            // N-bit Read Data 1 (R2)
    wire [DATA_WIDTH-1:0] S2_RD2;            // N-bit Read Data 2
    wire [15:0] S2_IMM;                      // 16 -bit Immediate
    wire S2_DS;                              // 1-bit Data Source
    wire [2:0] S2_ALUOp;                     // 3-bit ALU Operation
    wire [DATA_WIDTH-1:0] MUX_OUT;           // Input 2 of ALU (R3)
    
    // Wires connecting ALU and Stage 2 to Stage 3
    wire [DATA_WIDTH-1:0] ALU_out;           // N-bit ALU output (R1)
    wire [4:0] S2_WS;                        // 5-bit Write Select
    wire S2_WE;                              // 1-bit Write Enable
    
    // Wires connecting Stage 3 back to Register File
    wire [DATA_WIDTH-1:0] S3_ALUOut;        // N-bit ALU output connecting back to Write Data of register file
    wire [4:0] S3_WS;                       // 5-bit
    wire S3_WE;                             // 1-bit Write Enable

 //-----------------------------------------------------------------------------------------------------------------------------------------------------------------

    // Instantiate register for Stage 1
    Stage1Reg           #(DATA_WIDTH)   Stage1     (.S1_RS1(S1_RS1),
                                                    .S1_RS2(S1_RS2),
                                                    .S1_IMM(S1_IMM),
                                                    .S1_DS(S1_DS),
                                                    .S1_ALUOp(S1_ALUOp),
                                                    .S1_WS(S1_WS),
                                                    .S1_WE(S1_WE),
                                                    .InstrIn(InstrIn),
                                                    .Reset(Reset),
                                                    .Clk(Clk),
                                                    .WriteEnable(WriteEnable)
                                                    );

    // Instantiate n-bit Register File
    nbit_register_file  #(REG_SELECT_WIDTH,DATA_WIDTH)   RegFile    (.WriteData(S3_ALUOut),
                                                                     .ReadData1(RF_RD1),
                                                                     .ReadData2(RF_RD2),
                                                                     .ReadSelect1(S1_RS1),
                                                                     .ReadSelect2(S1_RS2),
                                                                     .WriteSelect(S3_WS),
                                                                     .WriteEnable(S3_WE),
                                                                     .Reset(Reset),
                                                                     .Clk(Clk));   

    // Instanitate Stage 2 register
    Stage2Reg           #(DATA_WIDTH)   Stage2     (.S2_RD1(S2_RD1),
                                                    .S2_RD2(S2_RD2),
                                                    .S2_IMM(S2_IMM),
                                                    .S2_DS(S2_DS),
                                                    .S2_ALUOp(S2_ALUOp),
                                                    .S2_WS(S2_WS),
                                                    .S2_WE(S2_WE),
                                                    .RF_RD1(RF_RD1),
                                                    .RF_RD2(RF_RD2),
                                                    .S1_IMM(S1_IMM),
                                                    .S1_DS(S1_DS),
                                                    .S1_ALUOp(S1_ALUOp),
                                                    .S1_WS(S1_WS),
                                                    .S1_WE(S1_WE),
                                                    .Reset(Reset),
                                                    .Clk(Clk),
                                                    .WriteEnable(WriteEnable));

    // Instantiate MUX                                                             
    assign MUX_OUT = S2_DS ? S2_IMM : S2_RD2;
    
    // Instantiate ALU
    Ideal_ALU           #(DATA_WIDTH)   ALU        (.R1(ALU_out),
                                                    .R2(S2_RD1),
                                                    .R3(MUX_OUT),
                                                    .ALUOp(S2_ALUOp));
    
    // Instantiate Stage 3 register
    Stage3Reg           #(DATA_WIDTH)   Stage3     (.ALUOut(ALUOut),
                                                    .S3_ALUOut(S3_ALUOut),
                                                    .S3_WS(S3_WS),
                                                    .S3_WE(S3_WE),
                                                    .ALU_out(ALU_out),
                                                    .S2_WS(S2_WS),
                                                    .S2_WE(S2_WE),
                                                    .Reset(Reset),
                                                    .Clk(Clk),
                                                    .WriteEnable(WriteEnable));
  
endmodule