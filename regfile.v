module regfile2r1w(
	input clk,
	input reset,
	input [3:0] add1,
	input [3:0] add2,
	output [31:0] dataout1,
	output [31:0] dataout2,
	input  wen,
	input [3:0] addw,
	input [31:0] datain
); 

reg [31:0] regfile [15:0];

always @(posedge clk) 
begin
	if (reset==0) begin
		integer i;
		for(i=0;i<16;i++) regfile[i] <=0;
	end else 
		if (wen == 0) begin
			regfile[addw] <= datain;
		end
	begin
	end
	
end

assign dataout1 = regfile[add1];
assign dataout2 = regfile[add2];
endmodule

