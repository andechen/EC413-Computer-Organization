`timescale 1ns / 1ns

module sign_extend( 
							in, 
							out
						);
						
parameter size = 32;
parameter imm_size = 16;

input [imm_size-1:0] in;
output  [size-1:0] out;

assign out [imm_size-1:0] = in;

genvar i;

generate
for (i=imm_size ; i < size ; i=i+1) begin : seblock
assign out[i] = in[imm_size-1];
end
endgenerate


endmodule
