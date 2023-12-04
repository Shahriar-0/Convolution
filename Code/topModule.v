module topModule(clk, rst, x, y, z, out, in, index, wrEn);
    parameter LEN = 9;
    input clk, rst;
    input[LEN - 1:0] x, y, z;
    output[31:0] out;
    output[LEN - 1:0] index;
    output wrEn;
    input[31:0] in;

    wire xSel, ySel, zSel, filt_ld, 
         filtCouttEn, filt_cout, inputCouttEn,
         inputEn, input_i_cout, done, xEn, yEn,
         zEn, tabCoutt_ld, table_ld;

    wire[1:0] mem_inSel;
    
    datapath dp(x, y, z ,clk, rst, xSel,
        ySel, zSel, xEn, yEn, zEn, filt_ld,
        tabCoutt_ld, table_ld, filtCouttEn,
        inputCouttEn, inputEn, mem_inSel,
        mem_out, mem_index, mem_in, filt_cout,
        input_i_cout, mem_wr, done);

    Controller cu(clk, rst, filt_cout, 
        input_i_cout, xSel, ySel, zSel, filt_ld,
        filtCouttEn, tabCoutt_ld, table_ld,
        inputCouttEn, inputEn, xEn, yEn,
        zEn, mem_inSel);
endmodule