library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter is
port (
  i_clk                       : in  std_logic;
  i_rst                       : in  std_logic;
  o_bcd                       : out std_logic_vector(3 downto 0));
end bcd_counter;

architecture rtl of bcd_counter is
signal r_count                 : unsigned(3 downto 0);
begin
o_bcd  <= std_logic_vector(r_count);
p_count : process(i_clk,i_rst)
begin
  if(i_rst='0') then
    r_count      <= (others=> '0');
  elsif(rising_edge(i_clk)) then
	if(r_count = 9) then
	  r_count      <= (others=> '0');
	else
	  r_count      <= r_count + 1;
	end if;
  end if;
end process p_count;
end rtl;