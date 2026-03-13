module clk_div(clkOut, clkLed, clkIn);
    input clkIn;

    output reg clkOut = 1'b0;
    output reg clkLed = 1'b0;

    parameter integer ticksAtHalfSec = 25_000_000;
    reg[24:0] tickCnt = 25'b0;

    always @(posedge clkIn) begin
        if(tickCnt == (ticksAtHalfSec - 1) ) begin
            clkOut <= ~clkOut;
            clkLed <= ~clkOut;

            tickCnt <= 25'b0; // clear tick count
        end // if end

        else tickCnt <= tickCnt + 1;

    end // always end

endmodule