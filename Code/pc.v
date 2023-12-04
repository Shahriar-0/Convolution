module PC(clk, rst, en, in, sel, out);
    #parameter LEN = 9;
    input clk, rst, en, sel;
    input[LEN - 1:0] in;
    output[LEN - 1:0] out;

    wire[LEN - 1:0] dOut, muxOut, regOut;
    
    Adder adder(regOut, 9'b000000100, dOut);
    Mux2_9bit mux2_1(dOut, in, sel, muxOut);
    reg_9bit my_reg(clk, rst, en, muxOut, regOut);

    assign out = regOut;
endmodule
