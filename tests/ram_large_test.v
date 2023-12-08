`timescale 1 ns / 1 ps

module test_ram_large;
  // Adjusting parameters to match the single_port_sync_ram_large module
  parameter ADDR_WIDTH = 30;
  parameter DATA_WIDTH = 32;

  reg clk;
  reg cs_input;
  reg we;
  reg oe;
  reg [ADDR_WIDTH-1:0] addr;
  wire [DATA_WIDTH-1:0] data;
  reg [DATA_WIDTH-1:0] testbench_data;

  // Instantiating single_port_sync_ram_large
  single_port_sync_ram_large #(
      .ADDR_WIDTH(ADDR_WIDTH),
      .DATA_WIDTH(DATA_WIDTH)
  ) u0 (
      .clk(clk),
      .addr(addr),
      .data(data),
      .cs_input(cs_input),
      .we(we),
      .oe(oe)
  );

  always #20 clk = ~clk; // Generating clock signal

  // Handling the data inout correctly
  assign data = (!oe && cs_input) ? testbench_data : 'hz;

  integer i;
  initial begin
    $dumpfile("dump_large.vcd");
    $dumpvars;
    {clk, cs_input, we, addr, testbench_data, oe} <= 0;

    // Initial reset
    repeat (2) @ (posedge clk);

    // Write operations
    for (i = 0; i < 16; i = i+1) begin
      repeat (1) @(posedge clk) begin
        addr <= i; we <= 1; cs_input <= 1; oe <= 0; testbench_data <= $random;
      end
    end

    // Read operations
    for (i = 0; i < 16; i = i+1) begin
      repeat (1) @(posedge clk) begin
        addr <= i; we <= 0; cs_input <= 1; oe <= 1;
      end
    end
    
    #40 $finish;
  end
endmodule