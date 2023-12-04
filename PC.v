module program_counter(
    input clock, // clock input
    input reset, // reset input
    input [31:0] pc_in,
    input [31:0] pc_out,
    );

    always @(posedge clock or negedge reset) begin
        if (reset == 0) begin
            pc_out <= 0;
        end else begin
            pc_out <= pc_in;
        end
    end

endmodule