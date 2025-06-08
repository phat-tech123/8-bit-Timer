module ClockSelect#(
	parameter BIT_WIDTH = 8,
	parameter P = 8000000
)(
	//External clocks
	input wire [BIT_WIDTH-1:0] TMCI0,
	input wire [BIT_WIDTH-1:0] TMCI1,

	//Internal clocks
	input wire [BIT_WIDTH-1:0] P_2,
	input wire [BIT_WIDTH-1:0] P_8,
	input wire [BIT_WIDTH-1:0] P_32,
	input wire [BIT_WIDTH-1:0] P_64,
	input wire [BIT_WIDTH-1:0] P_1024,
	input wire [BIT_WIDTH-1:0] P_8192,

	output [BIT_WIDTH-1:0] CounterClock1,
	output [BIT_WIDTH-1:0] CounterClock2
);


endmodule
