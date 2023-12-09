module Datapath (
    input [6:0] x, y, z,
    input clk, rst, x_sel, y_sel, z_sel, x_en, y_en, z_en, filt_ld, tab_count_ld,
    input table_ld, filt_count_en, filt_row_sel, input_count_en, input_en,
    input count_13_en, mac_ld, calc_count_en, wr_count_en, write_buf_ld, mac_rst, 
    input wr_data_sel, shiftEn,  in_count_en,  in_count_ld,
    input [1:0] input_i_sel,
    input [1:0] mem_in_sel,
    input [31:0] mem_out,
    output [6:0] mem_index,
    output [31:0] mem_in,
    output filt_cout, input_j_cout, calc_done, write_mem_cout, it_ends, table_cout
);
    wire [6:0] x_pc_out, y_pc_out, z_pc_out;
    wire [7:0] out_filter, out_table, mac_out;
    wire [11:0] full_mac_out;
    wire [1:0] filt_count_out, out_input_j, table_row, table_col, filt_row, wr_buff_col;
    wire [31:0] mem_in0, mem_in1;
    wire [127:0] input_out;
    wire [3:0] tableIdx, in_count_out;
    wire in_cout;

    PC x_pc(clk, rst, x_en, x, x_sel, x_pc_out);
    PC y_pc(clk, rst, y_en, y, y_sel, y_pc_out);
    PC z_pc(clk, rst, z_en, z, z_sel, z_pc_out);
    mux_7bit_3_1 mem_in_mux(x_pc_out, y_pc_out, z_pc_out, mem_in_sel, mem_index);
    Counter_4bit filt_counter(clk, rst, filt_count_en, filt_count_out, filt_cout);
    mux_2bit_2_1 filt_row_mux(filt_count_out, table_row, filt_row_sel, filt_row);
    FilterBuffer filt_buff(clk, rst, filt_ld, filt_row, table_col, mem_out, out_filter);
    Counter_4bit input_count_j(clk, rst, input_count_en, out_input_j, input_j_cout);
    Buffer_4_16 input_buffer(clk, rst, shiftEn, input_en, input_i_sel, out_input_j, tableIdx, mem_out, input_out);
    Counter_4bit input_counter(clk, rst, in_count_en, in_count_ld, 4'b0011, in_count_out, in_cout); 
    Counter_4bit table_counter(clk, rst, count_13_en, tab_count_ld, 4'b0011, tableIdx, table_cout);
    TableBuffer input_table(clk, rst, table_ld, table_row, table_col, input_out, out_table);
    Counter_4bit table_j_counter(clk, rst, calc_count_en, table_col, table_j_cout);
    Counter_4bit table_i_counter(clk, rst, table_j_cout, table_row, table_i_cout);
    MAC my_mac(clk, mac_rst, out_filter, out_table, mac_ld, full_mac_out);
    mux_2_1 #(32) wr_data_mux(mem_in0, mem_in1, wr_data_sel, mem_in);
    Counter_4bit write_mem_counter(clk, rst, wr_count_en, wr_buff_col, write_mem_cout);
    Buffer_1_4 write_buffer(clk, rst, write_buf_ld, wr_buff_col, mac_out, mem_in0);


    assign calc_done = (table_i_cout & table_j_cout);
    assign mac_out = full_mac_out[11:4];
    assign mem_in1 = {mem_in0[31:24], 24'b0};
    assign it_ends = table_cout & in_cout;
endmodule