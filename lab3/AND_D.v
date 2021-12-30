`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:07 09/27/2015 
// Design Name: 
// Module Name:    AND_T 
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
`define	D		1	// definition of the delay

// Delayed AND gate

module AND_D(out, in1, in2);

input in1, in2;
output out;

and		#`D		and1(out, in1, in2);


endmodule
