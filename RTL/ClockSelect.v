module ClockSelect#(
	parameter CLK_SELECT_BIT_WIDTH 	= 5,
	parameter EDGE_SELECT_BIT_WIDTH = 2
)(
	//Internal clocks
	input wire clk,

	//External clocks
	input wire TMCI0,
	input wire TMCI1,

	//clock_select
	input wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_0,
	input wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_1,

	//output
	output reg CounterClock0,
	output reg [EDGE_SELECT_BIT_WIDTH-1:0] CounterEdge0,
	output reg CounterClock1,
	output reg [EDGE_SELECT_BIT_WIDTH-1:0]CounterEdge1
);

	localparam PROHIBITED 		= 5'b00000;
	localparam RISING_DIV8      	= 5'b00100;
	localparam RISING_DIV2      	= 5'b00101;
	localparam FALLING_DIV8     	= 5'b00110;
	localparam FALLING_DIV2     	= 5'b00111;
	localparam RISING_DIV64     	= 5'b01000;
	localparam RISING_DIV32     	= 5'b01001;
	localparam FALLING_DIV64    	= 5'b01010;
	localparam FALLING_DIV32    	= 5'b01011;
	localparam RISING_DIV8192   	= 5'b01100;
	localparam RISING_DIV1024   	= 5'b01101;
	localparam FALLING_DIV8192  	= 5'b01110;
	localparam FALLING_DIV1024  	= 5'b01111;
	localparam OVF_COMP_MATCH 	= 5'b10000;
	localparam RISING_EXTERNAL  	= 5'b10100;
	localparam FALLING_EXTERNAL 	= 5'b11000;
	localparam BOTH_EDGES_EXTERNAL 	= 5'b11100;

    	wire clk_div2, clk_div8, clk_div32, clk_div64, clk_div1024, clk_div8192;
	ClockDivider #(.DIVISOR(2))    div2   (.clk_in(clk), .clk_out(clk_div2));
	ClockDivider #(.DIVISOR(8))    div8   (.clk_in(clk), .clk_out(clk_div8));
	ClockDivider #(.DIVISOR(32))   div32  (.clk_in(clk), .clk_out(clk_div32));
	ClockDivider #(.DIVISOR(64))   div64  (.clk_in(clk), .clk_out(clk_div64));
	ClockDivider #(.DIVISOR(1024)) div1024(.clk_in(clk), .clk_out(clk_div1024));
	ClockDivider #(.DIVISOR(8192)) div8192(.clk_in(clk), .clk_out(clk_div8192));

	always@(*) begin
		case(clock_select_0)
			PROHIBITED: begin
				CounterClock0 <= CounterClock0;
				CounterEdge0  <= 2'b00;
			end
			RISING_DIV8: begin
				CounterClock0 <= clk_div8;
				CounterEdge0  <= 2'b01;
			end
			RISING_DIV2: begin
				CounterClock0 <= clk_div2;
				CounterEdge0  <= 2'b01;
			end
			FALLING_DIV8: begin
				CounterClock0 <= clk_div8;
				CounterEdge0  <= 2'b10;
			end
			FALLING_DIV2: begin
				CounterClock0 <= clk_div2;
				CounterEdge0  <= 2'b10;
			end
			RISING_DIV64: begin
				CounterClock0 <= clk_div64;
				CounterEdge0  <= 2'b01;
			end
			RISING_DIV32: begin
				CounterClock0 <= clk_div32;
				CounterEdge0  <= 2'b01;
			end
			FALLING_DIV64: begin
				CounterClock0 <= clk_div64;
				CounterEdge0  <= 2'b10;
			end
			FALLING_DIV32: begin
				CounterClock0 <= clk_div32;
				CounterEdge0  <= 2'b10;
			end
			RISING_DIV8192: begin
				CounterClock0 <= clk_div8192;
				CounterEdge0  <= 2'b01;
			end
			RISING_DIV1024: begin
				CounterClock0 <= clk_div1024;
				CounterEdge0  <= 2'b01;
			end
			FALLING_DIV8192: begin
				CounterClock0 <= clk_div8192;
				CounterEdge0  <= 2'b10;
			end
			FALLING_DIV1024: begin
				CounterClock0 <= clk_div1024;
				CounterEdge0  <= 2'b10;
			end
			OVF_COMP_MATCH: begin
				CounterClock0 <= CounterClock0;
				CounterEdge0  <= 2'b00;
			end
			RISING_EXTERNAL: begin
				CounterClock0 <= TMCI0;
				CounterEdge0 <= 2'b01;
			end
			FALLING_EXTERNAL: begin
				CounterClock0 <= TMCI0;
				CounterEdge0 <= 2'b10;
			end
			BOTH_EDGES_EXTERNAL: begin
				CounterClock0 <= TMCI0;
				CounterEdge0 <= 2'b11;
			end
			default: begin
				CounterClock0 <= TMCI0;
				CounterEdge0  <= CounterEdge0;
			end
	
		endcase
	end
	
	always@(*) begin
		case(clock_select_1)
			PROHIBITED: begin
				CounterClock1 <= CounterClock1;
				CounterEdge1  <= 2'b00;
			end
			RISING_DIV8: begin
				CounterClock1 <= clk_div8;
				CounterEdge1  <= 2'b01;
			end
			RISING_DIV2: begin
				CounterClock1 <= clk_div2;
				CounterEdge1  <= 2'b01;
			end
			FALLING_DIV8: begin
				CounterClock1 <= clk_div8;
				CounterEdge1  <= 2'b10;
			end
			FALLING_DIV2: begin
				CounterClock1 <= clk_div2;
				CounterEdge1  <= 2'b10;
			end
			RISING_DIV64: begin
				CounterClock1 <= clk_div64;
				CounterEdge1  <= 2'b01;
			end
			RISING_DIV32: begin
				CounterClock1 <= clk_div32;
				CounterEdge1  <= 2'b01;
			end
			FALLING_DIV64: begin
				CounterClock1 <= clk_div64;
				CounterEdge1  <= 2'b10;
			end
			FALLING_DIV32: begin
				CounterClock1 <= clk_div32;
				CounterEdge1  <= 2'b10;
			end
			RISING_DIV8192: begin
				CounterClock1 <= clk_div8192;
				CounterEdge1  <= 2'b01;
			end
			RISING_DIV1024: begin
				CounterClock1 <= clk_div1024;
				CounterEdge1  <= 2'b01;
			end
			FALLING_DIV8192: begin
				CounterClock1 <= clk_div8192;
				CounterEdge1  <= 2'b10;
			end
			FALLING_DIV1024: begin
				CounterClock1 <= clk_div1024;
				CounterEdge1  <= 2'b10;
			end
			OVF_COMP_MATCH: begin
				CounterClock1 <= CounterClock1;
				CounterEdge1  <= 2'b00;
			end
			RISING_EXTERNAL: begin
				CounterClock1 <= TMCI1;
				CounterEdge1  <= 2'b01;
			end
			FALLING_EXTERNAL: begin
				CounterClock1 <= TMCI1;
				CounterEdge1  <= 2'b10;
			end
			BOTH_EDGES_EXTERNAL: begin
				CounterClock1 <= TMCI1;
				CounterEdge1  <= 2'b11;
			end
			default: begin
				CounterClock1 <= CounterClock1;
				CounterEdge1  <= CounterEdge1;
			end
		endcase
	end
endmodule


module ClockDivider#(
	parameter DIVISOR = 2
)(
	input clk_in,
	output reg clk_out
);

reg [27:0] counter;
initial begin 
	clk_out <= 0;
	counter <= 28'd0;
end

always@(posedge clk_in) begin
	if(counter == DIVISOR/2-1) begin
		clk_out <= ~clk_out;
		counter <= 28'd0;
	end else begin
		clk_out <= clk_out;
		counter <= counter + 1;
	end
end

endmodule
