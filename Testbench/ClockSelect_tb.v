module ClockSelect_tb;
	reg clk, TMCI0, TMCI1;
	reg clock_select, edge_slect;
	reg [2:0] clock_select_0;
	reg [2:0] clock_select_1;
	reg edge_select_0;
	reg edge_select_1;

	wire CounterClock0;
	wire CounterEdge0;
	wire CounterClock1;
	wire CounterEdge1;

	ClockSelect #(.CLK_SELECT_BIT_WIDTH(3)) ClockSelect_u(
		.clk(clk),
		.TMCI0(TMCI0),
		.TMCI1(TMCI1),
	
		.clock_select_0(clock_select_0),
		.clock_select_1(clock_select_1),
		.edge_select_0(edge_select_0),
		.edge_select_1(edge_select_1),

		.CounterClock0(CounterClock0),
		.CounterEdge0(CounterEdge0),
		.CounterClock1(CounterClock1),
		.CounterEdge1(CounterEdge1)
	);

	always #5 clk = ~clk;
	always #10 TMCI0 = ~TMCI0;
	always #15 TMCI1 = ~TMCI1;

	initial begin
		clk 	= 0;
		TMCI0 	= 0;
		TMCI1 	= 0;
		clock_select_0 = 3'b000;
		edge_select_0 = 0;
		clock_select_1 = 3'b111;
		edge_select_1 = 1;


		#200 $finish;
	end

	initial begin
		$dumpfile("Output/ClockSelect.vcd");
		$dumpvars(0, ClockSelect_tb);
	end

endmodule
