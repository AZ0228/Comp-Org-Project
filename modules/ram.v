`timescale 1 ns / 1 ps

module single_port_sync_ram
    #( parameter ADDR_WIDTH = 26, // Adjusted address width
        parameter DATA_WIDTH = 16,  // Adjusted data width
        parameter LENGTH = (1<<ADDR_WIDTH)
    )
  (   input clk,
      inout [ADDR_WIDTH-1:0] addr,  // Adjusted address width
      inout [DATA_WIDTH-1:0] data,  // Adjusted data width
      input cs,
      input we,
      input oe
  );

  reg [DATA_WIDTH-1:0] tmp_data;
  reg [DATA_WIDTH-1:0] mem[LENGTH]; 

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

