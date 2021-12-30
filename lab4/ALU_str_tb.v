`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2021 10:39:01 PM
// Design Name: 
// Module Name: ALU_str_tb
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


module ALU_str_tb;

    parameter N = 32;
    
    // Inputs
    reg [N-1:0] a;
    reg [N-1:0] b;
    reg c_in;
    reg [2:0] ALUOp;
    reg clk;
    
    // Outputs
    wire [N-1:0] overall_out;
    wire c_out;
    
    wire [N-1:0] ALU_verify;            // Verification output from ALU_Behavioral
    
    wire error_flag;
    
    // Initialize ALU for testing
    ALU_str #(.N(N)) ALU_1 (
        .overall_out(overall_out[N-1:0]),
        .c_out(c_out),
        .a(a[N-1:0]),
        .b(b[N-1:0]),
        .c_in(c_in),
        .ALUOp(ALUOp[2:0]),
        .clk(clk)
    );
    
    // Initialize Verification ALU
    ALU_behavioral #(.N(N)) ALU_B (
        .R2(a[N-1:0]),
        .R3(b[N-1:0]),
        .ALUOp(ALUOp[2:0]),
        .R1(ALU_verify[N-1:0])
    );  
    
    // Assign Error Flag
    assign error_flag = (overall_out != ALU_verify);
    
    // Verification Logic
    always @ (posedge clk)
        begin
            if(error_flag)
                $display("Error occurs when a = %d, b = %d, c_in = %d\n", a, b, c_in);
        end
    
    // Define clk signal for Verification purpose
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        
        // Initialize inputs to 0
        a = 0;
        b = 0;
        c_in = 0;
        
        // Wait 20 ns
        #20;
        // Case 1: MOV random input a
        ALUOp = 3'b000;
        a = 32'hfae34b91;
        
        // Wait 20 ns
        #20;
        // Case 2: NOT random input a
        ALUOp = 3'b001;
        a = 32'hfae34b91;
        
        // Wait 20 ns
        #20;
        // Case 3: OR random input a
        ALUOp = 3'b100;
        a = 32'hfae34b91;
        b = 32'h2ba8b508;
        
        // Wait 20 ns
        #20;
        // Case 4: AND random input a
        ALUOp = 3'b101;
        a = 32'hfae34b91;
        b = 32'h2ba8b508;
        
        // Wait 20 ns
        #20;
        // Case 5: ADD big values w/ overflow
        ALUOp = 3'b010;
        a = 32'hffffffff;
        b = 32'h0000000a;

        // Wait 20 ns
        #20;
        // Case 6: ADD big values w/o overflow 
        ALUOp = 3'b010;
        a = 32'hfa230b01;
        b = 32'h00aaf2fd;
        
        // Wait 20 ns
        #20;
        // Case 7: ADD small values
        ALUOp = 3'b010;
        a = 32'h000000b1;
        b = 32'h000000aa;
 
        // Wait 20 ns
        #20;
        // Case 8: ADD negative and positive values w/ negative sum
        ALUOp = 3'b010;
        a = -32'hf0002ae5;
        b = 32'h0ab328fa;
        
        // Wait 20 ns
        #20;
        // Case 9: ADD negative and positive values w/ positive sum
        ALUOp = 3'b010;
        a = 32'h01232ae5;
        b = -32'hfab328fa;

        // Wait 20 ns
        #20;
        // Case 10: SUB same values
        ALUOp = 3'b011;
        a = 32'hfa230b01;
        b = 32'hfa230b01;
        
        // Wait 20 ns
        #20;
        // Case 11: SUB values for negative difference 
        ALUOp = 3'b011;
        a = 32'h00aaf2fd;
        b = 32'hfa230b01;
        
        // Wait 20 ns
        #20;
        // Case 12: SUB values for positive difference 
        ALUOp = 3'b011;
        a = 32'hfa230b01;
        b = 32'h00aaf2fd;
        
        // Wait 20 ns
        #20;
        // Case 13: SUB zero
        ALUOp = 3'b011;
        a = 32'hfa230b01;
        b = 32'h0;
        
        // Wait 20 ns
        #20;
        // Case 14: SUB random values a and b
        ALUOp = 3'b011;
        a = 32'hfae34b91;
        b = 32'h2ba8b508;
        /*
        // Wait 20 ns
        #20;
        // Case 15: SLT a is bigger, both positive
        ALUOp = 3'b110;
        a = 32'h0fffabcd;
        b = 32'h00000111;
        
        // Wait 20 ns
        #20;
        // Case 16: SLT a is smaller, both negative
        ALUOp = 3'b110;
        a = 32'hffffabcd;
        b = 32'hf0000111;
        
        // Wait 20 ns
        #20;
        // Case 17: SLT a is smaller, both positive
        ALUOp = 3'b110;
        a = 32'h00000111;
        b = 32'h0fffabcd;
        
        // Wait 20 ns
        #20;
        // Case 18: SLT a is bigger, both negative
        ALUOp = 3'b110;
        a = 32'hf0000111;
        b = 32'hffffabcd;
        
        // Wait 20 ns
        #20;
        // Case 19: SLT a = b, both positive
        ALUOp = 3'b110;
        a = 32'h0000adbc;
        b = 32'h0000adbc;
        
        // Wait 20 ns
        #20;
        // Case 20: SLT a = b, both negative
        ALUOp = 3'b110;
        a = 32'hf000adbc;
        b = 32'hf000adbc;
        
        // Wait 20 ns
        #20;
        // Case 21: SLT a = b, both 0
        ALUOp = 3'b110;
        a = 32'h0;
        b = 32'h0;
        
        // Wait 20 ns
        #20;
        // Case 22: SLT a is negative, b is positive
        ALUOp = 3'b110;
        a = 32'hffffabcd;
        b = 32'h0000adbc;
        
        // Wait 20 ns
        #20;
        // Case 23: SLT a is positive, b is negative
        ALUOp = 3'b110;
        a = 32'h0000adbc;
        b = 32'hffffabcd;
        
        // Wait 20 ns
        #20;
        // Case 24: SLT a is 0, b is positive
        ALUOp = 3'b110;
        a = 32'h0;
        b = 32'h0000adbc;
        
        // Wait 20 ns
        #20;
        // Case 25: SLT a is 0, b is negative
        ALUOp = 3'b110;
        a = 32'h0;
        b = 32'hffffabcd;
        
        // Wait 20 ns
        #20;
        // Case 26: SLT a is positive, b is 0
        ALUOp = 3'b110;
        a = 32'h0000adbc;
        b = 32'h0;
        
        // Wait 20 ns
        #20;
        // Case 27: SLT a is negative, b is 0
        ALUOp = 3'b110;
        a = 32'hffffabcd;
        b = 32'h0;
        */
    end
            
endmodule
