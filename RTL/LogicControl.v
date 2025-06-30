module LogicControl#(
	parameter BIT_WIDTH = 8,
	parameter CLK_SELECT_BIT_WIDTH = 4
)(
	input wire clk,
	input wire TMRI0,
	input wire TMRI1,

	input wire [BIT_WIDTH-1:0] TCR_0,
	input wire [BIT_WIDTH-1:0] TCR_1,
	input wire [BIT_WIDTH-1:0] TCCR_0,
	input wire [BIT_WIDTH-1:0] TCCR_1,
	input wire [BIT_WIDTH-1:0] TCSR_0,
	input wire [BIT_WIDTH-1:0] TCSR_1,

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

	output wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_0,
	output wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_1
);



//TCR
assign CMIEB_0 	= TCR_0[7];
assign CMIEA_0 	= TCR_0[6];
assign OVIE_0 	= TCR_0[5];
assign CCLR1_0 	= TCR_0[4];
assign CCLR0_0 	= TCR_0[3];
assign CKS2_0 	= TCR_0[2];
assign CKS1_0 	= TCR_0[1];
assign CKS0_0 	= TCR_0[0];

assign CMIEB_1 	= TCR_1[7];
assign CMIEA_1 	= TCR_1[6];
assign OVIE_1 	= TCR_1[5];
assign CCLR1_1 	= TCR_1[4];
assign CCLR0_1 	= TCR_1[3];
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
assign CMFB_0 	= TCSR_0[7];
assign CMFA_0 	= TCSR_0[6];
assign OVF_0 	= TCSR_0[5];
assign ADTE_0 	= TCSR_0[4];
assign OS3_0 	= TCSR_0[3];
assign OS2_0 	= TCSR_0[2];
assign OS1_0 	= TCSR_0[1];
assign OS0_0 	= TCSR_0[0];


assign CMFB_1 	= TCSR_1[7];
assign CMFA_1 	= TCSR_1[6];
assign OVF_1 	= TCSR_1[5];
assign OS3_1 	= TCSR_1[3];
assign OS2_1 	= TCSR_1[2];
assign OS1_1 	= TCSR_1[1];
assign OS0_1 	= TCSR_1[0];

//Channel 0:
reg TMRI0_d;
always@(posedge clk) begin
	TMRI0_d <= TMRI0;
