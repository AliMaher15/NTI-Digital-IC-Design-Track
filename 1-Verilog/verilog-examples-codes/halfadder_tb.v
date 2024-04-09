`timescale 1ns/1ns 
module halfadder_tb (); 
 reg in1 ;
 reg in2 ; 
 wire sum ;
 wire carry  ;
 halfadder mostafa
(.in1(in1) , 
 .in2(in2),
 .sum(sum) ,
 .carry(carry) 
 ); 
initial 
begin 
in1 = 0  ; in2 =0  ;
#1 ;
in1 = 0  ; in2 =1  ;
#1 ;
in1 = 1  ; in2 =0  ;
#1 ;
in1 = 1  ; in2 =1  ;
#1;
#50;
 
 $stop;
end
endmodule 