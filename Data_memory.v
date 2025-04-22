module Data_memory(
input clk,
input rst,
input mem_write,
input [31:0] alu_output,
input [31:0] write_data,
output [31:0] read_data
);

reg [31:0] data_memory[0:127];

initial 
$readmemh("data_for_datamem.txt", data_memory);

assign read_data = (rst) ? 32'h00000000 : data_memory[alu_output];

always@(posedge clk)
begin
    if (!rst && mem_write) 
        data_memory[alu_output] <= write_data;
end
endmodule
