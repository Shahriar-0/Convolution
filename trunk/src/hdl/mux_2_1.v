module mux_2_1(a, b, sel, y);
    parameter LEN = 8;
    input[LEN - 1:0] a, b;
    input sel; 
    output[LEN - 1:0] y;
	
    assign y = sel ? b : a;
endmodule