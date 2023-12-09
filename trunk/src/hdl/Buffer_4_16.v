module Buffer_4_16(clk, rst, shiftEn, ld, row, col, tableIdx, in, out);
    input clk, rst, shiftEn, ld;
    input[1:0] row, col;
    input[3:0] tableIdx;
    input[31:0] in;
    output [127:0] out;

    reg[7:0] buffer[0:3][0:15];
    integer i, j;
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            for(i = 0; i < 4; i = i + 1) begin
                for(j = 0; j < 16; j = j + 1) begin
                    buffer[i][j] = 8'b0;
                end
            end
        end

        else if(ld) begin
            buffer[row][{col[1:0], 2'b00}]     = in[31:24];
            buffer[row][{col[1:0], 2'b00} + 1] = in[23:16];
            buffer[row][{col[1:0], 2'b00} + 2] = in[15:8];
            buffer[row][{col[1:0], 2'b00} + 3] = in[7:0];
        end
        
        else if(shiftEn) begin
            for(j = 0; j < 16; j = j + 1) begin
                for(i = 0; i < 3; i = i + 1) 
                    buffer[i][j] = buffer[i + 1][j];
            end
        end
    end

    assign out = {buffer[0][tableIdx - 3], buffer[0][tableIdx - 2],
                  buffer[0][tableIdx - 1], buffer[0][tableIdx],
                  buffer[1][tableIdx - 3], buffer[1][tableIdx - 2],
                  buffer[1][tableIdx - 1], buffer[1][tableIdx],
                  buffer[2][tableIdx - 3], buffer[2][tableIdx - 2],
                  buffer[2][tableIdx - 1], buffer[2][tableIdx],
                  buffer[3][tableIdx - 3], buffer[3][tableIdx - 2],
                  buffer[3][tableIdx - 1], buffer[3][tableIdx]};
endmodule