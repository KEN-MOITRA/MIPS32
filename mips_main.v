
`timescale 1ns / 1ps

module mips_main(
    input clk,                          // Clock input
    input rst,                          // Reset input
    input [31:0] instructionmem_data,   // Instruction from instruction memory
    output [31:0] instructionmem_add,   // Address to instruction memory (PC)
    input [31:0] datamem_readdata,      // Data read from data memory
    output mem_write,                   // Memory write control signal
    output [31:0] datamem_add,          // Address to data memory
    output [31:0] write_data            // Data to write to memory
);

    // Control signals
    wire branch;        // Branch control signal
    wire jump;          // Jump control signal
    wire mem_to_reg;    // Memory to register control signal
    wire reg_dst;       // Register destination control signal
    wire reg_write;     // Register write control signal
    wire [2:0] alucontrol; // ALU control signals
    wire alu_src;       // ALU source control signal

    // Controller - generates control signals based on instruction
    Controller control_unit(
        .instruct(instructionmem_data),
        .branch(branch),
        .jump(jump),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),          // Connected directly to output
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .alucontrol(alucontrol),
        .alu_src(alu_src)
    );

    // Datapath - executes instructions using control signals
    datapath dp(
        .clk(clk),
        .rst(rst),
        .instruct(instructionmem_data),
        .read_data(datamem_readdata),
        .branch(branch),
        .jump(jump),
        .mem_to_reg(mem_to_reg),
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .alucontrol(alucontrol),
        .alu_src(alu_src),
        .pc(instructionmem_add),        // Connected directly to output
        .alu_output(datamem_add),       // Connected directly to output
        .write_data(write_data)         // Connected directly to output
    );

endmodule

