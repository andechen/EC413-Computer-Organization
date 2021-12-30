`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2021 07:50:53 AM
// Design Name: 
// Module Name: NBitRegister_Adder Testbench
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

// N-bit Register Adder Testbench
module NBitRegister_Adder_str_tb;

    parameter N = 4;
    
    // Inputs
    reg [N-1:0] a;              // input 1
    reg [N-1:0] b;              // input 2
    reg c_in;                   // overall carry in
    reg [2:0] oppcode;          // operation code
    
    reg clk;                    // clock
    
    // Outputs
    wire c_out;               
    wire [N-1:0] overall_out;
    
    wire c_out_verify;          // Verification outputs of adder
    wire [N-1:0] sum_verify;
    
    wire [N-1:0] not_verify;    // Verification outputs of NOT
    
    wire [N-1:0] mux_verify;    // Verification outputs of mux
    
    wire error_flag;
    
    
    // Instantiate the Unit Under Test (UUT)
    NBitRegister_Adder_str #(.N(N)) NBitRegister_Adder (
        .overall_out(overall_out[N-1:0]),
        .c_out(c_out),
        .a(a[N-1:0]),
        .b(b[N-1:0]),
        .c_in(c_in),
        .oppcode(oppcode[2:0]),
        .clk(clk)
    );
            
    // Get Verification output for ADD
    Verification_NBitAdd #(.N(N)) VerificationADD (
        .sum(sum_verify[N-1:0]),
        .c_out(c_out_verify),
        .a(a[N-1:0]),
        .b(b[N-1:0]),
        .c_in(c_in),
        .clk(clk)
    );
    
    // Get Verification output for NOT
    Verification_NBitNOT #(.N(N)) VerificationNOT (
        .out(not_verify[N-1:0]),
        .in(a[N-1:0]),
        .clk(clk)
    );
    
    // Get Verification output for mux
    mux_str #(.N(N)) VerificationMUX (
        .out(mux_verify[N-1:0]),
        .NOT(not_verify[N-1:0]),
        .ADD(sum_verify[N-1:0]),
        .ALUOp(oppcode[2:0])
    );
        
    // Assign Error Flag
    assign error_flag = (overall_out != mux_verify);

    
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
        a = 4'd0;
        b = 4'd0;
        c_in = 0;
        
        // Wait 20 ns
        #40;
        // Test Case 1a:
        oppcode = 3'b001;
        a = 4'b1011;
        b = 4'b1101;
        c_in = 1;
        // Expected Out: 0100 = 4
 
        // Wait 20 ns
        #40;
        // Test Case 1b:
        oppcode = 3'b010;
        a = 4'b1011;
        b = 4'b1101;
        c_in = 1;
        // Expected Out: 11001 = 9

        // Wait 20 ns
        #20;
        // Test Case 2:
        oppcode = 3'b010;
        a = 4'b1111;
        b = 4'b1111;
        c_in = 1;
        
        // Wait 20 ns
        #20;
        // Test Case 3:
        oppcode = 3'b010;
        a = 4'b0000;
        b = 4'b1101;
        c_in = 0;
        
        // Wait 20 ns
        #20;
        // Test Case 4:
        oppcode = 3'b010;
        a = 4'b1010;
        b = 4'b1001;
        c_in = 0;

    end
    
endmodule        