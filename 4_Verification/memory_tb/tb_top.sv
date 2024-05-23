`include "memory.sv"
`include "memory_intf.sv"


module tb_top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "tb_classes.svh"

    logic clk, rst;

    memory_intf intf (
        .clk(clk), .rst(rst)
    );

    memory_16x32 dut (
        .clk(clk),
        .rst(rst),
        .en(intf.en),
        .addr(intf.addr),
        .data_in(intf.data_in),
        .data_out(intf.data_out),
        .valid_out(intf.valid_out)
    );

    initial begin
        uvm_config_db#(virtual memory_intf)::set(null, "uvm_test_top", "intf", intf);
        run_test("test");
    end

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;
    end
endmodule