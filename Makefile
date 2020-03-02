WAVEEX=.vcd
TESTBENCH=TB

WAVEFILE=$(TESTBENCH)$(WAVEEX)

FILES = ProgramCounter.vhd \
		  InstructionMemory.vhd \
		  Mux.vhd \
		  PipelineFetch.vhd \
		  Adder.vhd \
		  FetchBlock.vhd \
		  ALU.vhd \
		  ControlUnit.vhd \
		  Registers.vhd \
		  SignExtend.vhd \
		  ShiftLeft.vhd \
		  PipelineDecode.vhd \
		  DecodeBlock.vhd \
		  PipelineExecute.vhd \
		  ExecuteBlock.vhd \
		  PipelineMemory.vhd \
		  DataMemory.vhd \
		  MemoryBlock.vhd \
		  MIPSCPU.vhd \
		  TB.vhd

SIMDIR=simulation
WAVEDIR=wave

STOP_TIME=200ns

GHDL_FLAGS=--warn-no-vital-generic --workdir=$(SIMDIR) --ieee=synopsys --std=08 
GHDL_SIM_OPT=--stop-time=$(STOP_TIME) 

.PHONY: clean

all: clean makedirs analysis elaborate run view

makedirs:
	@if not exist "$(SIMDIR)" mkdir $(SIMDIR) 
	@if not exist "$(WAVEDIR)" mkdir $(WAVEDIR)
	
analysis:
	@ghdl -a $(GHDL_FLAGS) $(FILES)

elaborate:
	@ghdl -e $(GHDL_FLAGS) $(TESTBENCH) 

run:
	@ghdl -r $(GHDL_FLAGS) $(TESTBENCH) $(GHDL_SIM_OPT) --vcd=$(WAVEDIR)/$(WAVEFILE)

view:
	@gtkwave $(WAVEDIR)/$(WAVEFILE)

clean:
	@if exist "$(SIMDIR)" rmdir /S /Q $(SIMDIR) 
	@if exist "$(WAVEDIR)" rmdir /S /Q $(WAVEDIR)


