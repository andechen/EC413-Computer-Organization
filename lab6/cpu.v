`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:33 10/25/2016 
// Design Name: 
// Module Name:    cpu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// 8 bit data
// 4 bit wide address for memories and reg file
// 32 bit wide instruction
// 4 bit immediate

module cpu(
    rst,
    clk,
    initialize,
    instruction_initialize_data,
    instruction_initialize_address
    );
	 
	 	 
    input rst;
	input clk;
	input initialize;
	input [31:0] instruction_initialize_data;
	input [31:0] instruction_initialize_address;
	
	
	wire [31:0] PC_out;
	wire [31:0] instruction;
	wire [31:0] instruction_mem_out;
	assign instruction = (initialize) ? 32'hFFFF_FFFF : instruction_mem_out;
    InstrMem                      InstructionMemory    (instruction_mem_out , instruction_initialize_data  , (initialize) ? instruction_initialize_address : PC_out , initialize , clk);
	
	// Wire outputs from Control
	wire [1:0] ALUOp;
	wire MemRead;
	wire MemtoReg;
	wire RegDst;
	wire Branch; 
	wire ALUSrc;
	wire MemWrite;
	wire RegWrite;
	wire Jump;                     // jump signal bit obtained from 6-bit instruction
	wire BNE;                      // BNE signal bit obtained from 6-bit instruction
	wire LUI;                      // LUI signal bit obtained from 6-bit instruction
    control                        Control             (instruction [31:26], ALUOp, MemRead, MemtoReg, RegDst, Branch, ALUSrc, MemWrite, RegWrite, Jump, BNE, LUI); 
	 
	   
	wire [31:0] write_data;
    wire [4:0] write_register;
    wire [31:0] read_data_1, read_data_2;
	wire [31:0] ALUOut, MemOut;
	
	mux                    #(5)    Write_Reg_MUX       (RegDst, instruction[20:16], instruction[15:11], write_register);
	nbit_register_file             Register_File       (write_data, read_data_1, read_data_2, instruction[25:21] , instruction[20:16], write_register, RegWrite, clk);
    
	 
	wire [31:0] immediate;
    sign_extend                    Sign_Extend          (instruction[15:0], immediate);
	
	// TASK 6: LUI
	wire [31:0] LUI_imm;
	wire [31:0] LUI_mux_out;
	assign LUI_imm = {immediate[15:0], 16'b0};                                 // take original immediate (instruction[15:0]) and append 16 bits of 0 to the end (to the right)
	mux                   #(32)   LUI_MUX             (LUI,                    // LUI control bit is the select for the MUX that chooses between the regular sign-extended 32-bit immediate or the 32-bit immediate after we appended 16 bits of 0 to the end of the original immediate (instruction[15:0])
	                                                   immediate,              // the sign-extended 32-bit immediate
	                                                   LUI_imm,                // the 32-bit immediate after we appended 16 bits of 0 to the end of the original immediate (instruction[15:0])
	                                                   LUI_mux_out);           // the output of the MUX
	
	// Wire inputs and outputs of ALU
	wire [31:0] ALU_input_2;
    wire zero_flag;
	wire [2:0] ALU_function;
	mux                    #(32)   ALU_Input_2_Mux     (ALUSrc, read_data_2, LUI_mux_out, ALU_input_2);                // Now, in_1 is the output of the LUI MUX	
	
	ALU_control                    ALU_Control         (instruction[5:0], ALUOp, ALU_function);
    ALU                            ALU                 (read_data_1, ALU_input_2, ALU_function, ALUOut, zero_flag);
	 
	// Memory 
	Memory                         Data_Memory         (ALUOut, read_data_2, MemOut, MemRead, MemWrite, clk);


    mux                    #(32)   ALU_Mem_Select_MUX  (MemtoReg, ALUOut, MemOut, write_data);	 
	 
	 
	 wire [31:0] PC_in;
	 PC                            Program_Counter     (PC_out, PC_in, clk, rst);
	 
	 wire [31:0] PC_plus_4;
	 Adder                 #(32)   PC_Increment_Adder  (PC_out, 32'd4, PC_plus_4);


	 wire [31:0] Branch_target_address;
	 wire [31:0] immediate_x_4;
	 shift_left_2          #(32)   Shift_Left_Two      (LUI_mux_out, immediate_x_4);
	 Adder                 #(32)   Branch_Target_Adder (PC_plus_4, immediate_x_4, Branch_target_address); 
	 
	 wire PCSrc;
	 wire [31:0] Branch_MUX_out;
	 wire Branch_AND;
	 wire BNE_AND;
	 wire zero_not;
	 // TASK 5: BNE
	 // OR between BNE control signal AND inverted zero_flag and Branch control signal AND zero_flag
	 // This implementation allows for us to keep the existing MIPS datapath with the addition of a few simple logic gates and a control signal, BNE, which we obtain from the 6 bits of instruction input
	 and                           Br_AND          (Branch_AND, Branch, zero_flag);
	 not                           not_zero        (zero_not, zero_flag);
	 and                           Bn_AND          (BNE_AND, BNE, zero_not);
	 or                            PC_src          (PCSrc, Branch_AND, BNE_AND);
     
     //assign PCSrc = ((~zero_flag & BNE) | Branch_AND);
	 
	 mux                   #(32)   PC_Input_MUX        (PCSrc, PC_plus_4, Branch_target_address, Branch_MUX_out);
	 
	 // TASK 4: J
	 wire [25:0] shifted_instr;
	 wire [31:0] jump_address;
	 // Shift Instruction[25:0] left 2 bits and concxatenate with first 4 bits of PC_plus_4
	 shift_left_2          #(26)   JUMP_SHIFT          (instruction[25:0], shifted_instr);
	 
	 assign jump_address = {PC_out[31:28], shifted_instr, 2'b00};
	 mux                   #(32)   JUMP_MUX            (Jump,	                 // jump wire from Control is mux select
	                                                    Branch_MUX_out,	         // output of Branch_Target_Adder is input 0
	                                                    jump_address,	         // jump_address is input 1
	                                                    PC_in);	                 // output of jump mux is new PC input
	                                                    

	                                                    	 							 
endmodule