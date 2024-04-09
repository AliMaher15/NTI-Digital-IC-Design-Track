library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity alu is
    generic (DWIDTH : integer := 2);
    Port (
           i_1      : in  STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
           i_2      : in  STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
           i_op     : in  STD_LOGIC_VECTOR (7 downto 0);
           o_1      : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0)
        );
end alu;

architecture Behavioral of alu is
begin
    with i_op select
        o_1 <= i_1 + i_2  when X"02", -- Add
        i_1 + '1'  when X"01", -- Increment
        (others=>'X')     when others ;
end Behavioral;