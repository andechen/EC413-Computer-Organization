`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2021 08:56:30 PM
// Design Name: 
// Module Name: 4BFA_str_tb
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


module FBFA_str_tb;

    // Inputs
    reg [3:0] a;
    reg [3:0] b;
    reg c_in;
    
    reg clk;
    
    // Outputs
    wire c_out;
    wire [3:0] sum;
    wire c_out_verify;
    wire [3:0] sum_verify;
    wire error_flag;
    
    
    // Instantiate the Unit Under Test (UUT)
	FBFA_str FBFA (
		.c_out(c_out), 
		.sum(sum), 
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);
	
	// Verification module
	Verification_4bit Verification (
		.c_out(c_out_verify), 
		.sum(sum_verify), 
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);
	
	// Assign Error_flag
	assign error_flag = (c_out != c_out_verify || sum != sum_verify);
	
	// Verification logic
	always@(posedge clk)
		begin
		if(error_flag)
			$display("Error occurs when a = %d, b = %d, c_in = %d\n", a, b, c_in);
		end
		
	// Derfine clk signal for Verfication purpose
	always #5 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		
		// Test 0 inputs case
		a = 4'b0000;
		b = 4'b0000;
		c_in = 0;
		// Expected output  = 00000
		
		// Test carry out case
        // Wait 10 ns
		#10;
		a = 4'b1111;
		b = 4'b1111;
		c_in = 1;
		// Expected output: 11111
		
		// Test no carry out case
        // Wait 10 ns
		#10;
		a = 4'b1010;
		b = 4'b0101;
		c_in = 0;
		//Expected output: 01111
		
    end
		
endmodule