module ControlLogic#(
	parameter BIT_WIDTH = 8,
	parameter CLK_SELECT_BIT_WIDTH = 3
)(
	input clk,
	input wire TMRI0,
	input wire TMRI1,

	input wire [BIT_WIDTH-1:0] TCR_0,
	input wire [BIT_WIDTH-1:0] TCR_1,
	input wire [BIT_WIDTH-1:0] TCCR_0,
	input wire [BIT_WIDTH-1:0] TCCR_1,
	inout wire [BIT_WIDTH-1:0] TCSR_0,
	inout wire [BIT_WIDTH-1:0] TCSR_1,

	input wire CompareMatchA0,
	input wire CompareMatchA1,
	input wire CompareMatchB0,
	input wire CompareMatchB1,
	input wire Overflow0,
	input wire Overflow1,
	output wire CounterClear0,
	output wire CounterClear1,

	output reg CMIA0,
	output reg CMIA1,
	output reg CMIB0,
	output reg CMIB1,
	output reg OVI0,
	output reg OVI1,

	output reg TMO0,
	output reg TMO1,
	output reg ADC_REQUEST,

	output reg [CLK_SELECT_BIT_WIDTH-1:0] clock_select
);

/*
// TCR
wire CMIEB_0 = TCR_0[7];
wire CMIEA_0;
wire OVIE_0;
wire CCLR1_0;
wire CCLR0_0;
wire CKS2_0;
wire CKS1_0;
wire CKS0_0;
assign CMIEB_0 	= TCR_0[7];
assign CMIEA_0 	= TCR_0[6];
assign OVIE_0 	= TCR_0[5];
assign CCLR0_0 	= TCR_0[4];
assign CCLR1_0 	= TCR_0[3];
assign CKS2_0 	= TCR_0[2];
assign CKS1_0 	= TCR_0[1];
assign CKS0_0 	= TCR_0[0];

wire CMIEB_1;
wire CMIEA_1;
wire OVIE_1;
wire CCLR1_1;
wire CCLR0_1;
wire CKS2_1;
wire CKS1_1;
wire CKS0_1;
assign CMIEB_1 	= TCR_1[7];
assign CMIEA_1 	= TCR_1[6];
assign OVIE_1 	= TCR_1[5];
assign CCLR0_1 	= TCR_1[4];
assign CCLR1_1 	= TCR_1[3];
assign CKS2_1 	= TCR_1[2];
assign CKS1_1 	= TCR_1[1];
assign CKS0_1 	= TCR_1[0];
*/

//TCR
assign CMIEB_0 	= TCR_0[7];
assign CMIEA_0 	= TCR_0[6];
assign OVIE_0 	= TCR_0[5];
assign CCLR0_0 	= TCR_0[4];
assign CCLR1_0 	= TCR_0[3];
assign CKS2_0 	= TCR_0[2];
assign CKS1_0 	= TCR_0[1];
assign CKS0_0 	= TCR_0[0];

assign CMIEB_1 	= TCR_1[7];
assign CMIEA_1 	= TCR_1[6];
assign OVIE_1 	= TCR_1[5];
assign CCLR0_1 	= TCR_1[4];
assign CCLR1_1 	= TCR_1[3];
assign CKS2_1 	= TCR_1[2];
assign CKS1_1 	= TCR_1[1];
assign CKS0_1 	= TCR_1[0];

//TCCR
assign TMRIS_0 	= TCCR_0[3];
assign ICKS1_0 	= TCCR_0[1];
assign ICKS0_0 	= TCCR_0[0];

assign TMRIS_1 	= TCCR_1[3];
assign ICKS1_1 	= TCCR_1[1];
assign ICKS0_1 	= TCCR_1[0];

//TCSR

always@(posedge clk) begin
	//Channel 0:
	if(CMIEB_0 == 1) 
		CMIB0 = 1;
	else 	
		CMIB0 = 0;

	if(CMIEA_0 == 1)
		CMIA0 = 1;
	else 	
		CMIA0 = 0;

	if(OVIE_0 == 1)
		OVI0 = 1;
	else 	
		OVI0 = 0;

	//Channel 1:
	if(CMIEB_1 == 1) 
		CMIB1 = 1;
	else 	
		CMIB1 = 0;

	if(CMIEA_1 == 1)
		CMIA1 = 1;
	else 	
		CMIA1 = 0;

	if(OVIE_1 == 1)
		OVI1 = 1;
	else 	
		OVI1 = 0;
end


assign counterClear_0 = (TMRIS_0) ? TMRI0 : (posedge clk & TMRI0); 
assign counterClear_1 = (TMRIS_1) ? TMRI1 : (posedge clk & TMRI1); 




endmodule
