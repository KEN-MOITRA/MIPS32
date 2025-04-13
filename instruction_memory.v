`timescale 1ns / 1ps
module instruction_memory
(
    input[31:0] next_pc,
    output reg[31:0] instruction
);

reg[31:0] instruction_memory[0:63]; // Memory array to hold 64 instructions

initial 
    $readmemh("instruction_mem_data.txt", instruction_memory);

always@(next_pc)
begin
    instruction = instruction_memory[next_pc[7:2]];
end
endmodule
