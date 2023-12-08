`timescale 1 ns / 1 ps

module single_port_sync_ram
    # ( parameter ADDR_WIDTH = 28, // Adjusted address width
        parameter DATA_WIDTH = 32  // Adjusted data width
    )
  (   input clk,
      input [ADDR_WIDTH-1:0] addr,  // Adjusted address width
      inout [DATAH_WIDTH-1:0] data,  // Adjusted data width
      input cs,
      input we,
      input oe
  );

  reg [31:0] tmp_data;
  reg [31:0] mem[60]; // 1 << 30 = 60

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
