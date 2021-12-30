`timescale 1ns / 1ns


module tb_cpu;

	// Inputs
	reg rst;
	reg clk;
	reg initialize;
	reg [31:0] instruction_initialize_data;
	reg [31:0] instruction_initialize_address;

	// Instantiate the Unit Under Test (UUT)
	cpu uut (
		.rst(rst), 
		.clk(clk), 
		.initialize(initialize), 
		.instruction_initialize_data(instruction_initialize_data), 
		.instruction_initialize_address(instruction_initialize_address)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 0;
		initialize = 1;
		instruction_initialize_data = 0;
		instruction_initialize_address = 0;

		#100;
      
		instruction_initialize_address = 0;
		instruction_initialize_data = 32'b000000_00000_00010_00001_00000_10_0000;      // ADD R1, R0, R2
		#20;
		instruction_initialize_address = 4;
		instruction_initialize_data = 32'b000000_00100_00100_01000_00000_10_0010;      // SUB R8, R4, $4
		#20;
		instruction_initialize_address = 8;
		instruction_initialize_data = 32'b000000_00101_00110_00111_00000_10_0101;      // OR R7, R5, R6
		#20;
		instruction_initialize_address = 12;
		instruction_initialize_data = 32'b101011_00000_01001_00000_00000_00_1100;      // SW R9, 12(R0)
		#20;
		instruction_initialize_address = 16;
		instruction_initialize_data = 32'b100011_00000_01100_00000_00000_00_1100;      // LW R12, 12(R0)
		#20	
        instruction_initialize_address = 20;
		instruction_initialize_data = 32'b000100_00000_00000_00000_00000_00_0010;      // BEQ R0, R0, 2
		#20;
        // TASK 2 TEST CASE: SLT
		instruction_initialize_address = 32;
		instruction_initialize_data = 32'b000000_00000_00010_00001_00000_10_1010;      // SLT R1, R0 (0), R2 (20) -> R1 = 1     
		                                                                               // Opcode = 000000
		                                                                               // Rs = R0
		                                                                               // Rt = R2
		                                                                               // Rd = R1
		                                                                               // Shamt = 00000
		                                                                               // Function = 101010
		#20;
		
		// TASK 3 TEST CASE: ADDI
		instruction_initialize_address = 36;
		instruction_initialize_data = 32'b001000_00100_00001_01111_01000_11_1111;      // ADDI R1 , R4 (40), 16'h7A3F = 
				                                                                       // Opcode = 001000
		                                                                               // Rs = R4
		                                                                               // Rt = R1
		                                                                               // Immediate = 0111 1010 0011 1111 (31295)
		#20;
		
		// TASK 5 TEST CASE: BNE
		instruction_initialize_address = 40;
		instruction_initialize_data = 32'b000101_01000_01100_00000_00000_00_0001;      // BNE R8, R12, 1
                                                                                       // Opcode = 000101
		                                                                               // Rs = R8
		                                                                               // Rt = R12
		                                                                               // Offset = 0000 0000 0000 0001
		#20;
		
		// TASK 6 TEST CASE: LUI
		instruction_initialize_address = 48;
		instruction_initialize_data = 32'b001111_00000_00101_00101_01111_01_1000;      // LUI R5, 16'h2BD8
                                                                                       // Opcode = 001111
                                                                                       // Rt = R5
		                                                                               // Immediate = 0010 1011 1101 1000
        #20;
		
		// TASK 4 TEST CASE: J
		instruction_initialize_address = 52;
		instruction_initialize_data = 32'b000010_00000_00000_00000_00000_00_0100;      // J 4
						                                                               // Opcode = 000010
		                                                                               // Offset = 00000 00000 00000 00000 000100
		#20;
		
		initialize = 0;
		rst = 0;
		
	end
      
always
#5 clk = ~clk;
endmodule

