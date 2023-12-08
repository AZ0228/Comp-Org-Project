module alu(
    input [31:0] left,
    input [31:0] right,
    input [3:0] control, 
    output reg [31:0] out
);

always @(left, right, control)
    begin
       case(control)
        4'b0000: out = left & right; 
        4'b0001: out = left | right; // hello
        4'b0010: out = left + right; 
        4'b0110: out = left - right; //hello
        4'b0111: out = left < right; 
        4'b1100: out = left ~| right; 
       endcase
    end   
endmodule
