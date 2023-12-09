module Multiplier(a, b, out);
    input[7:0] a, b;
    output[7:0] out;
    wire[15:0] fullOut;
    assign fullOut = a * b;
    assign out = fullOut[15:8];
endmodule