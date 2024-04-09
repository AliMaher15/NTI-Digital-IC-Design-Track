module rst_sync#(parameter N = 4) (
    input  wire rst,clk,
    output wire sync_rst
);

    reg [N-1:0] sync_rst_r;

    always@(posedge clk or negedge rst) begin
        if (!rst) begin
            sync_rst_r <= 0;
        end else begin
            sync_rst_r <= {sync_rst_r[N-2:0],1'b1};
        end
    end

    assign sync_rst = sync_rst_r[N-1];

endmodule