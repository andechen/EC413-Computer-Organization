//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2021 03:22:17 PM
// Design Name: 
// Module Name: fowarding_1ahead
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


module fowarding_ahead(
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,
    input [4:0] IDEX_Rs,
    input [4:0] IDEX_Rt,
    input [4:0] EXMEM_Rd,
    input [4:0] MEMWB_Rd,
    input EXMEM_RegWrite
    );    
    
    
    always @ (IDEX_Rs or IDEX_Rt or EXMEM_Rd  or MEMWB_Rd) begin
        assign ForwardA = 2'b00;
        assign ForwardB = 2'b00;
        
        if ((EXMEM_RegWrite && EXMEM_Rd != 0) && (EXMEM_Rd == IDEX_Rs)) begin
            assign ForwardA = 2'b10;
        end
        
        if ((EXMEM_RegWrite && EXMEM_Rd != 0) && EXMEM_Rd == IDEX_Rt) begin
            assign ForwardB = 2'b10;
        end
        
        if ((EXMEM_RegWrite && MEMWB_Rd != 0) && (EXMEM_Rd != IDEX_Rs) && (MEMWB_Rd == IDEX_Rs)) begin
            assign ForwardA = 2'b01;
        end 
        
        if ((EXMEM_RegWrite && MEMWB_Rd != 0) && (EXMEM_Rd != IDEX_Rt) && (MEMWB_Rd == IDEX_Rt)) begin
            assign ForwardB = 2'b01;
        end
    end

endmodule