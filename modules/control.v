module controlunit (input [3:0] opcode, 
output reg [0:0] RegDst,
output reg [0:0] RegWrite,
output reg [0:0] ALUSrc,
output reg [1:0] ALUOp,
output reg [0:0] MemWrite,
output reg [0:0] MemRead,
output reg [0:0] MemToReg);

always @(*) 
    begin
        case (opcode)
            /*
            // 10 - subtraction
            opcodes, ALUOp
            add - 0, 00
            halt - 1, 01 
            load - 2, 00
            store - 3, 00
            clear - 4, 01
            skip - 5, 01 
            jump - 6, 01
            */            
            4'b0000: begin // add
                RegDst = 1'b1;
                RegWrite = 1'b1;
                ALUSrc = 1'b0;
                ALUOp = 2'b00;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                MemToReg = 1'b0;
            end
            4'b0001: begin // halt
                // RegDst = 1'b1; //don't care
                // RegWrite = 1'b1;
                // ALUSrc = 0'b1;
                // ALUOp = 01'b2;
                // MemWrite = 0'b1;
                // MemRead = 0'b1;
                // MemToReg = 0'b1;
            end
            4'b0010: begin // load
                RegDst = 1'b0;
                RegWrite = 1'b1;
                ALUSrc = 1'b1;
                ALUOp = 2'b00;
                MemWrite = 1'b0;
                MemRead = 1'b1;
                MemToReg = 1'b1;
            end
            4'b0011: begin // store
                RegDst = 1'b0; //don't care
                RegWrite = 1'b0;
                ALUSrc = 1'b1;
                ALUOp = 2'b00;
                MemWrite = 1'b1;
                MemRead = 1'b0;
                MemToReg = 1'b0; //don't care
            end
            4'b0100: begin // clear
                RegDst = 1'b1;
            end
            4'b0101: begin // skip (treating like beq)
                RegDst = 1'b0; //don't care
                RegWrite = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 2'b00;
                MemWrite = 1'b1;
                MemRead = 1'b0;
                MemToReg = 1'b0; //don't care
            end
            4'b0110: begin // jump
                RegDst = 1'b1;
            end

        endcase 
    end

endmodule