module latch_try (
    input wire a,
    output reg b,c
);

always@(*) begin
    // initial value??
    if(a)
        b = 1;
        c = 0;
    // else??
end

always@(*) begin
    // initial value??
    case(a)
      1: begin
        b = 1;
        // c??
      end 
    // default??
end


endmodule