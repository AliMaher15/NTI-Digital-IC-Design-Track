`timescale 10ns/1ns 
module fulladder_tb (); 
 reg a ;
 reg b ; 
 reg cin ; 
 wire sum ;
 wire cout  ;
 reg s1 ;
 reg c1 ; 
 reg c2 ; 
 fulladder mostafa
(.a(a) , 
 .b(b),
 .cin(cin) , 
 .sum(sum) ,
 .cout(cout) 
 ); 
initial 
begin 
a = 0  ; b =0  ; cin = 0 ;
#1 ;
a = 0  ; b =0  ; cin = 1 ;
#1 ;
a = 0  ; b =1  ; cin = 0 ;
#1 ;
a = 0  ; b =1  ; cin = 1 ;
#1 ;
a = 1  ; b =0  ; cin = 0 ;
#1 ;
a = 1  ; b =0  ; cin = 1 ;
#1 ;
a = 1  ; b =1 ; cin = 0 ;
#1 ;
a = 1 ; b =1  ; cin = 1 ;
#1 ;

end
endmodule 