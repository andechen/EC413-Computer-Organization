`timescale 1ns / 1ns

module mux( 
	 sel, 
	 in_0, 
	 in_1,
    out 
    );
	 
parameter size = 32;

input sel;
input [size-1:0] in_0;
input [size-1:0] in_1;

output [size-1:0] out;

assign out = (sel) ? in_1 : in_0;

endmodule
