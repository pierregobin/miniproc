module processor(
	input clk,
	input reset,
	output [31:0] paddr,
	input [31:0] instr,
	output [31:0] daddr,
	input [31:0] din,
	output [31:0] dout,
	output [3:0] wen,
	output rd);



typedef enum {Reset,Fetch, Decode, Execute} procstate_t;
procstate_t state=Fetch;
reg [31:0] pc=32'h0;
reg [6:0] opcode;
reg [2:0] func3;
reg [6:0] func7;

assign paddr = pc;
always @(posedge clk)
begin
	if (reset == 0) begin
		state <= Reset;
		pc <= 0;
	end else begin
		case(state) 
			Reset : 
				begin 
					state <= Fetch;
					pc <=0;
				end
			Fetch : state <= Decode;
			         
			Decode : begin
				state <= Execute;
				opcode = instr[6:0];
				func3  = instr[14:12];
				func7  = instr[31:25];
				case(opcode)
					7'b0110011 : begin
						$display("OP");
						case (func3 )
							3'b000 : $display("    ADD / SUB");
							3'b001 : $display("    SLL");
							3'b010 : $display("    SLT");
							3'b011 : $display("    SLTU");
							3'b100 : $display("    XOR");
							3'b101 : $display("    SRL / SRA");
							3'b110 : $display("    OR");
							3'b111 : $display("    AND");
						endcase

					end
					7'b0010011 : begin
						$display("OP-IMM");
					end
					7'b1100011 : begin
						$display("BRANCH");
					end
					7'b0110111 : begin
						$display("LUI");
					end
					7'b0010111 : begin
						$display("AUIPC");
					end
					7'b1101111 : begin
						$display("JAL");
					end
					7'b1100111 : begin
						$display("JALR");
					end
					7'b0000011 : begin
						$display("LOAD");
					end
					7'b0100011 : begin
						$display("STORE");
					end
				endcase


				end
			       
			Execute : begin
					state <= Fetch;
					pc <= pc+4;
				end
		endcase
	end
end

endmodule


