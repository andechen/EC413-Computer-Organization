`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2021 08:26:39 PM
// Design Name: 
// Module Name: SixtyFourBitRCA_str_tb
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


module SixtyFourBitRCA_str_tb;
    
    // Inputs
    reg [63:0] a;
    reg [63:0] b;
    reg c_in;
    
    reg clk;
    
    // Outputs
    wire c_out;
    wire [63:0] sum;
    wire c_out_verify;
    wire [63:0] sum_verify;
    wire error_flag;
    
    
    // Instantiate the Unit Under Test (UUT)
	SixtyFourBitRCA_str SixtyFourBitRCA (
		.c_out(c_out), 
		.sum(sum), 
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);
	
	// Verification module
	Verification_64bit Verification (
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
		
		// Case 1: Force overall carry out
		a = 64'hffffffffffffffff;
		b = 64'hffffffffffffffff;
		c_in = 1;
		
        // Wait 20 ns
		#20;
		// Case 2: No carry out
		a = 64'h1010101010101010;
		b = 64'h0101010101010101;
		c_in = 0;
		
        // Wait 20 ns
		#20;
		// Case 3:Random large a and b with carry in
		a = 64'hfffab67ac01f8fa3;
		b = 64'hfeab32748aeb39ff;
		c_in = 1;
		
        // Wait 20 ns
		#20;
		// Case 4: Random large a and b without carry in
		a = 64'hfffab67ac01f8fa3;
		b = 64'hfeab32748aeb39ff;
		c_in = 0;
		
        // Wait 20 ns
		#20;
		// Case 5:Random small  a and b with carry in
		a = 64'h00000000ab83fea1;
		b = 64'h0000000000ab3fc0;
		c_in = 1;
		
        // Wait 20 ns
		#20;
		// Case 6: Random small a and b without carry in
		a = 64'h00000000ab83fea1;
		b = 64'h0000000000ab3fc0;
		c_in = 0;
				
		// Wait 20 ns
		#20;
		// Case 7: Random combination without carry in
		a = 64'hfffab67ac01f8fa3;
		b = 64'hfeab32748aeb39ff;
		c_in = 0;
		
        // Wait 20 ns
		#20;
		// Case 8: Random combination with carry in
		a = 64'hfffab67ac01f8fa3;
		b = 64'hfeab32748aeb39ff;
		c_in = 1;
		
    end
		
endmodule