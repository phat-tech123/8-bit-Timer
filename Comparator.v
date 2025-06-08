module Comparator#(
	parameter BIT_WIDTH = 8
)(
	input wire [BIT_WIDTH-1:0] TCOR,
	input wire [BIT_WIDTH-1:0] TCNT,
	output wire CompareMatch
);

assign CompareMatch = (TCOR == TCNT);

endmodule
