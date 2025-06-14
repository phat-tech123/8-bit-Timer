module Counter_tb;

reg CounterClock;
reg [1:0] CounterEdge;
reg CounterClear;
wire Overflow;
wire [7:0] TCNT;

Counter #(.BIT_WIDTH(8)) Counter_u(
	.CounterClock(CounterClock),
	.CounterEdge(CounterEdge),
	.CounterClear(CounterClear),
	.Overflow(Overflow),
	.TCNT(TCNT)
);

initial begin
	$dumpfile("Output/Counter.vcd");
	$dumpvars(0, Counter_tb);
end

initial begin
	CounterClock = 0;
	CounterEdge = 2'b11;
	CounterClear = 0;
	//#1300 CounterClear = 1;
	#2000 $finish;
end

always #5 CounterClock = ~CounterClock;


endmodule
