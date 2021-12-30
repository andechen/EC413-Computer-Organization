// This can be used to replace the original nbit_register_file in lab5.
// In iSim you can actually expand this reg_file to view the contents in it. 

module nbit_register_file(WriteData, 
                          ReadData1,
                          ReadData2, 
                          ReadSelect1,
                          ReadSelect2, 
                          WriteSelect,
                          WriteEnable,
                          Reset,
                          Clk);
    
    parameter select_width = 5; 
    parameter data_width = 32;

    input                             Reset, Clk, WriteEnable;          // 1-bit Write Enable, specify if WS register can be updated
    input       [data_width-1:0]      WriteData;
    input       [4:0]                 ReadSelect1,                      // 5-bit Read Select 1, specify first register to read
                                      ReadSelect2,                      // 5-bit Read Select 2, specify second register to read
                                      WriteSelect;                      // 5-bit Write Select, specify which register to write ALU output
                                      
    output      [data_width-1:0]      ReadData1,                        // N-bit Read Data 1, contents of Read Select 1 register
                                      ReadData2;                        // N-bit Read Data 2, contents of Read Select 2 register

    reg         [data_width-1:0]      register_file [0:data_width-1];   // 32-bit register that stores the contents of the 32 registers (0-31)

    // for loop initializes all registers to 10x the register number
    // no need to rst
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin 
            register_file[i] = i * 10;
        end     
    end

    // Return 32-bit data of Read Select registers from Register File
    assign ReadData1 = register_file[ReadSelect1];
    assign ReadData2 = register_file[ReadSelect2];

    // On posedge of clock, update the WriteSelect register with value of WriteData
    always @ (posedge Clk) begin
        if (WriteEnable) 
            register_file[WriteSelect] <= WriteData;
    end
endmodule