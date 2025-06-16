# Makefile for Timer Simulation
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
OUTPUT_DIR = Output

#Timer 
OUTPUT = Timer
SRC = \
      RTL/Timer.v \
      RTL/ClockSelect.v \
      RTL/Comparator.v \
      RTL/Counter.v \
      RTL/LogicControl.v \
      Testbench/Timer_tb.v
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

#Counter
COUNTER_OUTPUT = $(OUTPUT_DIR)/Counter
COUNTER_SRC = RTL/Counter.v Testbench/Counter_tb.v
COUNTER_VCD_FILE = $(OUTPUT_DIR)/Counter.vcd

counter_all: counter_compile counter_run counter_wave

counter_compile:
	$(IVERILOG) -o $(COUNTER_OUTPUT) $(COUNTER_SRC)

counter_run:
	$(VPP) $(COUNTER_OUTPUT)

counter_wave:
	$(GTKWAVE) $(COUNTER_VCD_FILE)

counter_clean:
	rm -f $(COUNTER_OUTPUT) $(COUNTER_VCD_FILE)


#LogicControl
LOGIC_CONTROL_OUTPUT = $(OUTPUT_DIR)/LogicControl
LOGIC_CONTROL_SRC = RTL/LogicControl.v Testbench/LogicControl_tb.v
LOGIC_CONTROL_VCD_FILE = $(OUTPUT_DIR)/LogicControl.vcd

logic_control_all: logic_control_compile logic_control_run logic_control_wave

logic_control_compile:
	$(IVERILOG) -o $(LOGIC_CONTROL_OUTPUT) $(LOGIC_CONTROL_SRC)

logic_control_run:
	$(VPP) $(LOGIC_CONTROL_OUTPUT)

logic_control_wave:
	$(GTKWAVE) $(LOGIC_CONTROL_VCD_FILE)

logic_control_clean:
	rm -f $(LOGIC_CONTROL_OUTPUT) $(LOGIC_CONTROL_VCD_FILE)
