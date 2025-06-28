module Timer #(
	parameter BIT_WIDTH = 8,
	parameter CLK_SELECT_BIT_WIDTH 	= 5,
	parameter EDGE_SELECT_BIT_WIDTH = 2
)(
    	input wire clk,          

	//UNIT 0	
    	//Channel 0
    	input 	TMCI0, 	//Inputs external clock for counter
	input 	TMRI0, 	//Inputs external reset to counter
	output 	TMO0, 	//Outputs compare match
    	
	//Channel 1
    	input 	TMCI1, 	//Inputs external clock for counter
	input 	TMRI1, 	//Inputs external reset to counter
	output 	TMO1, 	//Outputs compare match
	output 	ACD_REQUEST_0,

 	//Interrupt Singals
	output CMIA0,
	output CMIA1,
	output CMIB0,
	output CMIB1,
	output OVI0,
	output OVI1, 


	//UNIT 1
    	//Channel 2
    	input 	TMCI2, 	//Inputs external clock for counter
	input 	TMRI2, 	//Inputs external reset to counter
	output 	TMO2, 	//Outputs compare match

    	//Channel 3
    	input 	TMCI3, 	//Inputs external clock for counter
	input 	TMRI3, 	//Inputs external reset to counter
	output 	TMO3, 	//Outputs compare match
	output 	ACD_REQUEST_1,
 	
	//Interrupt Singals
	output CMIA2,
	output CMIA3,
	output CMIB2,
	output CMIB3,
	output OVI2,
	output OVI3
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


reg [2*BIT_WIDTH-1:0] register_file [0:11]; 
initial begin
	$readmemb("RTL/../Program/RESET_INPUT.bin", register_file);
    	$display(register_file[0]);

	//UNIT 0
	TCNT_0  = register_file[0][15:8];
	TCORA_0 = register_file[1][15:8];
	TCORB_0 = register_file[2][15:8];
	TCR_0   = register_file[3][15:8];
	TCCR_0  = register_file[4][15:8];
	TCSR_0  = register_file[5][15:8];

	TCNT_1  = register_file[0][7:0];
	TCORA_1 = register_file[1][7:0];
	TCORB_1 = register_file[2][7:0];
	TCR_1   = register_file[3][7:0];
	TCCR_1  = register_file[4][7:0];
	TCSR_1  = register_file[5][7:0];

	//UNIT 1
	TCNT_2  = register_file[6][15:8];
	TCORA_2 = register_file[7][15:8];
	TCORB_2 = register_file[8][15:8];
	TCR_2   = register_file[9][15:8];
	TCCR_2  = register_file[10][15:8];
	TCSR_2  = register_file[11][15:8];

	TCNT_3  = register_file[6][7:0];
	TCORA_3 = register_file[7][7:0];
	TCORB_3 = register_file[8][7:0];
	TCR_3   = register_file[9][7:0];
	TCCR_3  = register_file[10][7:0];
	TCSR_3  = register_file[11][7:0];
end

wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_0, clock_select_1, clock_select_2, clock_select_3;
wire CompareMatchA0, CompareMatchA1, CompareMatchA2, CompareMatchA3; 
wire CounterClock0, CounterClock1, CounterClock2, CounterClock3;
wire [EDGE_SELECT_BIT_WIDTH-1:0] CounterEdge0, CounterEdge1, CounterEdge2, CounterEdge3;
wire CounterClear0, CounterClear1, CounterClear2, CounterClear3;
wire Overflow0, Overflow1, Overflow2, Overflow3;

localparam PROHIBITED 	= 2'b00;
localparam RISING_EDGE 	= 2'b01;
localparam FALLING_EDGE = 2'b10;
localparam BOTH_EDGES 	= 2'b11;

assign Overflow_0 = (TCNT_0 == 8'hff);
assign Overflow_1 = (TCNT_1 == 8'hff);
assign Overflow_2 = (TCNT_2 == 8'hff);
assign Overflow_3 = (TCNT_3 == 8'hff);

//UNIT 0
ClockSelect #(.CLK_SELECT_BIT_WIDTH(CLK_SELECT_BIT_WIDTH), .EDGE_SELECT_BIT_WIDTH(EDGE_SELECT_BIT_WIDTH)) ClockSelect_0(
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

LogicControl #(.BIT_WIDTH(BIT_WIDTH), .CLK_SELECT_BIT_WIDTH(CLK_SELECT_BIT_WIDTH)) LogicControl_0(
	.clk(clk),
	.TMRI0(TMRI0),
	.TMRI1(TMRI1),
	.TCR_0(TCR_0),
	.TCR_1(TCR_1),
	.TCCR_0(TCCR_0),
	.TCCR_1(TCCR_1),
	.TCSR_0(TCSR_0),
	.TCSR_1(TCSR_1),
	.CompareMatchA0(CompareMatchA0),
	.CompareMatchA1(CompareMatchA1),
	.CompareMatchB0(CompareMatchB0),
	.CompareMatchB1(CompareMatchB1),
	.Overflow0(Overflow0),
	.Overflow1(Overflow1),
	.CounterClear0(CounterClear0),
	.CounterClear1(CounterClear1),
	.CMIA0(CMIA0),
	.CMIA1(CMIA1),
	.CMIB0(CMIB0),
	.CMIB1(CMIB1),
	.OVI0(OVI0),
	.OVI1(OVI1),
	.TMO0(TMO0),
	.TMO1(TMO1),
	.ADC_REQUEST(ACD_REQUEST_0),
	.clock_select_0(clock_select_0),
	.clock_select_1(clock_select_1)
);

Comparator Comparator_A0(
	.TCOR(TCORA_0), 
	.TCNT(TCNT_0),
	.CompareMatch(CompareMatchA0)
);
//Counter
always@(posedge CounterClock0 or negedge CounterClock0 or posedge CounterClear0) begin
	if(CounterClear0) 
		TCNT_0 <= 8'b00000000;
	else if(TCNT_0 == 8'hff) 
		TCNT_0 <= TCNT_0;
	else if(CounterEdge0 == PROHIBITED)
		TCNT_0 <= TCNT_0;
	else if(CounterClock0 && CounterEdge0 == RISING_EDGE)
		TCNT_0 <= TCNT_0 + 1;
	else if(!CounterClock0 && CounterEdge0 == FALLING_EDGE)
		TCNT_0 <= TCNT_0 + 1;
	else if(CounterEdge0 == BOTH_EDGES)
		TCNT_0 <= TCNT_0 + 1;
	else 
		TCNT_0 <= TCNT_0;
end
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
//Counter
always@(posedge CounterClock1 or negedge CounterClock1 or posedge CounterClear1) begin
	if(CounterClear1) 
		TCNT_1 <= 8'b0;
	else if(TCNT_1 == 8'hff) 
		TCNT_1 <= TCNT_1;
	else if(CounterEdge1 == PROHIBITED)
		TCNT_1 <= TCNT_1;
	else if(CounterClock1 && CounterEdge1 == RISING_EDGE)
		TCNT_1 <= TCNT_1 + 1;
	else if(!CounterClock1 && CounterEdge1 == FALLING_EDGE)
		TCNT_1 <= TCNT_1 + 1;
	else if(CounterEdge1 == BOTH_EDGES)
		TCNT_1 <= TCNT_1 + 1;
	else 
		TCNT_1 <= TCNT_1;
end
Comparator Comparator_B1(
	.TCOR(TCORB_1), 
	.TCNT(TCNT_1),
	.CompareMatch(CompareMatchB1)
);

//UNIT 1
ClockSelect #(.CLK_SELECT_BIT_WIDTH(5), .EDGE_SELECT_BIT_WIDTH(2)) ClockSelect_1(
	.clk(clk),
	.TMCI0(TMCI2),
	.TMCI1(TMCI3),
	.clock_select_0(clock_select_2),
	.clock_select_1(clock_select_3),
	.CounterClock0(CounterClock2),
	.CounterEdge0(CounterEdge2),
	.CounterClock1(CounterClock3),
	.CounterEdge1(CounterEdge3)
);

LogicControl #(.BIT_WIDTH(BIT_WIDTH), .CLK_SELECT_BIT_WIDTH(CLK_SELECT_BIT_WIDTH)) LogicControl_1(
	.TMRI0(TMRI2),
	.TMRI1(TMRI3),
	.TCR_0(TCR_2),
	.TCR_1(TCR_3),
	.TCCR_0(TCCR_2),
	.TCCR_1(TCCR_3),
	.TCSR_0(TCSR_2),
	.TCSR_1(TCSR_3),
	.CompareMatchA0(CompareMatchA2),
	.CompareMatchA1(CompareMatchA3),
	.CompareMatchB0(CompareMatchB2),
	.CompareMatchB1(CompareMatchB3),
	.Overflow0(Overflow2),
	.Overflow1(Overflow3),
	.CounterClear0(CounterClear2),
	.CounterClear1(CounterClear3),
	.CMIA0(CMIA2),
	.CMIA1(CMIA3),
	.CMIB0(CMIB2),
	.CMIB1(CMIB3),
	.OVI0(OVI2),
	.OVI1(OVI3),
	.TMO0(TMO2),
	.TMO1(TMO3),
	.ADC_REQUEST(ADC_REQUEST_1),
	.clock_select_0(clock_select_2),
	.clock_select_1(clock_select_3)
);

Comparator Comparator_A2(
	.TCOR(TCORA_2), 
	.TCNT(TCNT_2),
	.CompareMatch(CompareMatchA2)
);
//Counter
always@(posedge CounterClock2 or negedge CounterClock2 or posedge CounterClear2) begin
	if(CounterClear2) 
		TCNT_2 <= 8'b0;
	else if(TCNT_2 == 8'hff) 
		TCNT_2 <= TCNT_2;
	else if(CounterEdge2 == PROHIBITED)
		TCNT_2 <= TCNT_2;
	else if(CounterClock2 && CounterEdge2 == RISING_EDGE)
		TCNT_2 <= TCNT_2 + 1;
	else if(!CounterClock1 && CounterEdge1 == FALLING_EDGE)
		TCNT_2 <= TCNT_2 + 1;
	else if(CounterEdge1 == BOTH_EDGES)
		TCNT_2 <= TCNT_2 + 1;
	else 
		TCNT_2 <= TCNT_2;
end
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
//Counter
always@(posedge CounterClock3 or negedge CounterClock3 or posedge CounterClear3) begin
	if(CounterClear3) 
		TCNT_3 <= 8'b0;
	else if(TCNT_3 == 8'hff) 
		TCNT_3 <= TCNT_3;
	else if(CounterEdge3 == PROHIBITED)
		TCNT_3 <= TCNT_3;
	else if(CounterClock3 && CounterEdge3 == RISING_EDGE)
		TCNT_3 <= TCNT_3 + 1;
	else if(!CounterClock3 && CounterEdge3 == FALLING_EDGE)
		TCNT_3 <= TCNT_3 + 1;
	else if(CounterEdge3 == BOTH_EDGES)
		TCNT_3 <= TCNT_3 + 1;
	else 
		TCNT_3 <= TCNT_3;
end
Comparator Comparator_B3(
	.TCOR(TCORB_3), 
	.TCNT(TCNT_3),
	.CompareMatch(CompareMatchB3)
);

endmodule
