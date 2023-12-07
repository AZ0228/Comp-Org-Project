module controlunit (input [4:0] opcode, 
output [4:0] control_signal)

    always @(opcode) begin
        case (opcode)
            
        endcase 
    end

endmodule