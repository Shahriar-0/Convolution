module Circuit(clk, rst, x, y, z, mem_out, mem_index, mem_in, mem_wr, done);
    input clk, rst;
    input[6:0] x, y, z;
    input[31:0] mem_out;
    output[6:0] mem_index;
    output[31:0] mem_in;
    output mem_wr;
    output done;

    wire x_sel, y_sel, z_sel, filt_ld, filt_count_en, filt_cout, input_count_en,
        count_13_en, mac_ld, filt_row_sel, z_en, tab_count_ld, table_ld, calc_done,
        write_mem_cout, table_cout, mac_rst, wr_data_sel,
        input_en, input_j_cout, x_en, y_en, calc_count_en, wr_count_en, write_buf_ld, shiftEn,
        in_count_en, in_count_ld, it_ends;


    wire[1:0] mem_in_sel, input_i_sel;
    
    Datapath my_datapath(
        x, y, z ,clk, rst, x_sel, y_sel, z_sel, x_en, y_en, z_en, filt_ld,
        tab_count_ld, table_ld, filt_count_en, filt_row_sel, input_count_en, input_en,
        count_13_en, mac_ld, calc_count_en, wr_count_en, write_buf_ld, mac_rst, wr_data_sel, 
        shiftEn, in_count_en, in_count_ld, input_i_sel, mem_in_sel, mem_out, mem_index,
        mem_in, filt_cout, input_j_cout, calc_done, write_mem_cout, it_ends, table_cout
    );

    Controller my_controller(
        clk, rst, filt_cout,  input_j_cout, calc_done, write_mem_cout, table_cout,
        it_ends, x_sel, y_sel, z_sel, filt_ld, filt_count_en, filt_row_sel, tab_count_ld, 
        table_ld, input_count_en, input_en, mac_ld, count_13_en, calc_count_en,
        wr_count_en, write_buf_ld, input_i_sel, x_en, y_en, z_en, mem_in_sel, mem_wr, 
        mac_rst, wr_data_sel, shiftEn, in_count_en, in_count_ld, done
    );
endmodule