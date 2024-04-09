module nonblocking(
    input  wire   A,B,clk,
    output reg    Q1,Q2
);

always @(posedge clk) begin
    Q1 <= A&B;
    Q2 <= Q1;
end


    
endmodule