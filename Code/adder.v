module Adder(a, b, out);
    parameter LEN = 9;

    input[LEN - 1:0] a, b;
    output[LEN - 1:0] out;
    
    assign out = a + b;
    
endmodule