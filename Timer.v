module Timer #(
	parameter BIT_WIDTH = 8,
	parameter P = 8000000
)(
    	input wire clk,          
    	input wire reset_n   

    	//Channel 0
    	input 	[BIT_WIDTH-1:0] TMCI0, 	//Inputs external clock for counter
	input 	[BIT_WIDTH-1:0] TMRI0, 	//Inputs external reset to counter
	output 	[BIT_WIDTH-1:0] TMO0, 	//Outputs compare match

    	//Channel 1
    	input 	[BIT_WIDTH-1:0] TMCI1, 	//Inputs external clock for counter
	input 	[BIT_WIDTH-1:0] TMRI1, 	//Inputs external reset to counter
	output 	[BIT_WIDTH-1:0] TMO1 	//Outputs compare match
);


// UNIT 0
//
//// Channel 0
reg [BIT_WIDTH-1:0] TCNC_0;  	//Timer counter_0
reg [BIT_WIDTH-1:0] TCORA_0; 	//Timer constant register A_0
reg [BIT_WIDTH-1:0] TCORB_0; 	//Timer constant register B_0
reg [BIT_WIDTH-1:0] TCR_0;  	//Timer control register_0
reg [BIT_WIDTH-1:0] TCCR_0; 	//Timer counter control register_0
reg [BIT_WIDTH-1:0] TCSR_0; 	//Timer control/status register_0
//
//// Channel 1
reg [BIT_WIDTH-1:0] TCNC_1;  	//Timer counter_1
reg [BIT_WIDTH-1:0] TCORA_1; 	//Timer constant register A_1
reg [BIT_WIDTH-1:0] TCORB_1; 	//Timer constant register B_1
reg [BIT_WIDTH-1:0] TCR_1;  	//Timer control register_1
reg [BIT_WIDTH-1:0] TCCR_1; 	//Timer counter control register_1
reg [BIT_WIDTH-1:0] TCSR_1; 	//Timer control/status register_1

/*
// UNIT 1
//
//// Channel 2
reg [BIT_WIDTH-1:0] TCNC_2;  	//Timer counter_2
reg [BIT_WIDTH-1:0] TCORA_2; 	//Timer constant register A_2
reg [BIT_WIDTH-1:0] TCORB_2; 	//Timer constant register B_2T
reg [BIT_WIDTH-1:0] TCR_2;  	//Timer control register_2
reg [BIT_WIDTH-1:0] TCCR_2; 	//Timer counter control register_2
reg [BIT_WIDTH-1:0] TCSR_2; 	//Timer control/status register_2
//
//// Channel 3
reg [BIT_WIDTH-1:0] TCNC_3;  	//Timer counter_3
reg [BIT_WIDTH-1:0] TCORA_3; 	//Timer constant register A_3
reg [BIT_WIDTH-1:0] TCORB_3; 	//Timer constant register B_3
reg [BIT_WIDTH-1:0] TCR_3;  	//Timer control register_3
reg [BIT_WIDTH-1:0] TCCR_3; 	//Timer counter control register_3
reg [BIT_WIDTH-1:0] TCSR_3; 	//Timer control/status register_3
*/

initial begin
	TCNC_0 <= 8'h00;
	TCNC_1 <= 8'h00;
	//TCNC_2 <= 8'h00;
	//TCNC_3 <= 8'h00;

	TCORA_0 <= 8'hff;
	TCORA_1 <= 8'hff;
	//TCORA_2 <= 8'hff;
	//TCORA_3 <= 8'hff;

	TCORB_0 <= 8'hff;
	TCORB_1 <= 8'hff;
	//TCORB_2 <= 8'hff;
	//TCORB_3 <= 8'hff;

	TCR_0 <= 8'h00;
	TCR_1 <= 8'h00;
	//TCR_2 <= 8'h00;
	//TCR_3 <= 8'h00;

	TCCR_0 <= 8'h00;
	TCCR_1 <= 8'h00;
	//TCCR_2 <= 8'h00;
	//TCCR_3 <= 8'h00;


	TCSR_0 <= 8'b00000000;
	TCSR_1 <= 8'b00010000;
	//TCSR_2 <= 8'b00000000;
	//TCSR_3 <= 8'b00010000;
end



endmodule
