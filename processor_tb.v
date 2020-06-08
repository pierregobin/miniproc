`timescale 1ns/10ps

module processor_tb;

reg clk=0;
reg rst=0;
wire [31:0] paddr;
wire [31:0] inst;
wire [31:0] daddr;
wire [31:0] din;
wire [31:0] dout;
wire [3:0]  wen;
wire rd;

always #10 clk=~clk;

processor p1 (.clk(clk), .reset(rst),
              .paddr(paddr), .instr(inst),
	      .daddr(daddr), .din(din),
	      .dout(dout), .wen(wen), .rd(rd));


memory pmem(.clk(~clk),.addr(paddr), .dataout(inst), .rd(rd));

memory dmem(.clk(~clk), 
	    .addr(daddr), 
	    .dataout(din), 
	    .datain(dout), 
	    .wen(wen), 
	    .rd(rd));


initial
begin
	if($test$plusargs("vcd")) begin
		$dumpfile("processor_tb.vcd");
		$dumpvars(0, processor_tb);
	end
	$display ("start simu processor");
	#500 rst = 1;

	#1000;
	$display("end simu processor");
	$finish;
end
endmodule

