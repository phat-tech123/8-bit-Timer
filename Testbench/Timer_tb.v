module Timer_tb;

reg clk;          

//UNIT 0	
//Channel 0
reg 	TMCI0; 	//Inputs external clock for counter
reg 	TMRI0; 	//Inputs external reset to counter
wire 	TMO0; 	//Outputs compare match

//Channel 1
reg 	TMCI1; 	//Inputs external clock for counter
reg 	TMRI1; 	//Inputs external reset to counter
wire 	TMO1; 	//Outputs compare match
wire 	ACD_REQUEST_0;

//Interrupt Singals
wire CMIA0;
wire CMIA1;
wire CMIB0;
wire CMIB1;
wire OVI0;
wire OVI1; 


//UNIT 1
//Channel 2
reg 	TMCI2; 	//Inputs external clock for counter
reg 	TMRI2; 	//Inputs external reset to counter
wire 	TMO2; 	//Outputs compare match

//Channel 3
reg 	TMCI3; 	//Inputs external clock for counter
reg 	TMRI3; 	//Inputs external reset to counter
wire 	TMO3; 	//Outputs compare match
wire 	ACD_REQUEST_1;

//Interrupt Singals
wire CMIA2;
wire CMIA3;
wire CMIB2;
wire CMIB3;
wire OVI2;
wire OVI3;


Timer #(.BIT_WIDTH(8), .CLK_SELECT_BIT_WIDTH(5), .EDGE_SELECT_BIT_WIDTH(2)) Timer_u(
	.clk(clk),
	
	.TMCI0(TMCI0),
	.TMRI0(TMRI0),
	.TMO0(TMO0),

	.TMCI1(TMCI1),
	.TMRI1(TMRI1),
	.TMO1(TMO1),

	.ACD_REQUEST_0(ACD_REQUEST_0),
	.CMIA0(CMIA0),
	.CMIA1(CMIA1),
	.CMIB0(CMIB0),
	.CMIB1(CMIB1),
	.OVI0(OVI0),
	.OVI1(OVI1),

	.TMCI2(TMCI2),
	.TMRI2(TMRI2),
	.TMO2(TMO2),

	.TMCI3(TMCI3),
	.TMRI3(TMRI3),
	.TMO3(TMO3),

	.ACD_REQUEST_1(ACD_REQUEST_1),
	.CMIA2(CMIA2),
	.CMIA3(CMIA3),
	.CMIB2(CMIB2),
	.CMIB3(CMIB3),
	.OVI2(OVI2),
	.OVI3(OVI3)
);

initial begin
	$dumpfile("Output/Timer.vcd");
	$dumpvars(0, Timer_tb);
end

endmodule
