module Reg(clk, rst, ld, in, out);
    parameter LEN = 8;
    input clk;
    input rst;
    input ld;
    input[6:0] in;
    output reg[6:0] out;
    always @(posedge clk or posedge rst) begin
        if(rst)
            out = 0;
        else if(ld)
            out = in;
        else
            out = out;
    end
endmodule