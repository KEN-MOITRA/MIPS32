module instruction_memory(
input [31:0] next_pc,
input rst,               
output reg [31:0] instruction
);

reg [31:0] instruction_memory[0:63]; // Memory array to hold 64 instructions

initial 
    $readmemh("instruction_mem_data.txt", instruction_memory);

always@(next_pc or rst)
begin
    if (rst)
        instruction <= 32'h00000000;  // NOP during reset
    else
        instruction <= instruction_memory[next_pc[7:2]];
end
endmodule
