module direct_mapped_cache #(
    parameter ADDR_WIDTH = 28,
    parameter DATA_WIDTH = 32,
)(
    input clk,
    input reset,
    input [ADDR_WIDTH-1:0] address,
    input [DATA_WIDTH-1:0] data_in,
    input read_write, // 0 for read, 1 for write
    output reg [DATA_WIDTH-1:0] data_out,
    output reg hit_miss // 0 for hit, 1 for miss
);
endmodule