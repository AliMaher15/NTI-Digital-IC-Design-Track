`timescale 1ns/1ns

module alu_tb ();
 reg a ;
 reg b ; 
 reg [3:0]op ; 
  
 wire [3:0] out ;


alu mostafa
( 
 .a(a),
 .b(b) , 
 .op(op),
 .out(out) 
 ); 
 
 initial 
 begin 
 a = 0 ;
 b = 0 ; 
 op = 3'b000 ; 
 #10  ;
  a = 0 ;
 b = 0 ; 
 op = 3'b001 ; 
 #10  ;
  a = 0 ;
 b = 1 ; 
 op = 3'b010 ; 
 #10  ;
 a = 0 ;
 b = 1 ; 
 op = 3'b011 ; 
 #10  ;
 a = 1 ;
 b = 0 ; 
 op = 3'b100 ; 
 #10  ;
 a = 1 ;
 b = 0 ; 
 op = 3'b101 ; 
 #10  ;
 a = 1 ;
 b = 1 ; 
 op = 3'b110 ; 
 #10  ;
 end 

 endmodule 