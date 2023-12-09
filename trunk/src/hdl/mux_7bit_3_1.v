module mux_7bit_3_1(a, b, c, sel, y);
    input[6:0] a, b, c;
    input[1:0] sel;
    output[6:0] y;
	assign y = (sel==2'b00) ? a :
               (sel==2'b01) ? b : c;
endmodule