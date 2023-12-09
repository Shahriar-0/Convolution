module PC(clk, rst, en, in, sel, out);
    input clk, rst, en;
    input[6:0] in;
    input sel;
    output[6:0] out;

    wire[6:0] Adder_out, mux_out, reg_out;
    Adder #(7) Adder(reg_out, 7'b0000001, Adder_out);
    mux_2_1 #(7) mux2_1(Adder_out, in, sel, mux_out);
    Reg #(7) my_reg(clk, rst, en, mux_out, reg_out);

    assign out = reg_out;
endmodule
