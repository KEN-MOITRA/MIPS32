module maindecoder(
input [31:0] instruct,
input rst,               
output branch,
output jump,
output mem_to_reg,
output mem_write,
output reg_dst,
output reg_write,
output alu_src
);

reg [6:0] control_signal;

assign {mem_to_reg, mem_write, alu_src, reg_dst, reg_write, branch, jump} = control_signal;

always@(*)
begin
    if (rst)
        control_signal <= 7'b0000000;  // All signals off during reset
    else
        case(instruct[31:26])
        6'b000000:control_signal<=7'b0001100;// R-type
        6'b100011:control_signal<=7'b1010100;//LW
        6'b101011:control_signal<=7'b0110000;//SW
        6'b000100:control_signal<=7'b0000010;//BEQ
        6'b001000:control_signal<=7'b0010100;//ADDI
        6'b000010:control_signal<=7'b0000001;//J
        default:control_signal<=7'bxxxxxxx;
        endcase
end
endmodule
