module fulladder ( 
input a,b,cin,
output sum , cout ) ; 
wire s1 , c1 , c2 ;
 halfadder halfadd 
 (.in1(a) , 
 .in2(b),
 .sum(s1),
 .carry(c1) 
 ); 
 halfadder halfaddd 
 (.in1(s1) , 
 .in2(cin),
 .sum(sum),
 .carry(c2) 
 ); 
 assign cout= c2 |  c1 ; 
 endmodule 