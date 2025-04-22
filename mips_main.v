module mips_main(
    input clk,                          
    input rst,                          
    input [31:0] instructionmem_data,   
    output [31:0] instructionmem_add,   
    input [31:0] datamem_readdata,      
    output mem_write,                   
    output [31:0] datamem_add,          
    output [31:0] write_data            
);

    // Control signals
    wire branch;        
    wire jump;          
    wire mem_to_reg;    
    wire reg_dst;       
    wire reg_write;     
    wire [2:0] alucontrol; 
    wire alu_src;       

    
    Controller control_unit(
        .instruct(instructionmem_data),
        .rst(rst),               
        .branch(branch),
        .jump(jump),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),          
        .reg_dst(reg_dst),
        .reg_write(reg_write),
        .alucontrol(alucontrol),
        .alu_src(alu_src)
    );

    
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
        .pc(instructionmem_add),        
        .alu_output(datamem_add),       
        .write_data(write_data)         
    );

endmodule
