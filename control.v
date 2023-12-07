module controlunit (input [3:0] opcode, 
output reg [0:0] RegDst,
output reg [0:0] RegWrite,
output reg [0:0] ALUSrc,
output reg [0:0] ALUOp,
output reg [3:0] placeholder);

always @(*) 
    begin
        case (opcode)
            /*
            opcodes

            add - 0
            halt - 1
            load - 2
            store - 3
            clear - 4
            skip - 5
            jump - 6
            */            
            6'b00000: begin
                RegDst = 1'b1;
            end
            6'b100011: placeholder = 4'b0000;
            6'b101011: placeholder = 4'b0000;
            //branch
            6'b000100: placeholder = 4'b0000;
        endcase 
    end

endmodule