`timescale 1ns / 1ps

module ALU(
input[31:0] srcA,srcB,
input[2:0] alucontrol,
output zero,
output reg[31:0] alu_output,
output reg carry_out
);
    
    assign zero = (alu_output == 0)? 1'b1 : 1'b0;

always@(srcA,srcB,alucontrol)
begin
case(alucontrol)
3'b010:{carry_out,alu_output} <= (srcA) + (srcB);
3'b110:{carry_out,alu_output} <= (srcA) - (srcB);
3'b000:alu_output <= (srcA) & (srcB);
3'b001:alu_output <= (srcA) |(srcB);
3'b111:alu_output <= (srcA < srcB)? 32'h00000001: 32'h00000000;
endcase
end
endmodule
