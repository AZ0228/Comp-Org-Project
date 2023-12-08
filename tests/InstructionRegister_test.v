`timescale 1ns/1ns

module testbench;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in nanoseconds

  // Signals
  reg clock;
  reg reset;
  reg [31:0] register_input;
  wire [3:0] opcode;
  wire [27:0] target_address;

  // Instantiate the instruction_register module
  instruction_register dut (
    .clock(clock),
    .reset(reset),
    .register_input(register_input),
    .opcode(opcode),
    .target_address(target_address)
  );

  // Clock generation
  initial begin
    clock = 0;
    forever #((CLK_PERIOD)/2) clock = ~clock;
  end

  // Test scenario
  initial begin
    // Initialize inputs
    reset = 1;
    register_input = 32'hA5F01234; // You can change this value as needed

    // Apply reset and wait for a few clock cycles
    #20 reset = 0;

    // Provide some test inputs
    reset = 1;
    #50 register_input = 32'hB1234567; // Another test value

    // Add more test scenarios as needed

    // End simulation after some time
    #200 $finish;
  end

  // Display results
  always @(posedge clock) begin
    $display("Time=%0t, Opcode=%b, Target Address=%h", $time, opcode, target_address);
  end

endmodule