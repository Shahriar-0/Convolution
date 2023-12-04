module Mux2_1bit(a, b, sel, out);
    input a, b, sel;
    output out;
    
    assign out = sel ? b : a;
endmodule