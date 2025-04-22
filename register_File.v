module register_File(
input clk,
input rst,               
input [4:0] reg1_add, reg2_add,
input RegWrite,
input [4:0] write_add,
input [31:0] write_data,
output reg [31:0] read_data1, read_data2
);

reg [31:0] register[0:31];

initial
$readmemh("data_for_registermem.txt", register);

always@(posedge clk)
begin
    if (rst) begin
        // Optional: Reset specific registers if needed
    end
    else if (RegWrite) register[write_add] <= write_data;
end

always@(reg1_add or rst)
begin
    if (rst)
        read_data1 <= 32'h00000000;
    else if (reg1_add == 4'h0)
        read_data1 <= 32'h00000000;
    else
        read_data1 <= register[reg1_add];
end

always@(reg2_add or rst)
begin
    if (rst)
        read_data2 <= 32'h00000000;
    else if (reg2_add == 4'h0)
        read_data2 <= 32'h00000000;
    else
        read_data2 <= register[reg2_add];
end
endmodule
