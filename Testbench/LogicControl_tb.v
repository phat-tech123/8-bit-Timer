module LogicControl_tb;

reg TMRI0;
reg TMRI1;

reg [7:0] TCR_0;
reg [7:0] TCR_1;
reg [7:0] TCCR_0;
reg [7:0] TCCR_1;
reg [7:0] TCSR_0;
reg [7:0] TCSR_1;

reg CompareMatchA0;
reg CompareMatchA1;
reg CompareMatchB0;
reg CompareMatchB1;
reg Overflow0;
reg Overflow1;


wire CMIA0;
wire CMIA1;
wire CMIB0;
wire CMIB1;
wire OVI0;
wire OVI1;

wire TMO0;
wire TMO1;
wire ADC_REQUEST;

wire [4:0] clock_select_0;
wire [4:0] clock_select_1;


LogicControl #(.BIT_WIDTH(8), .CLK_SELECT_BIT_WIDTH(5)) LogicControl_u(
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
	.CMIA0(CMIA0),
	.CMIA1(CMIA1),
	.CMIB0(CMIB0),
	.CMIB1(CMIB1),
	.OVI0(OVI0),
	.OVI1(OVI1),
	.TMO0(TMO0),
	.TMO1(TMO1),
	.ADC_REQUEST(ADC_REQUEST),
	.clock_select_0(clock_select_0),
	.clock_select_1(clock_select_1)
);

initial begin
	$dumpfile("Output/LogicControl.vcd");
	$dumpvars(0, LogicControl_tb);
end


always #5 CompareMatchA0 = ~CompareMatchA0;
always #10 CompareMatchB0 = ~CompareMatchB0;


initial begin 
	TMRI0 <= 0;
	TMRI1 <= 0;
	TCR_0 <= 8'b0;
	TCR_1 <= 8'b0;
	TCCR_0 <= 8'b0;
	TCCR_1 <= 8'b0;
	TCSR_0 <= 8'b0;
	TCSR_1 <= 8'b00010000;
	
	CompareMatchA0 <= 0;
	CompareMatchA1 <= 0;
 	CompareMatchB0 <= 0;
 	CompareMatchB1 <= 0;
	Overflow0      <= 0;
	Overflow1      <= 0;


	#20 TCSR_0 = 8'b00000110;
	//TCR_0 <= 8'b00001000;


	#1000 $finish;
end

endmodule
