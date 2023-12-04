module Mux3_9bit(a, b, c, sel, out);
    parameter LEN = 9;

    input[LEN - 1:0] a, b, c;
    input[1:0] sel;
    output[LEN - 1:0] out;
    
    assign out = (sel == 2'b00) ? a : ((sel == 2'b01) ? b : c);
endmodule