module Memory(clk, index, write, write_data, write_all, out);
    input clk;
    input[6:0] index;
    input write;
    input[31:0] write_data;
    input write_all;
    output[31:0] out;

    reg [31:0] mem [0:127];

    initial
		$readmemh("./file/mem.dat", mem);
	

    always @(posedge clk)
        if(write)
            mem[index] = write_data;

    always @(posedge write_all)
        $writememh("./file/result.dat", mem);
    
    assign out = mem[index];
endmodule