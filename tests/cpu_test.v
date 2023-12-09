`include "modules/alu.v"
`include "modules/ram.v"
`include "modules/ram_large.v"
`include "modules/decoder.v"

`timescale 1 ns / 1 ps

module test_cpu;
    parameter ADDR_WIDTH = 28;
    parameter DATA_WIDTH = 32;
    
    reg osc;
    localparam period = 10;
    
    wire clock;
    assign clock = osc;

    reg cs; // chip select
    reg we; // write enable
    reg oe; // out enable
    integer i;
    reg [ADDR_WIDTH-1:0] MAR;
    wire [DATA_WIDTH-1:0] data;
    reg [DATA_WIDTH-1:0] testbench_data;
    assign data = !oe ? testbench_data : 'hz;

    single_port_sync_ram_large #(.DATA_WIDTH(DATA_WIDTH)) ram(
    .clk(clock),
    .addr(MAR),
    .data(data[DATA_WIDTH-1:0]),
    .cs_input(cs),
    .we(we),
    .oe(oe)
    );

    reg [31:0] left;
    reg [31:0] right;
    wire [31:0] alu_out;
    reg [3:0] alu_select;

    //reg [31:0] master_output; this is to view every store operation


    alu alu32(
    .left(left),
    .right(right), // 32-bit ALU inputs
    .control(alu_select), // 4-bit ALU mode select
    .out(alu_out) // 32-bit ALU output
    );

    // Maybe initialize PC here

    reg [31:0] program_counter = 'h100;
    reg [31:0] instruction_register = 'h0;
    reg [31:0] memory_buffer_register = 'h0;
    reg [31:0] AC = 'h0; // initialize accumulator here and delete this

    initial osc = 1; // don't quite understand this part (clocks stuff & needs to be changed)
    always begin
        #period osc = ~osc;
    end
    initial begin
    $dumpfile("dump.vcd");// imagine using dump 0-0
    $dumpvars;

    // Fibonnaci sequence program

    @(posedge clock) MAR <= 'h0000100; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h2000010E;
    @(posedge clock) MAR <= 'h0000101; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h2000010F;
    @(posedge clock) MAR <= 'h0000102; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0000010E;
    @(posedge clock) MAR <= 'h0000103; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h30000110;
    @(posedge clock) MAR <= 'h0000104; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h2000010F;
    @(posedge clock) MAR <= 'h0000105; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h3000010E;
    @(posedge clock) MAR <= 'h0000106; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20000110;
    @(posedge clock) MAR <= 'h0000107; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h3000010F;
    @(posedge clock) MAR <= 'h0000108; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20000111;
    @(posedge clock) MAR <= 'h0000109; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00000112;
    @(posedge clock) MAR <= 'h000010A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h30000111;
    @(posedge clock) MAR <= 'h000010B; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20000111;
    @(posedge clock) MAR <= 'h000010C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h50000002;
    @(posedge clock) MAR <= 'h000010D; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h60000100;
    @(posedge clock) MAR <= 'h000010E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10000000;
    @(posedge clock) MAR <= 'h000010F; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'd0;
    @(posedge clock) MAR <= 'h0000110; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'd1;
    @(posedge clock) MAR <= 'h0000111; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'd0;
    @(posedge clock) MAR <= 'h0000112; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'd9;
    @(posedge clock) MAR <= 'h0000113; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'hFFFFFFFF;




    @(posedge clock) program_counter <= 'h100;

    for (i = 0; i < 128; i = i + 1) begin
        // fetch
        @(posedge clock) MAR <= program_counter; we <= 0;
        cs <= 1;
        oe <= 1;
        @(posedge clock) instruction_register <= data;
        @(posedge clock) program_counter = program_counter + 1;

        // decode & execute

        case(instruction_register[31:28]) // first 4 bits
        4'b0000: begin // ADD
            @(posedge clock) MAR <= instruction_register[27:0];
            @(posedge clock) memory_buffer_register <= data;
            @(posedge clock) alu_select <= 'b0010; left <= AC; right <= memory_buffer_register;
            @(posedge clock) AC <= alu_out;
        end
        4'b0001: begin // HALT
            @(posedge clock) program_counter <= program_counter - 1;
        end
        4'b0010: begin // LOAD WORD
            @(posedge clock) MAR <= instruction_register[27:0];
            @(posedge clock) memory_buffer_register <= data;
            @(posedge clock) AC <= memory_buffer_register;
        end
        4'b0011: begin // STORE WORD
            @(posedge clock) MAR <= instruction_register[27:0];
            @(posedge clock) memory_buffer_register <= AC;
            @(posedge clock) we <= 1; oe <= 0; testbench_data <= memory_buffer_register;
            //@(posedge clock) we <= 1; oe <= 0; master_output <= memory_buffer_register;
        end
        4'b0100: begin // CLEAR
            @(posedge clock) AC <= 0;
        end
        4'b0101: begin // SKIP
            @(posedge clock) if(instruction_register[2:0] == 3'b010 && AC == 0) program_counter <= program_counter + 1;
            else if (instruction_register[2:0] == 3'b000 && AC < 0) program_counter <= program_counter + 1;
            else if (instruction_register[2:0] == 3'b100 && AC > 0) program_counter <= program_counter + 1;
        end
        4'b0110: begin // JUMP
            @(posedge clock) program_counter <= instruction_register[27:0];
        end
        4'b0111: begin // ADDI (4 bit immediate value)
            @(posedge clock) memory_buffer_register <= data;
            @(posedge clock) alu_select <= 'b0010; left <= AC; right <= instruction_register[27:20];
            @(posedge clock) AC <= alu_out;
        end
	endcase
end
@(posedge clock) MAR <= 'h10D; we <= 0; cs <= 1; oe <= 1;
@(posedge clock)

#20 $finish;
end
endmodule