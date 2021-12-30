module nbit_register_file(
					      write_data, 
                          read_data_1, 
						  read_data_2, 
                          read_sel_1, 
						  read_sel_2, 
                          write_address, 
						  RegWrite, 
						  clk
						  );
                          
    parameter data_width = 32;
	 
	 
    parameter select_width = 5; 						  // do not specify this when using module
	parameter select_width_2 = 2**select_width;   // do not specify this when using module
                          
    input                                       clk, RegWrite;
    input           [data_width-1:0]            write_data;
    input           [select_width-1:0]          read_sel_1, read_sel_2, write_address;
    output		     [data_width-1:0]            read_data_1, read_data_2;
    
    reg             [data_width-1:0]            register_file [0:select_width_2-1];

	assign		read_data_1 = register_file[read_sel_1];
	assign		read_data_2 = register_file[read_sel_2];

    
    always @ (posedge clk) begin
        if (RegWrite) 
            register_file[write_address] <= write_data;
    end
	 
	 // for loop initializes all registers, no need to rst
    integer i;
    initial begin
        for (i = 0; i < select_width_2; i = i + 1) begin 
            register_file[i] = 10*i;
        end     
    end

endmodule