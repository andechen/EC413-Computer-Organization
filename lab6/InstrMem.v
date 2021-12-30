`timescale 1ns / 1ns

module InstrMem(
    data_out,
    data_in,
    address,
    write,
	clk
    );
	 
   parameter data_size = 32;
   parameter address_size = 5;
	
	
	parameter memory_depth = 2**address_size; // do not specify this when using module
	
	output [data_size-1:0] data_out;
	input [data_size-1:0] data_in;
	input [31:0] address;
	input write;
	input clk; 
	
	
	reg [data_size-1:0] mem [0:memory_depth-1];
	reg [data_size-1:0] data;

	assign data_out = mem [address[1+address_size:2]];

	always @(posedge clk) begin

		case (write)
			1:  mem [address[1+address_size:2]] <= data_in;
		endcase

	end 
	 


endmodule
