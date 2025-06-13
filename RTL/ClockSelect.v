module ClockSelect#(
	parameter CLK_SELECT_BIT_WIDTH = 3
)(
	//Internal clocks
	input wire clk,

	//External clocks
	input wire TMCI0,
	input wire TMCI1,

	//clock_select
	input wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_0,
	input wire [CLK_SELECT_BIT_WIDTH-1:0] clock_select_1,
	input wire edge_select_0,
	input wire edge_select_1,

	//output
	output wire CounterClock0,
	output wire CounterEdge0,
	output wire CounterClock1,
	output wire CounterEdge1
);

    	wire clk_div2, clk_div8, clk_div32, clk_div64, clk_div1024, clk_div8192;
	ClockDivider #(.DIVISOR(2))    div2   (.clk_in(clk), .clk_out(clk_div2));
	ClockDivider #(.DIVISOR(8))    div8   (.clk_in(clk), .clk_out(clk_div8));
	ClockDivider #(.DIVISOR(32))   div32  (.clk_in(clk), .clk_out(clk_div32));
	ClockDivider #(.DIVISOR(64))   div64  (.clk_in(clk), .clk_out(clk_div64));
	ClockDivider #(.DIVISOR(1024)) div1024(.clk_in(clk), .clk_out(clk_div1024));
	ClockDivider #(.DIVISOR(8192)) div8192(.clk_in(clk), .clk_out(clk_div8192));

	reg selected_clk_0;
	always@(*) begin
		case(clock_select_0)
			3'b000: selected_clk_0 	= clk_div2;
            		3'b001: selected_clk_0 	= clk_div8;
			3'b010: selected_clk_0 	= clk_div32;
			3'b011: selected_clk_0  = clk_div64;
			3'b100: selected_clk_0 	= clk_div1024;
			3'b101: selected_clk_0 	= clk_div8192;
			3'b110: selected_clk_0 	= TMCI0;
			3'b111: selected_clk_0 	= TMCI1;
			default: selected_clk_0 = selected_clk_0;
		endcase
	end
	
	reg selected_clk_1;
	always@(*) begin
		case(clock_select_1)
			3'b000: selected_clk_1 	= clk_div2;
            		3'b001: selected_clk_1 	= clk_div8;
			3'b010: selected_clk_1 	= clk_div32;
			3'b011: selected_clk_1  = clk_div64;
			3'b100: selected_clk_1 	= clk_div1024;
			3'b101: selected_clk_1 	= clk_div8192;
			3'b110: selected_clk_1 	= TMCI0;
			3'b111: selected_clk_1 	= TMCI1;
			default: selected_clk_1 = selected_clk_1;
		endcase
	end

	assign CounterClock0 = selected_clk_0;
	assign CounterClock1 = selected_clk_1;
	assign CounterEdge0  = edge_select_0;
	assign CounterEdge1  = edge_select_1;
endmodule


module ClockDivider#(
	parameter DIVISOR = 1
)(
	input clk_in,
	output reg clk_out
);

initial begin 
	clk_out = 0;
end

reg [27:0] counter = 0;
always@(posedge clk_in) begin
	if(counter == DIVISOR-1) begin
		clk_out <= ~clk_out;
		counter <= 28'd0;
	end else begin
		counter <= counter + 1;
	end
end

endmodule
