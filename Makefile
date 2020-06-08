
VERILOG=iverilog
VERILOGFLAG=-g 2012
SIMU=vvp


all : regfile_tb.out

regfile_tb.out : regfile_tb.v regfile.v
	$(VERILOG) $(VERILOGFLAG) regfile_tb.v  regfile.v -o regfile_tb.out

regfile_test : regfile_tb.out
	$(SIMU) regfile_tb.out +vcd


clean :
	rm -rf *.out
	rm -rf *.vcd
