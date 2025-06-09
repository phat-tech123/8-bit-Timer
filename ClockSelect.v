module ClockSelect(
	//Internal clocks
	input wire clk,

	//External clocks
	input wire TMCI0,
	input wire TMCI1,

	//output
	output CounterClock1,
	output CounterClock2
);


endmodule



module ClockDivider#(
	parameter DIVISOR = 1
)(
	input clk_in,
	output reg clk_out
);

endmodule
