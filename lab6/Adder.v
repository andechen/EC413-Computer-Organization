`timescale 1ns / 1ns


module Adder(
    a,
    b,
    sum
    );

parameter size = 32;

input [size-1:0] a;
input [size-1:0] b;
output [size-1:0] sum;

assign sum = a+b;

endmodule
