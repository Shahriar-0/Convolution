module Memory(clk, index, wrEn, data, out);
    #parameter LEN = 9;
    input clk, wrEn;
    input[LEN - 1:0] index;
    input[31:0] data;
    output[31:0] out;

    reg [31:0] mem [127:0];

    initial $readmemh("mem.dat", mem);
    
    assign out = mem[{2'b00, index[LEN - 1:2]}];

    always@ (posedge clk)
        if(write)
            mem[{2'b00, index[LEN - 1:2]}] = data;

endmodule