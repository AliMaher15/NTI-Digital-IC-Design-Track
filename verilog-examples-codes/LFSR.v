module LFSR ( 
input clk , rst ,
output reg [3:0] out  ) ; 
always@(posedge clk , negedge rst ) 
begin 
if ( rst==0  ) 
out =  4'b0110 ; 

else 
 out = { (out[2:0] ),(out[2] ^ out[3]) } ;

end 
endmodule 
