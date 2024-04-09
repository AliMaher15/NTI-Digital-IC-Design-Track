library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux2to1 is
    generic (DWIDTH : integer := 2);
    port (
        i_selector: in std_logic ;
        i_data    : in  std_logic_vector((DWIDTH-1) downto 0);  
        o_databus : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0)
        );
end mux2to1 ;

architecture  Behavioral of mux2to1 is

begin 
    o_databus <= i_data when (i_selector = '1') else (others=>'Z') ; 
end Behavioral ;