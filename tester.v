module ic_tester(y, gateIndicator, routeA, routeB, ledA, ledB, clkLed, a, b, select, gateOut, clkIn);
    input[3:0] select; // selector for which gate to test
    input a;
    input b;
    input clkIn; // cpld clock
    input[3:0] gateOut; // gate output that goes to the cpld for 'gateIndicator'

    output reg[3:0] routeA;
    output reg[3:0] routeB;
    output reg y; // gate output
    
    output[3:0] gateIndicator; // led indicator for gate output
    output ledA; // led indicators for inputs A & B
    output ledB;
    output clkLed; // led indicator for clock pulse

    reg[3:0] currGate = 4'b0; // currently selected gate; initially set all 4 to zero

    // CLOCK DIVIDER
    clk_div #(.ticksAtHalfSec(3_125_000)) divider(
        .clkOut(clk),
        .clkLed(clkLed),
        .clkIn(clkIn)
    ); 
    // CLOCK DIVIDER

    always @(posedge clk) begin // if select changes

        // TOGGLING
        if(select[0] == 1) begin // if selected gate is 1
            currGate[0] <= ~currGate[0];

            currGate[1] <= 1'b0; // turn off all other gates
            currGate[2] <= 1'b0;
            currGate[3] <= 1'b0;
        end

        if(select[1] == 1) begin // if selected gate is 2
            currGate[1] <= ~currGate[1];

            currGate[0] <= 1'b0; // turn off all other gates
            currGate[2] <= 1'b0;
            currGate[3] <= 1'b0;
        end

        if(select[2] == 1) begin // if selected gate is 3
            currGate[2] <= ~currGate[2];

            currGate[0] <= 1'b0; // turn off all other gates
            currGate[1] <= 1'b0;
            currGate[3] <= 1'b0;
        end

        if(select[3] == 1) begin // if selected gate is 4
            currGate[3] <= ~currGate[3];

            currGate[0] <= 1'b0; // turn off all other gates
            currGate[1] <= 1'b0;
            currGate[2] <= 1'b0;
        end
        // TOGGLING

        // INPUTS AND OUTPUTS
        if(currGate[0] == 1) begin
            routeA[0] <= a; // make a and b pass through these wires
            routeB[0] <= b;

            y <= gateOut[0]; // y will be whatever the output of gateOut[0] is
        end

        if(currGate[1] == 1) begin
            routeA[1] <= a; // make a and b pass through these wires
            routeB[1] <= b;

            y <= gateOut[1]; // y will be whatever the output of gateOut[1] is
        end

        if(currGate[2] == 1) begin
            routeA[2] <= a; // make a and b pass through these wires
            routeB[2] <= b;

            y <= gateOut[2]; // y will be whatever the output of gateOut[2] is
        end

        if(currGate[3] == 1) begin
            routeA[3] <= a; // make a and b pass through these wires
            routeB[3] <= b;

            y <= gateOut[3]; // y will be whatever the output of gateOut[3] is
        end
        // INPUTS AND OUTPUTS

    end // always block end

    assign gateIndicator = currGate;
    assign ledA = a;
    assign ledB = b;

endmodule