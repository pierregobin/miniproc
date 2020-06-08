module memory( input clk, 
	input [31:0] addr, 
	input [31:0] datain, 
	output [31:0] dataout, 
	input [3:0] wen, 
	input rd);

reg [31:0] memory [0:1024];
wire [31:0] d;


initial begin
	memory[0] = 32'h 3fc00093; //       li      x1,1020
	memory[1] = 32'h 0000a023; //       sw      x0,0(x1)
	memory[2] = 32'h 0000a103; // loop: lw      x2,0(x1)
	memory[3] = 32'h 00110113; //       addi    x2,x2,1
	memory[4] = 32'h 0020a023; //       sw      x2,0(x1)
	memory[5] = 32'h ff5ff06f; //       j       <loop>
end
assign dataout = memory[addr >> 2];


always @(posedge clk) 
begin
	if (wen[0] == 0) memory[addr >> 2][ 7: 0] <= datain[7:0];
	if (wen[1] == 0) memory[addr >> 2][15: 8] <= datain[7:0];
	if (wen[2] == 0) memory[addr >> 2][23:16] <= datain[7:0];
	if (wen[3] == 0) memory[addr >> 2][31:24] <= datain[7:0];
end

endmodule

