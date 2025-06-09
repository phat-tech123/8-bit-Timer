module ControlLogic#(
	parameter BIT_WIDTH = 8,
	parameter CLK_SELECT_BIT_WIDTH = 3
)(
	input wire TMRI0,
	input wire TMRI1,

	inout wire [BIT_WIDTH-1:0] TCSR_0,
	inout wire [BIT_WIDTH-1:0] TCSR_1,
	input wire [BIT_WIDTH-1:0] TCR_0,
	input wire [BIT_WIDTH-1:0] TCR_1,
	input wire [BIT_WIDTH-1:0] TCCR_0,
	input wire [BIT_WIDTH-1:0] TCCR_1,

	input wire CompareMatchA0,
	input wire CompareMatchA1,
	input wire CompareMatchB0,
	input wire CompareMatchB1,
	input wire Overflow0,
	input wire Overflow1,
	output wire CounterClear0,
	output wire CounterClear1,

	output CMIA0,
	output CMIA1,
	output CMIB0,
	output CMIB1,
	output OVI0,
	output OVI1,

	output TMO0,
	output TMO1,
	output ADC_REQUEST,

	output wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select
);

endmodule
