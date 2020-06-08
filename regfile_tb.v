`timescale 1ns/1ps

module regfile_tb;

reg clk=1;
reg reset=0;
reg [3:0] a1,a2,i0;
wire [31:0] dout1, dout2;
reg [31:0] din;
reg wen=1;


always #10 clk = ~clk;
regfile2r1w regfile (.clk(clk), .reset(reset), 
		   .add1(a1), .add2(a2), 
		   .dataout1(dout1), .dataout2(dout2), 
		   .wen(wen), .addw(i0), .datain(din));

	   initial 
	   begin
		   if ($test$plusargs("vcd")) begin
			   $dumpfile("testbench.vcd");
			   $dumpvars(0, regfile_tb);
		   end

		   $display("start simu");
		   #100 reset=1;
		   #120 a1 = 2;
		   #140 a2 = 4;
		   #140 i0 = 2;
		   #160 din = 1234;
		   #170 wen = 0;
		   #180 wen = 1;
		   #200 a2 = 5;
		   din = 32'hdeadbeef;
		   wen = 0;
		   #210 wen = 1;
		   #1000;


		   $display("end simu");
		   $finish;

	   end

	   endmodule
