module aludecoder(
input [31:0] instruct,
input rst,               
output reg [2:0] alucontrol
);

wire [5:0] opcode = instruct[31:26];
wire [5:0] funct = instruct[5:0];

always @(instruct or rst) 
begin
    if (rst)
        alucontrol = 3'b000;  // Default to AND operation during reset
    else
        casex ({opcode,funct})
            12'b000100xxxxxx : alucontrol = 3'b110;
            12'b001010xxxxxx : alucontrol = 3'b111;
            12'b001000xxxxxx : alucontrol = 3'b010;
            12'bxxxxxx100000 : alucontrol = 3'b010;
            12'bxxxxxx100010 : alucontrol = 3'b110;
            12'bxxxxxx100100 : alucontrol = 3'b000;
            12'bxxxxxx100101 : alucontrol = 3'b001;
            12'bxxxxxx101010 : alucontrol = 3'b111;
            default          : alucontrol = 3'b010;
        endcase
end
endmodule
