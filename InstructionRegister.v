module instruction_register(
	input clock,
	input reset,
	input [31:0] register_input,
	output reg [5:0] opcode,
	output reg [24:0] target_address,
	);

	reg [31:0] temp;
	reg sync_reset;

	always @(posedge clock or posedge reset)
	begin
		if (reset)
			sync_reset <= 1;
		else
			sync_reset <= 0;
		if (sync_reset)
			temp <= register_input;
	end

	always @(posedge clock)
	begin
		opcode <= register_input[31:25];
		target_address <= register_input[24:0];
	end
endmodule