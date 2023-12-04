module buffer_4_16(clk, rst, ld, row, col, Index, in, out);

    input clk, rst, ld;
    input[1:0] row, col;
    input[3:0] Index;
    input[31:0] in;
    output reg[127:0] out;

    reg[7:0] buffer[0:3][0:15];
    integer i, j;

    always@ (posedge clk or posedge rst) begin
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
    end

    assign out = {
            buffer[0][Index - 3], buffer[0][Index - 2],
            buffer[0][Index - 1], buffer[0][Index],
            buffer[1][Index - 3], buffer[1][Index - 2],
            buffer[1][Index - 1], buffer[1][Index],
            buffer[2][Index - 3], buffer[2][Index - 2],
            buffer[2][Index - 1], buffer[2][Index],
            buffer[3][Index - 3], buffer[3][Index - 2],
            buffer[3][Index - 1], buffer[3][Index]
        };
endmodule