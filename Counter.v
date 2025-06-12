module Counter#(
	parameter BIT_WIDTH = 8
)(
	input wire CounterClock,
	input wire [1:0]CounterEdge,
	input wire counterClear,
	output wire Overflow
);
reg [BIT_WIDTH-1:0] cnt;
initial begin
	cnt <= 8'h00;
end

assign Overflow = (cnt == 8'hff);

always@(posedge CounterClock or negedge CounterClock or posedge counterClear) begin 
	if(counterClear == 1) 					//Counter Clear
		cnt <= 8'h00;
	else if(CounterEdge == 2'b00 && posedge CounterClock) 	//Counts at rising edge
		cnt <= cnt + 1;	
	else if(CounterEdge == 2'b01 && negedge CounterClock)  	//Counts at falling edge
		cnt <= cnt + 1;	
	else if(CounterEdge == 2'b10) 				//Counts at both rising and falling edges
		cnt <= cnt + 1;
	else if(CounterEdge == 2'b11) 				//Counts at TCNT_1 overflow signal or TCNT_0 compare match A
		cnt <= cnt + 1;
	else 
		cnt <= cnt;
end

endmodule
