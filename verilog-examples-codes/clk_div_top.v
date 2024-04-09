module clk_div_top #(parameter N=1) (
    input  wire i_clk, rst_n,
    output wire o_clk
);

wire [N-1:0] middle_clk;

clk_div #(.N(N)) DIV1  (
    .i_clk(i_clk),
    .rst_n(rst_n),
    .o_clk(middle_clk)
);

clk_div #(.N(N)) DIV2  (
    .i_clk(middle_clk),
    .rst_n(rst_n),
    .o_clk(o_clk)
);

endmodule

module clk_div_top_tb();

    reg clk, rst_n;
    wire  o_clk;
 
`timescale 1ns/1ns

clk_div_top dut (
    .i_clk(clk),
    .rst_n(rst_n),
    .o_clk(o_clk)
);

always #5 clk = ~clk;

initial begin
    rst_n = 0;
    clk = 0;
    #15;
    rst_n = 1;
    #1000;
    $stop;
end

endmodule