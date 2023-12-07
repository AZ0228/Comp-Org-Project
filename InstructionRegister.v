module instruction_register(
	input clock,
	input reset,
	input [31:0] register_input,
	output reg [6:0] opcode,
	output reg [24:0] target_address,
	reg [31:0] temp,
	);

	always @(posedge clock)
	begin
			if (reset == 1) begin
			temp <= register_input;
			end
	opcode <= temp[31:25];
	target_address <= temp[24:0];
	end
endmodule


