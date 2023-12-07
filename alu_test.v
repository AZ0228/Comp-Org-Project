module test_alu;

	//Inputs
	reg [31:0] left,
	reg [31:0] right,
	reg [3:0] control;

	//Outputs
	wire [31:0] out;

	//Actual code
	integer i;

	alu test(
			left, right, // 32-bit Inputs
			control, // ALU Control
			out // 32-bit Output
			);
			initial begin
			$dumpfile("alu_dump.vcd");
			$dumpvars(0, test);

			left = 32'h0000_0000; // 0
			right = 32'h0000_0000; // 0
			control = 4'b0010; // left + right
			#10
			if ( out != 32'h0 | zero !=='b1)
				$display("\t%s0 + 0 failed.\tExpected out = 0x%0x, z = %b%s","\033[0;31m", 32'h0, 1'b1, "\033[0m");

			$finish;
		end
endmodule

