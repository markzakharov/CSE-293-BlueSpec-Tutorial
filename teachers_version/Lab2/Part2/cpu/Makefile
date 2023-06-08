TOP := Cpu
TB := Testbench
CC := bsc
BDIR := build_bsim
DECODER := ../../../Lab1/Part1/decoder
EXECUTION := ../../../Lab1/Part1/execution
MEM := ../../../Lab1/Part2/mem
FETCH := ../../Part1/fetch
REGFILE := ../../Part1/regfile
PIPELINE := ../pipeline

mk$(TB)_bsim: $(BDIR)/mk$(TOP).ba $(BDIR)/mk$(TB).ba
	$(CC) -e mk$(TB) -sim -o ./mk$(TB)_bsim -simdir $(BDIR) -bdir $(BDIR) \
	-info-dir $(BDIR) -p .:%/Libraries:../../C_imports:$(DECODER):$(MEM):\
	$(EXECUTION):$(FETCH):$(REGFILE):$(PIPELINE) ../../C_imports/C_imports.c
$(BDIR)/mk$(TOP).ba $(BDIR)/mk$(TB).ba: $(TOP).bsv $(TB).bsv $(BDIR)
	$(CC) -u -sim -simdir $(BDIR) -bdir $(BDIR) -info-dir $(BDIR) \
	-keep-fires -aggressive-conditions -p .:%/Libraries:$(DECODER):\
	$(MEM):../../C_imports:$(EXECUTION):$(FETCH):$(REGFILE):$(PIPELINE) \
       	-g mk$(TB) ./$(TB).bsv
$(BDIR):
	mkdir $(BDIR)
clean:
	rm -rf $(BDIR) mk$(TB)_bsim*
