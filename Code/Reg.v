module Reg9bit(clk, rst, ld, in, out);
    #parameter LEN = 9;
    input clk, rst, ld;
    input[LEN - 1:0] in;
    output reg[LEN - 1:0] out;
    always@ (posedge clk or posedge rst) begin
        if(rst)
            out = 0;
        else if(ld)
            out = in;
        else
            out = out;
    end
endmodule