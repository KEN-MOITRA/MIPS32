module Basic_io(
input clk,
input rst,
wire [31:0] instructionmem_data
);

wire [31:0] instructionmem_add;
wire [31:0] datamem_readdata;
wire mem_write;
wire [31:0] datamem_add;
wire [31:0] write_data;

mips_main main_processor(
.clk(clk),
.rst(rst),
.instructionmem_data(instructionmem_data),
.instructionmem_add(instructionmem_add),
.datamem_readdata(datamem_readdata),
.mem_write(mem_write),
.datamem_add(datamem_add),
.write_data(write_data)
);

Data_memory data_memory(
.clk(clk),
.rst(rst),
.mem_write(mem_write),
.alu_output(datamem_add),
.write_data(write_data),
.read_data(datamem_readdata)
);

instruction_memory instruction_memory_module(
.next_pc(instructionmem_add),
.rst(rst),          
.instruction(instructionmem_data)
);
endmodule
