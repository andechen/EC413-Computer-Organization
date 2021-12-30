`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2021 08:11:54 AM
// Design Name: 
// Module Name: NBitRegister
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

// N bit Register
module NBitRegister_str#(
    parameter N = 32
)(
    output wire [N-1:0] Q,
    input [N-1:0] D,
    input clk
    );
    
    genvar i;               // loop counter
    
    generate
        for (i = 0; i < N; i = i+1)
            begin: generate_NBitReigster_str
                dff     DFFi    (.q(Q[i]), .d(D[i]), .clk(clk));
        end
    endgenerate   
    
endmodule
