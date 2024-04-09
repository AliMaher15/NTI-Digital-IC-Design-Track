library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fpga_mux is
    port (
        i_selector        : in  STD_LOGIC;
        i_operands        : in  STD_LOGIC_VECTOR(3 downto 0);  
        i_result_op       : in  STD_LOGIC_VECTOR(3 downto 0);
        o_data            : out STD_LOGIC_VECTOR(3 downto 0)
        );
end fpga_mux ;

architecture  Behavioral of fpga_mux is

begin 
    o_data <= i_operands when (i_selector = '1') else i_result_op ; 
end Behavioral ;