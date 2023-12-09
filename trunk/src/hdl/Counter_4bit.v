module Counter_4bit(clk, rst, en, ld, in, out, cout);
    input clk, rst, en, ld;
    input [3:0] in;
    output reg [3:0] out;
    output cout;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 4'b0;
        else if (ld)
            out <= in;
        else if (en)
            out <= out + 1;
        else
            out <= out;
    end
    
    assign cout = &out;
endmodule