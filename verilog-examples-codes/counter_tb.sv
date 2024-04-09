module counter_tb();

`timescale 1ns/1ns

reg clk_tb, rst_tb;
wire [3:0] count_tb;

initial begin
    clk_tb = 0;
    rst_tb = 0;
    #10;
    rst_tb = 1;
    #400;
    $stop;
end

always #10 clk_tb=~clk_tb;

counter dut (
    .clk(clk_tb),
    .rst(rst_tb),
    .count(count_tb)
);
    
endmodule