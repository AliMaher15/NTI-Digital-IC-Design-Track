`timescale 10ns/1ns

module LFSR_tb ();
 reg rst ;
 reg clk ; 
 wire [3:0] out ;


LFSR mostafa
(.rst(rst) , 
 .clk(clk),
 .out(out) 
 ); 
 
 initial 
 begin 
rst= 0 ;
 #10 rst= 1 ;
 
 #500;
 
 $stop;
 end 
  always #5 clk =~clk ; 
 endmodule