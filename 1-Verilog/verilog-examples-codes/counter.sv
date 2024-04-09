module counter(
    input   wire         clk, rst,
    output  reg   [3:0]  count
);

always @(posedge clk or negedge rst) begin
    if (!rst)
        count <= 0;
    else if(count != 4'b1111)
        count <= count + 1;
    else 
        count <= 0;
end
    
endmodule