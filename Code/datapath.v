module datapath
(
    input[8:0] x, y, z,
    input clk, rst,
    input x_sel, y_sel, z_sel,
    input x_en, y_en, z_en,
    input filt_ld,
    input tab_count_ld,
    input table_ld,
    input filt_count_en,
    input input_count_en, 
    input input_en,
    input[1:0] mem_in_sel,
    input[31:0] mem_out,
    output[8:0] mem_index,
    output[31:0] mem_in,
    output filt_cout,
    output input_i_cout,
    output mem_wr,
    output done
);
    wire[8:0] x_pc_out, y_pc_out, z_pc_out;
    wire[7:0] out_filter, out_table;
    wire[1:0] filt_count_out, out_input_j,
        out_input_i, table_row, table_col;
    wire[127:0] input_out;
    wire input_j_cout;
    wire[3:0] table_index;

// addres of Memory to write or read:
    PC x_pc(clk, rst, x_en, x, x_sel, x_pc_out);
    PC y_pc(clk, rst, y_en, y, y_sel, y_pc_out);
    PC z_pc(clk, rst, z_en, z, z_sel, z_pc_out);
    Mux3_9bit mem_in_mux(x_pc_out, y_pc_out,
        z_pc_out, mem_in_sel, mem_index);

// reading FilterBuff from Memory:
    Counter4bit filt_counter(clk, rst, filt_count_en,
        filt_count_out, filt_cout);
    FilterBuff filt_buff(clk, rst, filt_ld,
        filt_count_out, 2'b00, mem_out, out_filter);
// reading 4*16 input from Memory:
    Counter4bit input_count_j(clk, rst, input_count_en,
        out_input_j, input_j_cout);
    Counter4bit input_count_i(clk, rst, input_j_cout,
        out_input_i, input_i_cout);
    buffer_4_16 input_buffer(clk, rst, input_en, out_input_i,
        out_input_j, table_index, mem_out, input_out);
    
// output of counter is showing the number
// of 4*4 buffer that we are reading from 8*8 buffer
// and it changes from 3 to 15 (we need 13 4*4 buffer)
// so we should load 3 to the counter at the first:
    Counter4bit table_counter(clk, rst, 1'b0, tab_count_ld,
        4'b0011, table_index, table_cout);

    TableBuffer input_table(clk, rst, table_ld, table_row,
        table_col, input_out, out_table);
endmodule