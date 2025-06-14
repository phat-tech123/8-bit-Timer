module Timer #(
	parameter BIT_WIDTH = 8,
	parameter CLK_SELECT_BIT_WIDTH 	= 5,
	parameter EDGE_SELECT_BIT_WIDTH = 2
)(
    	input wire clk,          

    	//Channel 0
    	input 	TMCI0, 	//Inputs external clock for counter
	input 	TMRI0, 	//Inputs external reset to counter
	output 	TMO0, 	//Outputs compare match

    	//Channel 1
    	input 	TMCI1, 	//Inputs external clock for counter
	input 	TMRI1, 	//Inputs external reset to counter
	output 	TMO1, 	//Outputs compare match

    	//Channel 2
    	input 	TMCI2, 	//Inputs external clock for counter
	input 	TMRI2, 	//Inputs external reset to counter
	output 	TMO2, 	//Outputs compare match

    	//Channel 3
    	input 	TMCI3, 	//Inputs external clock for counter
	input 	TMRI3, 	//Inputs external reset to counter
	output 	TMO3, 	//Outputs compare match
);


// UNIT 0
//
//// Channel 0
reg [BIT_WIDTH-1:0] TCNT_0;  	//Timer counter_0
reg [BIT_WIDTH-1:0] TCORA_0; 	//Timer constant register A_0
reg [BIT_WIDTH-1:0] TCORB_0; 	//Timer constant register B_0
reg [BIT_WIDTH-1:0] TCR_0;  	//Timer control register_0
reg [BIT_WIDTH-1:0] TCCR_0; 	//Timer counter control register_0
reg [BIT_WIDTH-1:0] TCSR_0; 	//Timer control/status register_0
//
//// Channel 1
reg [BIT_WIDTH-1:0] TCNT_1;  	//Timer counter_1
reg [BIT_WIDTH-1:0] TCORA_1; 	//Timer constant register A_1
reg [BIT_WIDTH-1:0] TCORB_1; 	//Timer constant register B_1
reg [BIT_WIDTH-1:0] TCR_1;  	//Timer control register_1
reg [BIT_WIDTH-1:0] TCCR_1; 	//Timer counter control register_1
reg [BIT_WIDTH-1:0] TCSR_1; 	//Timer control/status register_1

// UNIT 1
//
//// Channel 2
reg [BIT_WIDTH-1:0] TCNT_2;  	//Timer counter_2
reg [BIT_WIDTH-1:0] TCORA_2; 	//Timer constant register A_2
reg [BIT_WIDTH-1:0] TCORB_2; 	//Timer constant register B_2T
reg [BIT_WIDTH-1:0] TCR_2;  	//Timer control register_2
reg [BIT_WIDTH-1:0] TCCR_2; 	//Timer counter control register_2
reg [BIT_WIDTH-1:0] TCSR_2; 	//Timer control/status register_2
//
//// Channel 3
reg [BIT_WIDTH-1:0] TCNT_3;  	//Timer counter_3
reg [BIT_WIDTH-1:0] TCORA_3; 	//Timer constant register A_3
reg [BIT_WIDTH-1:0] TCORB_3; 	//Timer constant register B_3
reg [BIT_WIDTH-1:0] TCR_3;  	//Timer control register_3
reg [BIT_WIDTH-1:0] TCCR_3; 	//Timer counter control register_3
reg [BIT_WIDTH-1:0] TCSR_3; 	//Timer control/status register_3

wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_0, clock_select_1, clock_select_2, clock_select_3;
wire CompareMatchA0, CompareMatchA1, CompareMatchA2, CompareMatchA3; 
wire CounterClock0, CounterClock1, CounterClock2, CounterClock3;
wire [EDGE_SELECT_BIT_WIDTH-1:0] CounterEdge0, CounterEdge1, CounterEdge2, CounterEdge3;
wire CounterClear0, CounterClear1, CounterClear2, CounterClear3;
wire Overflow0, Overflow1, Overflow2, Overflow3;

assign Overflow_0 = (TCNT_0 == 8'hff);
assign Overflow_1 = (TCNT_1 == 8'hff);
assign Overflow_2 = (TCNT_2 == 8'hff);
assign Overflow_3 = (TCNT_3 == 8'hff);

//UNIT 0
ClockSelect #(.CLK_SELECT_BIT_WIDTH(5), .EDGE_SELECT_BIT_WIDTH(2)) ClockSelect_0(
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
Comparator Comparator_A0(
	.TCOR(TCORA_0), 
	.TCNT(TCNT_0),
	.CompareMatch(CompareMatchA0)
);
Counter #(.BIT_WIDTH(8)) Counter_0(
	.CounterClock(CounterClock0),
	.CounterEdge(CounterEdge0),
	.CounterClear(CounterClear0),
	.Overflow(Overflow0),
	.TCNT(TCNT_0)
);
Comparator Comparator_B0(
	.TCOR(TCORB_0), 
	.TCNT(TCNT_0),
	.CompareMatch(CompareMatchB0)
);

Comparator Comparator_A1(
	.TCOR(TCORA_1), 
	.TCNT(TCNT_1),
	.CompareMatch(CompareMatchA1)
);
Counter #(.BIT_WIDTH(8)) Counter_1(
	.CounterClock(CounterClock1),
	.CounterEdge(CounterEdge1),
	.CounterClear(CounterClear1),
	.Overflow(Overflow1),
	.TCNT(TCNT_1)
);
Comparator Comparator_B1(
	.TCOR(TCORB_1), 
	.TCNT(TCNT_1),
	.CompareMatch(CompareMatchB1)
);

//UNIT 1
ClockSelect #(.CLK_SELECT_BIT_WIDTH(5), .EDGE_SELECT_BIT_WIDTH(2)) ClockSelect_0(
	.clk(clk),
	.TMCI2(TMCI2),
	.TMCI3(TMCI3),
	.clock_select_2(clock_select_2),
	.clock_select_3(clock_select_3),
	.CounterClock2(CounterClock2),
	.CounterEdge2(CounterEdge2),
	.CounterClock3(CounterClock3),
	.CounterEdge3(CounterEdge3)
);
Comparator Comparator_A2(
	.TCOR(TCORA_2), 
	.TCNT(TCNT_2),
	.CompareMatch(CompareMatchA2)
);
Counter #(.BIT_WIDTH(8)) Counter_2(
	.CounterClock(CounterClock2),
	.CounterEdge(CounterEdge2),
	.CounterClear(CounterClear2),
	.Overflow(Overflow2),
	.TCNT(TCNT_2)
);
Comparator Comparator_B2(
	.TCOR(TCORB_2), 
	.TCNT(TCNT_2),
	.CompareMatch(CompareMatchB2)
);

Comparator Comparator_A3(
	.TCOR(TCORA_3), 
	.TCNT(TCNT_3),
	.CompareMatch(CompareMatchA3)
);
Counter #(.BIT_WIDTH(8)) Counter_3(
	.CounterClock(CounterClock3),
	.CounterEdge(CounterEdge3),
	.CounterClear(CounterClear3),
	.Overflow(Overflow3),
	.TCNT(TCNT_3)
);
Comparator Comparator_B3(
	.TCOR(TCORB_3), 
	.TCNT(TCNT_3),
	.CompareMatch(CompareMatchB3)
);

endmodule
