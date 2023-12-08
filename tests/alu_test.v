`timescale 1ns/1ps

module ALU_tb;

  reg [31:0] left;
  reg [31:0] right;
  reg [3:0] control;
  wire [31:0] out;

  // Instantiate the ALU module
  ALU dut (
    .left(left),
    .right(right),
    .control(control),
    .out(out)
  );

  // Initial block to apply inputs
  initial begin
    $dumpfile("ALU_tb.vcd");
    $dumpvars(0, ALU_tb);

    // Test case 1: Bitwise AND
    left = 32'h0000_0001; // 0
    right = 32'h0000_0000; // 0 
    control = 4'b0000; // 0 & 0 should be 0
    #10;
    
    // Test case 2: ADD
    left = 32'h0000_0045; // d69
    right = 32'h0000_001F; // d31
	control = 4'b0010; // 69 + 31 should be 100
    #10;
    
    // Test case 3: LESS THAN
    left = 32'h0000_0005; // h5
    right = 32'h0000_001E; // h30
    control = 4'b0111; // 5 < 30 should be 1
    #10;
    
    
    $finish;
  end

  // Always block to display outputs
  always @(out) begin
    $display("control = %b, left = %d, right = %d, out = %d", control, left, right, out);
  end

endmodule
