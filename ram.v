`timescale 1 ns / 1 ps

module single_port_sync_ram
  (   input clk,
      input [27:0] addr,  // Adjusted address width
      inout [31:0] data,  // Adjusted data width
      input cs,
      input we,
      input oe
  );

  reg [31:0] tmp_data;
  reg [31:0] mem[55]; // 1 << 28 = 56

  always @ (posedge clk) begin
    if (cs & we)
      mem[addr] <= data;
  end
  
  always @ (negedge clk) begin
    if (cs & !we)
      tmp_data <= mem[addr];
  end

  assign data = cs & oe & !we ? tmp_data : 'hz;
endmodule
