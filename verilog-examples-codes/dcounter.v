module dcounter(
    input rst,clk,
	 output reg [3:0] f 
	 );
	 
always@(posedge clk,negedge rst) 
begin
if ( rst ==0)  
f<=16; 
else 
f <= f-1 ;
end

endmodule