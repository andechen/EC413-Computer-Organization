/******************************************************************************
Module: ALU_behavioral.v
Functionality:
- A parameterized ALU.
- ALU functions
  ALUOp   Output
  3'b000  MOV
  3'b001  NOT
  3'b010  ADD
  3'b011  SUB
  3'b100  OR
  3'b101  AND
  3'b110  SLT (signed)
******************************************************************************/


module ALU_behavioral #(
  parameter WIDTH = 32
)(
  input signed [WIDTH-1:0] R2,
  input signed [WIDTH-1:0] R3,
  input [2:0] ALUOp,

  output reg [WIDTH-1:0] R1
);

always @(*)begin
  case(ALUOp)
    3'b000: R1 = R2;
    3'b001: R1 = ~R2;
    3'b010: R1 = R2 + R3;
    3'b011: R1 = R2 - R3;
    3'b100: R1 = R2 | R3;
    3'b101: R1 = R2 & R3;
    3'b110: R1 = R2 < R3;
  endcase
end

endmodule
