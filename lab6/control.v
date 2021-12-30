`timescale 1ns / 1ns

module control(
		input [5:0] instruction,
		output reg [1:0] ALUOp,
		output reg MemRead,
		output reg MemtoReg,
		output reg RegDst,
		output reg Branch, 
		output reg ALUSrc,
		output reg MemWrite,
		output reg RegWrite,
		output reg Jump,                                   // TASK 4: J
		output reg BNE,                                    // TASK 5: BNE
		output reg LUI                                     // TASK 6: LUI
		);


always @(*) begin
		if (instruction == 6'b00_0000) begin				//RType
            ALUOp = 2'b00;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            RegDst = 1'b1;
            Branch = 1'b0;		
            ALUSrc = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            Jump = 1'b0;
            BNE = 1'b0;
            LUI = 1'b0;
		end else if (instruction == 6'b00_0100) begin   //branch
            ALUOp = 2'b01;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            RegDst = 1'b0;
            Branch = 1'b1;		
            ALUSrc = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            Jump = 1'b0;
            BNE = 1'b0;
            LUI = 1'b0;
		end else if (instruction == 6'b10_1011) begin   // sw
            ALUOp = 2'b10;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            RegDst = 1'b0;
            Branch = 1'b0;		
            ALUSrc = 1'b1;
            MemWrite = 1'b1;
            RegWrite = 1'b0;
            Jump = 1'b0;
            BNE = 1'b0;
            LUI = 1'b0;
		end else if (instruction == 6'b10_0011) begin   // lw
            ALUOp = 2'b10;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            RegDst = 1'b0;
            Branch = 1'b0;		
            ALUSrc = 1'b1;
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            Jump = 1'b0;
            BNE = 1'b0;
            LUI = 1'b0;
            
		end else if (instruction == 6'b00_1000) begin   // TASK 3: addi = d'8
            ALUOp = 2'b10;                              // ALUOp = 10 -> ADD
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            RegDst = 1'b0;                              // RegDst = 0 -> Write result to same register as Read register 2
            Branch = 1'b0;		                        // Branch = 0 -> Not branching
            ALUSrc = 1'b1;                              // ALUSrc = 1 -> Use Immediate as ALU input 2
            MemWrite = 1'b0;
            RegWrite = 1'b1;
            Jump = 1'b0;
            BNE = 1'b0;
            LUI = 1'b0;
            
		end else if (instruction == 6'b00_0010) begin   // TASK 4: j = d'2
            ALUOp = 2'b11;                              // Not computing anything
            MemRead = 1'b0;                             // Reading memory address of jump location
            MemtoReg = 1'b0;                            // Not writing to any register
            RegDst = 1'b0;                              // Not writing to any register
            Branch = 1'b0;		                        // 
            ALUSrc = 1'b0;                              // Not computing anything with ALU
            MemWrite = 1'b0;                            // Not writing to memory
            RegWrite = 1'b0;                            // Not writing to any register
            Jump = 1'b1;                                // Enable Jump
            BNE = 1'b0;                                 // Using BNE function
            LUI = 1'b0;                                 // Not using LUI function
            
        end else if (instruction == 6'b00_0101) begin   // TASK 5: bne = d'5
            ALUOp = 2'b01;                              // Using ALU to subtract one input from the other (to check if the inputs are equal in value)
            MemRead = 1'b0;                             // Not reading from memory
            MemtoReg = 1'b0;                            // Not writing to any register
            RegDst = 1'b0;                              // Using register target
            Branch = 1'b1;		                        // 
            ALUSrc = 1'b0;                              // ALUSrc unnecessary
            MemWrite = 1'b0;                            // Not writing to memory
            RegWrite = 1'b0;                            // Not writing to any register
            Jump = 1'b0;                                // Not performing a jump
            BNE = 1'b1;                                 // Using BNE function
            LUI = 1'b0;                                 // Not using LUI function
            
        end else if (instruction == 6'b00_1111) begin   // TASK 6: lui = d'15
            ALUOp = 2'b10;                              // 
            MemRead = 1'b1;                             // Reading from memory
            MemtoReg = 1'b0;                            // Writing to a register
            RegDst = 1'b0;                              // Using register target
            Branch = 1'b0;		                        // Not branching
            ALUSrc = 1'b1;                              // Choosing 32-bit sign-extended immediate (whether or not LUI is being used)
            MemWrite = 1'b0;                            // Not writing to memory
            RegWrite = 1'b1;                            // Writing to a register
            Jump = 1'b0;                                // Not performing a jump
            BNE = 1'b0;                                 // Not using BNE function
            LUI = 1'b1;                                 // Using LUI function
            
		end else begin
            ALUOp = 2'b00;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            RegDst = 1'b0;
            Branch = 1'b0;		
            ALUSrc = 1'b0;
            MemWrite = 1'b0;
            RegWrite = 1'b0;
            Jump = 1'b0;
            BNE = 1'b0;
            LUI = 1'b0;
		end
	
end
endmodule
