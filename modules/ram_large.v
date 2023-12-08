`timescale 1 ns / 1 ps

module single_port_sync_ram_large
  # ( parameter ADDR_WIDTH = 30,  // Updated address width for 1 GiB
      parameter DATA_WIDTH = 32,  // Data width remains 32 bits
      parameter DATA_WIDTH_SHIFT = 2  // Log base 2 of 4, since we're using 4 modules
    )
  (   input clk,
      input [ADDR_WIDTH-1:0] addr,
      inout [DATA_WIDTH-1:0] data,
      input cs_input,
      input we,
      input oe
  );

  wire [1:0] cs;  // Only 2 bits needed now, for 4 modules

  // Updated decoder for 2-bit output
  decoder #(.ENCODE_WIDTH(2)) dec
  (   .in(addr[ADDR_WIDTH-1:ADDR_WIDTH-2]),
      .out(cs) 
  );

  // Four instances of the smaller RAM module
  single_port_sync_ram u0 (.clk(clk), .addr(addr[ADDR_WIDTH-3:0]), .data(data), .cs(cs[0]), .we(we), .oe(oe));
  single_port_sync_ram u1 (.clk(clk), .addr(addr[ADDR_WIDTH-3:0]), .data(data), .cs(cs[1]), .we(we), .oe(oe));
  single_port_sync_ram u2 (.clk(clk), .addr(addr[ADDR_WIDTH-3:0]), .data(data), .cs(cs[2]), .we(we), .oe(oe));
  single_port_sync_ram u3 (.clk(clk), .addr(addr[ADDR_WIDTH-3:0]), .data(data), .cs(cs[3]), .we(we), .oe(oe));

  // ... (rest of the module)
endmodule
