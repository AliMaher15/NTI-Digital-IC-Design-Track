module alu ( 
input  a,b,
input [3:0] op ,
 
output  reg [3:0] out );
always@( * ) 
begin 
if ( op == 3'b000 ) 
out = 0 ;
else if ( op == 3'b001) 
out = a+b ; 
else if ( op == 3'b010) 
out = a-b ;
else if ( op == 3'b011) 
out = a&b ;
else if ( op == 3'b100) 
out = a|b ;
else if ( op == 3'b101) 
out = ~a ;
else if ( op == 3'b110) 
out = ~b ;
end 
endmodule