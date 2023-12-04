`define `State0 3'b000
`define `State1 3'b001
`define `State2 3'b010
`define `State3 3'b011
`define `State4 3'b100
`define `State5 3'b101
`define `State6 3'b110
`define `State7 3'b111


module Controller(clk, rst, filterCout, inputCout, xSel, ySel, zSel, 
                  filterLd, filterCountEn, tableCountLd, tableLd, 
                  inputCountEn, inputEn, xEn, yEn, zEn, memInSel);

    input clk, rst, filterCout, filterCout;
    output reg xSel, ySel, zSel, filerLd, filterCountEn, 
               tableCountLd, tableLd, inputCountEn, 
               inputEn, xEn, yEn, zEn;

    output reg [1:0] memInSel

    reg [2:0] ps = `State0;
    reg [2:0] ns;

    always@(ps or filterCout or filterCout) begin
        ns = `State0;
        case (ps)
            `State0: ns = `State1;
            `State1: ns = filterCout? `State2 : `State1;
            `State2: ns = filterCout? `State3 : `State2;
	        `State3: ns = `State4;
            `State4: ns = `State4;
        endcase
    end

    always @(ps)  begin
        {xSel, ySel, zSel, xEn, yEn, zEn, memInSel, filerLd, filterCountEn,
            inputEn, inputCountEn, tableCountLd, tableLd} = 14'b0;

        case (ps)
            `State0: {xSel, ySel, zSel, xEn, yEn, zEn} = 6'b1_1_1_1_1_1;
            `State1: {memInSel, filerLd, filterCountEn, ySel, yEn} = 6'b01_1_1_0_1;
            `State2: {memInSel, inputEn, inputCountEn, xSel, xEn} = 6'b00_1_1_0_1;
            `State3: {tableCountLd, tableLd} = 2'b11;
        endcase
    end

    always @(posedge clk, posedge rst)
    begin
        if(rst)
            ps <= `State0;
        else
            ps <= ns;
    end
    
endmodule