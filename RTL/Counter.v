module Counter#(
	parameter BIT_WIDTH = 8
)(
	input wire CounterClock,
	input wire [1:0] CounterEdge,
	input wire CounterClear,
	output wire Overflow,
	output reg [BIT_WIDTH-1:0] TCNT
);

localparam PROHIBITED 	= 2'b00;
localparam RISING_EDGE 	= 2'b01;
localparam FALLING_EDGE = 2'b10;
localparam BOTH_EDGES 	= 2'b11;

initial begin
	TCNT = 8'b0;
end

assign Overflow = (TCNT == 8'hff);

always@(posedge CounterClock or negedge CounterClock or posedge CounterClear) begin
	if(CounterClear) 
		TCNT <= 8'b0;
	else if(TCNT == 8'hff) 
		TCNT <= TCNT;
	else if(CounterEdge == PROHIBITED)
		TCNT <= TCNT;
	else if(CounterClock && CounterEdge == RISING_EDGE)
		TCNT <= TCNT + 1;
	else if(!CounterClock && CounterEdge == FALLING_EDGE)
		TCNT <= TCNT + 1;
	else if(CounterEdge == BOTH_EDGES)
		TCNT <= TCNT + 1;
	else 
		TCNT <= TCNT;
end


endmodule
