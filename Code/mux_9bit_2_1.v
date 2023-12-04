module Mux2_9bit(a, b, sel, out);
    parameter LEN = 9;

    input[LEN - 1:0] a, b;
    input sel;
    output[LEN - 1:0] out;
    
    assign out = sel ? b : a;
endmodule