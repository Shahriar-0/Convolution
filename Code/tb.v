module tb();
	reg clk = 1, rst = 1;
    reg[8:0] x = 9'b000000001, y = 9'b000000001, z;
    wire mem_wr;
    wire[31:0] mem_out, mem_in;
    wire[8:0] mem_index;

    topModule my_circuit(clk, rst, x, x, z,
        mem_out, mem_index, mem_in, mem_wr);

    Memory my_Memory(clk, mem_index,
        mem_wr, mem_in, mem_out);

    always
        #5 clk = ~clk;
        initial begin
            #1 rst = 0;
            #1000 $stop;
        end
endmodule
