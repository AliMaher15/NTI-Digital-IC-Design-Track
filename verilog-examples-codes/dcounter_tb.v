`timescale 1ns/1ns

module dcounter_tb ();
 reg rst ;
 reg clk ; 
 wire [3:0] f ;


dcounter mostafa
(.rst(rst) , 
 .clk(clk),
 .f(f) 
 ); 
 
 initial 
 begin 
 clk = 0;
 #1 rst= 0 ;
 #10 rst= 1 ;
 
 #500;
 
 $stop;
 end 
 always #5 clk =~clk ; 
 endmodule 