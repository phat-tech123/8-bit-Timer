module ControlLogic#(
	parameter BIT_WIDTH = 8
)(
	input wire TMRI0,
	input wire TMRI1,

	input wire [BIT_WIDTH-1:0] TCR_0,
	input wire [BIT_WIDTH-1:0] TCR_1,
	input wire [BIT_WIDTH-1:0] TCCR_0,
	input wire [BIT_WIDTH-1:0] TCCR_1,

	output CMIA0,
	output CMIA1,
	output CMIB0,
	output CMIB1,
	output OVI0,
	output OVI1,

	output TMO0,
	output TMO1,
	output ADC_REQUEST
);

endmodule
