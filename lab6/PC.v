`timescale 1ns / 1ns


module PC(
	 out,					  // mem address out
	 in,                  // mem address in
	 clk,
    reset
    );

parameter size = 32;

input clk;
input reset;
input [size-1:0] in;
output reg [size-1:0] out;

always @(posedge clk) begin

if (reset) 
out <= 0;
else
out <= in;

end

endmodule
