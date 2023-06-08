TOP := Decoder
TB := Testbench
CC := bsc
BDIR := build_bsim
MEM := ../../Part2/mem

mk$(TB)_bsim: $(BDIR)/mk$(TOP).ba $(BDIR)/mk$(TB).ba
	$(CC) -e mk$(TB) -sim -o ./mk$(TB)_bsim -simdir $(BDIR) -bdir $(BDIR) \
	-info-dir $(BDIR) -p .:%/Libraries:$(MEM):../../C_imports \
	../../C_imports/C_imports.c
$(BDIR)/mk$(TOP).ba $(BDIR)/mk$(TB).ba: $(TOP).bsv $(TB).bsv $(BDIR)
	$(CC) -u -sim -simdir $(BDIR) -bdir $(BDIR) -info-dir $(BDIR) \
	-keep-fires -aggressive-conditions -p .:%/Libraries:$(MEM):../../C_imports \
	-g mk$(TB) ./$(TB).bsv
$(BDIR):
	mkdir $(BDIR)
clean:
	rm -rf $(BDIR) mk$(TB)_bsim*
