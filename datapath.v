`timescale 1ns / 1ps

module datapath
(
input clk,rst,
input[31:0] instruct,
input[31:0] read_data,
input        branch,
input        jump,
input        mem_to_reg,
input        reg_dst,
input        reg_write,
input [ 2:0] alucontrol,
input        alu_src,
output reg[31:0] pc,
output[31:0] alu_output,
output[31:0] write_data
);

// next pc generation
wire[31:0] pc_plus4;
assign pc_plus4 = pc + 32'd4;

wire[31:0] pc_jump;
assign pc_jump = {pc_plus4[31:28],instruct[25:0],2'b00};

wire[31:0] pc_branch;
wire[31:0] sign_extend;
assign pc_branch = pc_plus4 + ({sign_extend<<2}); 

wire pc_src;
wire zero;
assign pc_src = branch & zero;

wire[31:0] next_pc;
assign next_pc = jump ? pc_jump : (pc_src ? pc_branch : pc_plus4);

always@(posedge clk)
begin
if(rst) pc=32'h00000000;
else pc=next_pc;
end

//registers
wire[4:0] rs= instruct[25:21];
wire[4:0] rt=instruct[20:16];
wire[4:0] rd=instruct[15:11];

wire[4:0] write_reg = (reg_dst)? rd : rt;

wire[31:0] read_data1,read_data2;
wire[31:0] overall_result = mem_to_reg ? read_data : alu_output;

register_File regFile(.clk(clk),.rst(rst),.reg1_add(rs),.reg2_add(rt),.RegWrite(reg_write),.write_add(write_reg),.write_data(overall_result),.read_data1(read_data1),.read_data2(read_data2));

assign write_data= read_data2;

//ALU
wire[31:0] srcA = read_data1;
wire[31:0] srcB = alu_src ? sign_extend : read_data2;
wire carry_out;
wire[31:0] alu_result;

ALU main_alu(
.rst(rst),
.srcA(srcA),.srcB(srcB),
.alucontrol(alucontrol),
.zero(zero),
.alu_output(alu_result),
.carry_out(carry_out)
);

assign alu_output = alu_result;

//Sign-Extension
sign_extension sign_extendor(.input_data(instruct[15:0]),.output_data(sign_extend));


endmodule
