module mux(
	input  wire  [1:0]   A, B, C, D, E,
	output reg   [1:0]	 F1, F2
);

always@(*) begin
	case(A)
		2'b00: F1 = B;
		2'b01: F1 = C;
		2'b10: F1 = D;
		2'b11: F1 = E;
	endcase
end

always@(*) begin
	if (A == 2'b00)
		F2 = B;
 	else if(A == 2'b01)
		F2 = C;
 	else if(A == 2'b10)
		F2 = D;
 	else
		F2 = E;
end


endmodule