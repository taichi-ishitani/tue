TUE_HOME	= $(shell pwd | sed -e 's|tue/.*|tue|g')
export TUE_HOME

GUI	?= off

COMPILE_OPTIONS	=
RUNTIME_OPTIONS	=

COMPILE_OPTIONS	+= -full64 -sverilog -ntb_opts uvm -l compile.log -f $(TUE_HOME)/compile.f
RUNTIME_OPTIONS	+= -l simv.log

ifeq ($(GUI),on)
	COMPILE_OPTIONS	+= -debug_access+all
	RUNTIME_OPTIONS	+= -gui
endif

run_simv: simv
	./simv $(RUNTIME_OPTIONS)

simv:
	vcs $(COMPILE_OPTIONS) test.sv

CLEAN_EXCLUSIONS	= test.sv makefile . ..

.PHONY: clean
clean:
	rm -rf $(filter-out $(CLEAN_EXCLUSIONS), $(shell ls -a))