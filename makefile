# Makefile for Timer Simulation
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
OUTPUT_DIR = Output

#Timer 
OUTPUT = Timer
SRC = RTL/Timer.v Testbench/Timer_tb.v
VCD_FILE = Timer.vcd

all: compile run wave

compile:
	$(IVERILOG) -o $(OUTPUT) $(SRC)

run:
	$(VVP) $(OUTPUT)

wave:
	$(GTKWAVE) $(VCD_FILE)

clean:
	rm -f $(OUTPUT) $(VCD_FILE)


#ClockSelect
CLK_SELECT_OUTPUT = $(OUTPUT_DIR)/Clock_Select
CLK_SELECT_SRC = RTL/ClockSelect.v Testbench/ClockSelect_tb.v
CLK_SELECT_VCD_FILE = $(OUTPUT_DIR)/ClockSelect.vcd

clk_select_all: clk_select_compile clk_select_run clk_select_wave

clk_select_compile:
	$(IVERILOG) -o $(CLK_SELECT_OUTPUT) $(CLK_SELECT_SRC)

clk_select_run:
	$(VPP) $(CLK_SELECT_OUTPUT)

clk_select_wave:
	$(GTKWAVE) $(CLK_SELECT_VCD_FILE)

clk_select_clean:
	rm -f $(CLK_SELECT_OUTPUT) $(CLK_SELECT_VCD_FILE)
