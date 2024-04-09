module hard_sort_reset (
    input wire hard_rst, soft_rst, clk, D,
    output reg Q
);

always @(posedge clk or negedge hard_rst) begin
    if (!hard_rst) begin
        Q <= 0;
    end else if(!soft_rst) begin
        Q <= 0;
    end else
        Q <= D;
end

endmodule

/*module hard_sort_reset_tb();



endmodule*/