module mux_2bit_4_1(a, b, c, d, sel, y);
    input[1:0] a, b, c, d, sel;
    output[1:0] y;
	assign y = (sel==2'b00) ? a :
        	   (sel==2'b01) ? b :
 		       (sel==2'b10) ? c : d;
endmodule
