`timescale 1ns / 1ns


module shift_left_2(in,out
    );
parameter size = 32;

input [size-1:0] in;
output [size-1:0] out;

assign out = {in[size-3:0],2'b00};

endmodule
