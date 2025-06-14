module ControlLogic#(
	parameter BIT_WIDTH = 8,
	parameter CLK_SELECT_BIT_WIDTH = 4
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
	output reg CounterClear0,
	output reg CounterClear1,

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
assign pulse_rst_0 = TMRIS_0 && TMRI0;
reg edge_rst_0;
always@(posedge TMRI0) begin
	edge_rst_0 <= TMRIS_0;
end
assign CounterClear0 = 	({CCLR1_0, CCLR0_0} == 2'b00)? 0 :
			({CCLR1_0, CCLR0_0} == 2'b01)? CompareMatchA0 :
			({CCLR1_0, CCLR0_0} == 2'b10)? CompareMatchB0 :
			(TMRIS_0) ? edge_rst_0 : pulse_rst_0;
//Channel 1:
assign pulse_rst_1 = TMRIS_1 && TMRI1;
reg edge_rst_1;
always@(posedge TMRI0) begin
	edge_rst_1 <= TMRIS_1;
end
assign CounterClear1 = 	({CCLR1_1, CCLR0_1} == 2'b00)? 0 :
			({CCLR1_1, CCLR0_1} == 2'b01)? CompareMatchA1 :
			({CCLR1_1, CCLR0_1} == 2'b10)? CompareMatchB1 :
			(TMRIS_1) ? edge_rst_1 : pulse_rst_1;
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
	case({OS3_0, OS2_0, OS1_0, OS0_0}) begin
		4'b0000: TMO0 <= TMRI0;
		4'b0001: TMO0 <= !CompareMatchA0;
		4'b0010: TMO0 <= CompareMatchA0;
		4'b0011: TMO0 <= (CompareMatchA0) ? ~TMO0 : TMO0;
		4'b0100: TMO0 <= !CompareMatchB0;
		4'b0101: TMO0 <= !CompareMatchA0 | !CompareMatchB0;
		4'b0110: TMO0 <= !CompareMatchB0 | CompareMatchA0;
		4'b0111: TMO0 <= (CompareMatchA0) ? ~TMO0 : !CompareMatchB0;
		4'b1000: TMO0 <= CompareMatchB0;
		4'b1001: TMO0 <= CompareMatchB0 | !CompareMatchA0;
		4'b1010: TMO0 <= CompareMatchA0 | CompareMatchB0;
		4'b1011: TMO0 <= (CompareMatchA0) ? ~TMO0 : CompareMatchB0;
		4'b1100: TMO0 <= (CompareMatchB0) ? ~TMO0 : TMO0;
		4'b1101: TMO0 <= (CompareMatchB0) ? ~TMO0 : !CompareMatchA0;
		4'b1110: TMO0 <= (CompareMatchB0) ? ~TMO0 : CompareMatchA0;
		4'b1111: TMO0 <= (CompareMatchA0 || CompareMatchB0) ? ~TMO0 : TMO0;
		default: TMO0 <= TMO0;
	end
	//Channel 1
	case({OS3_1, OS2_1, OS1_1, OS0_1}) begin
		4'b0000: TMO1 <= TMRI1;
		4'b0001: TMO1 <= !CompareMatchA1;
		4'b0010: TMO1 <= CompareMatchA1;
		4'b0011: TMO1 <= (CompareMatchA1) ? ~TMO1 : TMO1;
		4'b0100: TMO1 <= !CompareMatchB1;
		4'b0101: TMO1 <= !CompareMatchA1 | !CompareMatchB1;
		4'b0110: TMO1 <= !CompareMatchB1 | CompareMatchA1;
		4'b0111: TMO1 <= (CompareMatchA1) ? ~TMO1 : !CompareMatchB1;
		4'b1000: TMO1 <= CompareMatchB1;
		4'b1001: TMO1 <= CompareMatchB1 | !CompareMatchA1;
		4'b1010: TMO1 <= CompareMatchA1 | CompareMatchB1;
		4'b1011: TMO1 <= (CompareMatchA1) ? ~TMO1 : CompareMatchB1;
		4'b1100: TMO1 <= (CompareMatchB1) ? ~TMO1 : TMO1;
		4'b1101: TMO1 <= (CompareMatchB1) ? ~TMO1 : !CompareMatchA1;
		4'b1110: TMO1 <= (CompareMatchB1) ? ~TMO1 : CompareMatchA1;
		4'b1111: TMO1 <= (CompareMatchA1 || CompareMatchB1) ? ~TMO1 : TMO1;
		default: TMO1 <= TMO1;
	end
end

assign clock_select_0 = {CKS2_0, CKS1_0, CKS0_0, ICKS1_0, ICKS0_0};
assign clock_select_1 = {CKS2_1, CKS1_1, CKS0_1, ICKS1_1, ICKS0_1};

endmodule
