module Counter4bit(clk, rst, en, out, cout);
    input clk, rst, en;
    output reg[1:0] out;
    output cout;

    always@ (posedge clk or posedge rst) begin
        if(rst)
            out = 0;
        else if(en)
            out = out + 1;
        else
            out = out;
    end

    assign cout = &out;

endmodule