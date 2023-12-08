module AC(
    input clk;
    input reset;
    input [31:0] operand,
    input [3:0] opcode, 
    output reg [31:0] out
);

localparam NO_OP = 1'hF;
localparam LOAD = 1'h2;
localparam ADD = 1'h0;


always @(posedge clk or posedge reset)begin
    if (reset) begin
        acc <= 32'b0;
    end else begin
        case(opcode)
            LOAD: begin 
                acc <= operand;
            end
            ADD: begin
                acc <= acc + operand;
            end
            default: begin
            end
        endcase
    end
end

always @(acc) begin
    out <= acc;
end


endmodule