module clk_gating (
    input    wire  enable, clk,
    output   wire  clk_out
);

    reg latch_out;

    always@(*) begin
        if(!clk)
            latch_out = enable;
    end

    assign clk_out = (latch_out && clk); 

endmodule


module clk_gating_tb();

    `timescale 1ns/1ns

    reg   enable,clk;
    wire  clk_out;

    always #5 clk=~clk;

    clk_gating dut (
        .enable(enable),
        .clk(clk),
        .clk_out(clk_out)
    );

    initial begin
        clk = 0;
        enable = 1;
        #20;
        enable = 0;
        #30;
        enable = 1;
        #100;
        $stop();
    end

endmodule