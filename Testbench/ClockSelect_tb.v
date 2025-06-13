module ClockSelect_tb;
	reg clk, TMCI0, TMCI1;
	reg [4:0] clock_select_0;
	reg [4:0] clock_select_1;

	wire CounterClock0;
	wire [1:0] CounterEdge0;
	wire CounterClock1;
	wire [1:0] CounterEdge1;

	ClockSelect #(.CLK_SELECT_BIT_WIDTH(5)) ClockSelect_u(
		.clk(clk),
		.TMCI0(TMCI0),
		.TMCI1(TMCI1),
	
		.clock_select_0(clock_select_0),
		.clock_select_1(clock_select_1),

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
		clock_select_0 = 5'b00101;
		clock_select_1 = 5'b10100;


		#200 $finish;
	end

	initial begin
		$dumpfile("Output/ClockSelect.vcd");
		$dumpvars(0, ClockSelect_tb);
	end

endmodule
