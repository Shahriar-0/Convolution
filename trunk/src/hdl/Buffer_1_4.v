module Buffer_1_4(clk, rst, ld, col, in, out);
    input clk, rst, ld;
    input [1:0] col;
    input [7:0] in;
    output [31:0] out;

    reg [7:0] buffer[0:3];

    integer i;

    always @(posedge clk or posedge rst) begin
        
        if (rst) 
            for (i = 0; i < 4; i = i + 1)
                buffer[i] <= 8'b0;

        else if (ld)
            buffer[col] <= in;
    end

    assign out = {buffer[0], buffer[1], buffer[2], buffer[3]};
endmodule