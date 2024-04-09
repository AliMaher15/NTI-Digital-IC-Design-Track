module operators;
reg signed  [2:0] A,B,C,D;
reg  [5:0] E;

initial begin 
    A = 3'b010;
    B = 3'b101;
    C = 3'b100;

    if(A && B) // logical AND
        $display("logical true");

    if(A & B) // bitwise AND
        $display("bitwise true");
    
    $display("Logical Shift:");
    repeat(5) begin
        C = C >> 1;
        $display("C = %b", C);
    end
    C = 3'b100;
    $display("Arthimatic Shift:");
    repeat(5) begin
        C = C >>> 1; // must be signed type
        $display("C = %b", C);
    end

    A = 3'b111;
    B = 3'b101;
    $display("{A,B} = %b",{A,B});
    $display("{2{B}} = %b", {2{B}} ); 
    // {A{B}}, error, replication must be constant variable
    
end
endmodule