end
assign pulse_rst_0 = TMRIS_0 & TMRI0;
assign edge_rst_0  = TMRI0_d; 
assign CounterClear0 = 	({CCLR1_0, CCLR0_0} == 2'b00)? 0 :
			({CCLR1_0, CCLR0_0} == 2'b01)? CompareMatchA0 :
			({CCLR1_0, CCLR0_0} == 2'b10)? CompareMatchB0 :
			(TMRIS_0) ? pulse_rst_0 : edge_rst_0;
//Channel 1:
reg TMRI1_d;
always@(posedge clk) begin
	TMRI1_d <= TMRI1;
end
assign pulse_rst_1 = TMRIS_1 & TMRI1;
assign edge_rst_1  = TMRI1_d;
assign CounterClear1 = 	({CCLR1_1, CCLR0_1} == 2'b00)? 0 :
			({CCLR1_1, CCLR0_1} == 2'b01)? CompareMatchA1 :
			({CCLR1_1, CCLR0_1} == 2'b10)? CompareMatchB1 :
			(TMRIS_1) ? pulse_rst_1 : edge_rst_1;


always@(*) begin
	//Channel 0:
	CMIB0 	<= CMFB_0 & CMIEB_0;
	CMIA0 	<= CMFA_0 & CMIEA_0;
	OVI0 	<= OVF_0 & OVIE_0;
	
	//Channel 1:
	CMIB1 	<= CMFB_1 & CMIEB_1;
	CMIA1 	<= CMFA_1 & CMIEA_1;
	OVI1 	<= OVF_1 & OVIE_1;
end

always@(*) begin
	ADC_REQUEST <= (ADTE_0)? CompareMatchA0 : !CompareMatchA0;
	//Channel 0
	case({OS3_0, OS2_0, OS1_0, OS0_0}) 
		4'b0000: TMO0 <= TMO0;

		4'b0001: 
			if(CompareMatchB0) 	TMO0 <= TMO0;
			else if(CompareMatchA0) TMO0 <= 0;
			else 			TMO0 <= TMO0;

		4'b0010: 
			if(CompareMatchB0) 	TMO0 <= TMO0;
			else if(CompareMatchA0) TMO0 <= 1;
			else 			TMO0 <= TMO0;

		4'b0011:
			if(CompareMatchB0) 	TMO0 <= 0;
			else if(CompareMatchA0) TMO0 <= ~TMO0;
			else 			TMO0 <= TMO0;

		4'b0100: 
			if(CompareMatchB0) 	TMO0 <= 0;
			else if(CompareMatchA0) TMO0 <= TMO0;
			else 			TMO0 <= TMO0;

		4'b0101: 
			if(CompareMatchB0) 	TMO0 <= 0;
			else if(CompareMatchA0) TMO0 <= 0;
			else 			TMO0 <= TMO0;

		4'b0110:
			if(CompareMatchB0) 	TMO0 <= 0;
			else if(CompareMatchA0) TMO0 <= 1;
			else 			TMO0 <= TMO0;
		
		4'b0111: 
			if(CompareMatchB0) 	TMO0 <= 0;
			else if(CompareMatchA0) TMO0 <= ~TMO0;
			else 			TMO0 <= TMO0;
		
		4'b1000: 
			if(CompareMatchB0) 	TMO0 <= 1;
			else if(CompareMatchA0) TMO0 <= TMO0;
			else 			TMO0 <= TMO0;
		
		4'b1001: 
			if(CompareMatchB0) 	TMO0 <= 1;
			else if(CompareMatchA0) TMO0 <= 0;
			else 			TMO0 <= TMO0;
		
		4'b1010: 
			if(CompareMatchB0) 	TMO0 <= 1;
			else if(CompareMatchA0) TMO0 <= 1;
			else 			TMO0 <= TMO0;
		
		4'b1011: 
			if(CompareMatchB0) 	TMO0 <= 1;
			else if(CompareMatchA0) TMO0 <= ~TMO0;
			else 			TMO0 <= TMO0;
		
		4'b1100: 
			if(CompareMatchB0) 	TMO0 <= ~TMO0;
			else if(CompareMatchA0) TMO0 <= TMO0;
			else 			TMO0 <= TMO0;
		
		4'b1101: 
			if(CompareMatchB0) 	TMO0 <= ~TMO0;
			else if(CompareMatchA0) TMO0 <= 0;
			else 			TMO0 <= TMO0;
		
		4'b1110: 
			if(CompareMatchB0) 	TMO0 <= ~TMO0;
			else if(CompareMatchA0) TMO0 <= 1;
			else 			TMO0 <= TMO0;
		
		4'b1111: 
			if(CompareMatchB0) 	TMO0 <= ~TMO0;
			else if(CompareMatchA0) TMO0 <= ~TMO0;
			else 			TMO0 <= TMO0;
		
		default: TMO0 <= TMO0;
	endcase
	//Channel 1
	case({OS3_1, OS2_1, OS1_1, OS0_1}) 
		4'b0000: TMO1 <= TMO1;

		4'b0001: 
			if(CompareMatchB1) 	TMO1 <= TMO1;
			else if(CompareMatchA1) TMO1 <= 0;
			else 			TMO1 <= TMO1;

		4'b0010: 
			if(CompareMatchB1) 	TMO1 <= TMO1;
			else if(CompareMatchA1) TMO1 <= 1;
			else 			TMO1 <= TMO1;

		4'b0011:
			if(CompareMatchB1) 	TMO1 <= 0;
			else if(CompareMatchA1) TMO1 <= ~TMO1;
			else 			TMO1 <= TMO1;

		4'b0100: 
			if(CompareMatchB1) 	TMO1 <= 0;
			else if(CompareMatchA1) TMO1 <= TMO1;
			else 			TMO1 <= TMO1;

		4'b0101: 
			if(CompareMatchB1) 	TMO1 <= 0;
			else if(CompareMatchA1) TMO1 <= 0;
			else 			TMO1 <= TMO1;

		4'b0110:
			if(CompareMatchB1) 	TMO1 <= 0;
			else if(CompareMatchA1) TMO1 <= 1;
			else 			TMO1 <= TMO1;
		
		4'b0111: 
			if(CompareMatchB1) 	TMO1 <= 0;
			else if(CompareMatchA1) TMO1 <= ~TMO1;
			else 			TMO1 <= TMO1;
		
		4'b1000: 
			if(CompareMatchB1) 	TMO1 <= 1;
			else if(CompareMatchA1) TMO1 <= TMO1;
			else 			TMO1 <= TMO1;
		
		4'b1001: 
			if(CompareMatchB1) 	TMO1 <= 1;
			else if(CompareMatchA1) TMO1 <= 0;
			else 			TMO1 <= TMO1;
		
		4'b1010: 
			if(CompareMatchB1) 	TMO1 <= 1;
			else if(CompareMatchA1) TMO1 <= 1;
			else 			TMO1 <= TMO1;
		
		4'b1011: 
			if(CompareMatchB1) 	TMO1 <= 1;
			else if(CompareMatchA1) TMO1 <= ~TMO1;
			else 			TMO1 <= TMO1;
		
		4'b1100: 
			if(CompareMatchB1) 	TMO1 <= ~TMO1;
			else if(CompareMatchA1) TMO1 <= TMO1;
			else 			TMO1 <= TMO1;
		
		4'b1101: 
			if(CompareMatchB1) 	TMO1 <= ~TMO1;
			else if(CompareMatchA1) TMO1 <= 0;
			else 			TMO1 <= TMO1;
		
		4'b1110: 
			if(CompareMatchB1) 	TMO1 <= ~TMO1;
			else if(CompareMatchA1) TMO1 <= 1;
			else 			TMO1 <= TMO1;
		
		4'b1111: 
			if(CompareMatchB1) 	TMO1 <= ~TMO1;
			else if(CompareMatchA1) TMO1 <= ~TMO1;
			else 			TMO1 <= TMO1;
		
		default: TMO1 <= TMO1;
	endcase
end

assign clock_select_0 = {CKS2_0, CKS1_0, CKS0_0, ICKS1_0, ICKS0_0};
assign clock_select_1 = {CKS2_1, CKS1_1, CKS0_1, ICKS1_1, ICKS0_1};

endmodule
