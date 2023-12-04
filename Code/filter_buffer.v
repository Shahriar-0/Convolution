module FilterBuff(clk, rst, ld, row, col, in, out);
    input clk, rst, ld;
    input[1:0] row, col;
    input[31:0] in,
    output[7:0] out;

    reg[7:0] buffer[0:3][0:3];
    integer i, j;
    always@ (posedge clk or posedge rst) begin
        if(rst) begin
            for(i = 0; i < 4; i = i + 1) begin
                for(j = 0; j < 4; j = j + 1) begin
                    buffer[i][j] = 8'b0;
                end
            end
        end
        else if(ld) begin
            buffer[row][0] = in[31:24];
            buffer[row][1] = in[23:16];
            buffer[row][2] = in[15:8];
            buffer[row][3] = in[7:0];
        end
    end

    assign out = buffer[row][col];
    
endmodule