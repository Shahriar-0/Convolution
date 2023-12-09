module MAC(clk, rst, a, b, ld, out_data);
    input clk, rst;
    input[7:0] a, b;
    input ld;
    output[11:0] out_data;
    wire[7:0] mult_out;
    wire[11:0] add_out, reg_out;

    Multiplier multiplier(a, b, mult_out);
    Adder #(12) Adder(reg_out, {4'b0, mult_out}, add_out);
    Reg #(12) my_reg(clk, rst, ld, add_out, reg_out);

    assign out_data = reg_out;
endmodule