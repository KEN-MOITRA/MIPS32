`timescale 1ns / 1ps

module Basic_io_tb;
    // Inputs
    reg clk;
    reg rst;
    
    // Instantiating the top-level module
    Basic_io UUT (
        .clk(clk),
        .rst(rst)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period (100MHz)
    end
    
    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        
        //reset for 20ns
        #20;
        rst = 0;
        
        //Run the processor for sufficient time to execute the program
        #500;
        
        // End simulation
        $finish;
    end
    
    // Monitor important signals
    initial begin
        $monitor("Time=%0t, PC=%h, Instruction=%h, ALU_Out=%h, WriteData=%h", 
                 $time, 
                 UUT.main_processor.datapath_inst.pc, 
                 UUT.instructionmem_data,
                 UUT.datamem_add,
                 UUT.write_data);
        
        waveform dumping
        $dumpfile("mips_simulation.vcd");
        $dumpvars(0, Basic_io_tb);
    end
endmodule
