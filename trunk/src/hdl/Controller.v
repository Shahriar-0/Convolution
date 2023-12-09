module Controller(
    input clk, rst, filt_cout, input_j_cout, calc_done, write_mem_cout, table_cout, it_ends,
    output reg x_sel, y_sel, z_sel, filt_ld, filt_count_en, filt_row_sel, tab_count_ld, table_ld,
    output reg input_count_en, input_en, mac_ld, count_13_en, calc_count_en, wr_count_en,
    output reg write_buf_ld,
    output reg[1:0] input_i_sel,
    output reg x_en, y_en, z_en,
    output reg[1:0] mem_in_sel,
    output reg mem_wr, mac_rst, wr_data_sel, shiftEn, in_count_en, in_count_ld, done
);
    parameter [4:0]
        STATE0 = 5'b00000,
        STATE1 = 5'b00001,
        STATE2 = 5'b00010,
        STATE3 = 5'b00011,
        STATE4 = 5'b00100,
        STATE5 = 5'b00101,
        STATE6 = 5'b00110,
        STATE7 = 5'b00111,
	    STATE8 = 5'b01000,
        STATE9 = 5'b01001,
        STATE10 = 5'b01010,
        STATE11 = 5'b01011,
        STATE12 = 5'b01100,
        STATE13 = 5'b01101,
        STATE14 = 5'b01110,
        STATE15 = 5'b01111,
        STATE16 = 5'b10000,
        STATE17 = 5'b10001;

    reg [4:0] ps = STATE0;
    reg [4:0] ns;

    always @(ps or filt_cout or input_j_cout or
        calc_done or write_mem_cout or
        table_cout or it_ends)
    begin
        ns = STATE0;
        case (ps)
            STATE0 : ns = STATE1;
            STATE1 : ns = filt_cout? STATE2 : STATE1;
            STATE2 : ns = input_j_cout? STATE3 : STATE2;
	        STATE3 : ns = input_j_cout? STATE4 : STATE3;
            STATE4 : ns = input_j_cout? STATE5 : STATE4;
            STATE5 : ns = input_j_cout? STATE6 : STATE5;
            STATE6 : ns = STATE7;
            STATE7 : ns = STATE8;
	        STATE8 : ns = calc_done ? STATE9 : STATE8;
            STATE9 : ns = write_mem_cout ? STATE12 : it_ends ? STATE16 : STATE10;
            STATE10: ns = table_cout ? STATE15 : STATE11;
            STATE11: ns = STATE7;
            STATE12: ns = it_ends ? STATE16 : STATE13;
            STATE13: ns = it_ends ? STATE17 : STATE14;
            STATE14: ns = table_cout ? STATE15 : STATE11;
            STATE15: ns = STATE5;
            STATE16: ns = STATE13;
            STATE17: ns = STATE17;
        endcase
    end

    always @(ps) 
    begin
        {x_sel, y_sel, z_sel, x_en, y_en, z_en,
        mem_in_sel, filt_ld, filt_count_en, input_en,
        input_count_en, tab_count_ld, table_ld, calc_count_en,
        input_i_sel, mac_ld, count_13_en,
        wr_count_en, write_buf_ld, mac_rst, in_count_en,
        in_count_ld, mem_wr, shiftEn} = 26'b0;
        case (ps)
            STATE0: {x_sel, y_sel, z_sel, x_en, y_en, z_en, filt_row_sel, in_count_ld} = 8'b11111101;
            STATE1: {mem_in_sel, filt_ld, filt_count_en, y_sel, y_en} = 6'b011101;
            STATE2: {mem_in_sel, input_en, input_i_sel, input_count_en, x_sel, x_en} = 8'b00100101;
            STATE3: {mem_in_sel, input_en, input_i_sel, input_count_en, x_sel, x_en} = 8'b00101101;
            STATE4: {mem_in_sel, input_en, input_i_sel, input_count_en, x_sel, x_en} = 8'b00110101;
            STATE5: {mem_in_sel, input_en, input_i_sel, input_count_en, x_sel, x_en} = 8'b00111101;
            STATE6: {tab_count_ld, wr_data_sel} = 2'b10;
            STATE7: {table_ld, filt_row_sel, z_sel, mac_rst} = 4'b1101;
	        STATE8: {mac_ld, calc_count_en} = 2'b11;
            STATE9: write_buf_ld = 1'b1;
            STATE10: wr_count_en = 1'b1;
            STATE11: count_13_en = 1'b1;
            STATE12: wr_count_en = 1'b1;
            STATE13: {mem_in_sel, mem_wr} = 3'b101;
            STATE14: z_en = 1'b1;
            STATE15: {in_count_en, input_i_sel,table_ld, shiftEn} = 5'b11111;
            STATE16: wr_data_sel = 1'b1;
            STATE17: done = 1'b1;
        endcase
    end

    always @(posedge clk, posedge rst)
    begin
        if(rst)
            ps <= STATE0;
        else
            ps <= ns;
    end
    
endmodule