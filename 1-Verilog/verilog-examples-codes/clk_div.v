module clk_div #(parameter N=1) (
    input  wire i_clk,rst_n,
    output wire o_div_clk
);

integer i;

reg [N-1:0] r_clk;

always@(posedge i_clk or negedge rst_n) begin
    if(!rst_n) begin
        r_clk <= 0;
    end else begin
        r_clk[0] <= !r_clk[N-1];
        for (i=1; i<N; i=i+1) begin
            r_clk[i] <= r_clk[i-1];
        end
    end
end
assign o_div_clk = r_clk[N-1];
endmodule

module clk_div_tb();

    reg clk, rst_n;
    wire o_div_clk;
 
`timescale 1ns/1ns

clk_div dut (
    .i_clk(clk),
    .rst_n(rst_n),
    .o_div_clk(o_div_clk)
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