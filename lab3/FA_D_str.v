`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:02 09/28/2013 
// Design Name: 
// Module Name:    FA_str 
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

// Delayed 1-bit full adder
module FA_D_str(c_out, sum, a, b, c_in);

input		a, b, c_in; //declare inputs a, b and c_in, 1 bit each
output	c_out, sum; //declare outputs c_out and sum, 1 bit each
//declare wires for values being passed between different gates
wire		not_a, not_b, not_c;
wire 		a_notb, nota_b, nota_notb, a_b; 
wire		and1_out, and2_out, and3_out, and4_out;
wire 		or1_out, or2_out;
wire 		b_c, a_c;
wire 		or3_out, or4_out;


not	   not1		(not_a, a);
not	   not2		(not_b, b);
not	    not3	(not_c, c_in);

// get sum
AND_D		and1		(a_notb, a, not_b);
AND_D		and2		(and1_out, a_notb, not_c);
AND_D		and3		(nota_b, not_a, b);
AND_D		and4		(and2_out, nota_b, not_c);
AND_D		and5		(nota_notb, not_a, not_b);
AND_D		and6		(and3_out, nota_notb, c_in);
AND_D		and7		(a_b, a, b);
AND_D		and8		(and4_out, a_b, c_in);

OR_D		or1		(or1_out, and1_out, and2_out);
OR_D		or2		(or2_out, or1_out, and3_out);
OR_D		or3		(sum, or2_out, and4_out);

// get c_out							
AND_D		and9		(b_c, b, c_in);
AND_D		and10		(a_c, a ,c_in);

OR_D		or4		(or3_out, a_b, b_c);
OR_D		or5		(or4_out, or3_out, a_c);
OR_D		or6		(c_out, or4_out, and4_out);

endmodule
