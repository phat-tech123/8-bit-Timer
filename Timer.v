`include "Comparator.v"

module Timer #(
	parameter BIT_WIDTH = 8,
	parameter P = 8000000
)(
    	input wire clk,          

    	//Channel 0
    	input 	[BIT_WIDTH-1:0] TMCI0, 	//Inputs external clock for counter
	input 	[BIT_WIDTH-1:0] TMRI0, 	//Inputs external reset to counter
	output 	[BIT_WIDTH-1:0] TMO0, 	//Outputs compare match

    	//Channel 1
    	input 	[BIT_WIDTH-1:0] TMCI1, 	//Inputs external clock for counter
	input 	[BIT_WIDTH-1:0] TMRI1, 	//Inputs external reset to counter
	output 	[BIT_WIDTH-1:0] TMO1, 	//Outputs compare match

    	//Channel 2
    	input 	[BIT_WIDTH-1:0] TMCI2, 	//Inputs external clock for counter
	input 	[BIT_WIDTH-1:0] TMRI2, 	//Inputs external reset to counter
	output 	[BIT_WIDTH-1:0] TMO2, 	//Outputs compare match

    	//Channel 3
    	input 	[BIT_WIDTH-1:0] TMCI3, 	//Inputs external clock for counter
	input 	[BIT_WIDTH-1:0] TMRI3, 	//Inputs external reset to counter
	output 	[BIT_WIDTH-1:0] TMO3, 	//Outputs compare match
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


wire CompareMatchA0, CompareMatchA1, CompareMatchA2, CompareMatchA3; 
wire Overflow_0, Overflow_1, Overflow_2, Overflow_3;
wire counterClear_0, counterClear_1, counterClear_2, counterClear_3;

assign Overflow_0 = (TCNT_0 == 8'hff);
assign Overflow_1 = (TCNT_1 == 8'hff);
assign Overflow_2 = (TCNT_2 == 8'hff);
assign Overflow_3 = (TCNT_3 == 8'hff);

//UNIT 0
Comparator Comparator_A0(
	.TCOR(TCORA_0), 
	.TCNT(TCNT_0),
	.CompareMatch(CompareMatchA0)
);
Comparator Comparator_A1(
	.TCOR(TCORA_1), 
	.TCNT(TCNT_1),
	.CompareMatch(CompareMatchA1)
);

Comparator Comparator_B0(
	.TCOR(TCORB_0), 
	.TCNT(TCNT_0),
	.CompareMatch(CompareMatchB0)
);
Comparator Comparator_B1(
	.TCOR(TCORB_1), 
	.TCNT(TCNT_1),
	.CompareMatch(CompareMatchB1)
);

//UNIT 1
Comparator Comparator_A2(
	.TCOR(TCORA_2), 
	.TCNT(TCNT_2),
	.CompareMatch(CompareMatchA2)
);
Comparator Comparator_A3(
	.TCOR(TCORA_3), 
	.TCNT(TCNT_3),
	.CompareMatch(CompareMatchA3)
);

Comparator Comparator_B2(
	.TCOR(TCORB_2), 
	.TCNT(TCNT_2),
	.CompareMatch(CompareMatchB2)
);
Comparator Comparator_B3(
	.TCOR(TCORB_3), 
	.TCNT(TCNT_3),
	.CompareMatch(CompareMatchB3)
);

endmodule
