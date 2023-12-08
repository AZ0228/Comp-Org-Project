`timescale 1 ns / 1 ps

module test_ram;
  parameter ADDR_WIDTH = 30;  // 1 GiB main memory
  parameter DATA_WIDTH = 32;  // Word size is 32 bits

  reg clk;
  reg cs;
  reg we;
  reg oe;
  reg [29:0] addr;  // Adjusted address width
  wire [31:0] data;  // Adjusted data width
  reg [31:0] testbench_data;

  single_port_sync_ram #(.DATA_WIDTH(32)) u0
  (
      .clk(clk),
      .addr(addr),
      .data(data),
      .cs(cs),
      .we(we),
      .oe(oe)
  );

  always #20 clk = ~clk;
  assign data = !oe ? testbench_data : 'hz;

  integer i;
  initial begin
    $display("Time  clk  cs  we  addr  testbench_data  oe");

    {clk, cs, we, addr, testbench_data, oe} <= 0;

    repeat (2) @ (posedge clk);

    // Fill the first 10 addresses with 0
    for (i = 0; i < 10; i = i+1) begin
      repeat (1) @(posedge clk) addr <= i; we <= 1; cs <= 1; oe <= 0; testbench_data <= 32'h00000000;
      $display("%0t  %b  %b  %b  %h  %h  %b", $time, clk, cs, we, addr, testbench_data, oe);
    end

    // Fill the second 10 addresses with 1
    for (i = 10; i < 20; i = i+1) begin
      repeat (1) @(posedge clk) addr <= i; we <= 1; cs <= 1; oe <= 0; testbench_data <= 32'h00000001;
      $display("%0t  %b  %b  %b  %h  %h  %b", $time, clk, cs, we, addr, testbench_data, oe);
    end

    // Fill the third 10 addresses with 2
    for (i = 20; i < 30; i = i+1) begin
      repeat (1) @(posedge clk) addr <= i; we <= 1; cs <= 1; oe <= 0; testbench_data <= 32'h00000002;
      $display("%0t  %b  %b  %b  %h  %h  %b", $time, clk, cs, we, addr, testbench_data, oe);
    end

    // Fill the rest with 0
    for (i = 30; i < 256*1024*1024; i = i+1) begin
      repeat (1) @(posedge clk) addr <= i; we <= 1; cs <= 1; oe <= 0; testbench_data <= 32'h00000000;
      $display("%0t  %b  %b  %b  %h  %h  %b", $time, clk, cs, we, addr, testbench_data, oe);
    end

    for (i = 0; i < 256*1024*1024; i= i+1) begin
      repeat (1) @(posedge clk) addr <= i; we <= 0; cs <= 1; oe <= 1;
      $display("%0t  %b  %b  %b  %h  %h  %b", $time, clk, cs, we, addr, testbench_data, oe);
    end

    @(posedge clk) cs <= 0;

    #360 $finish;
  end
endmodule
