library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity accumelator is
    generic (PER : integer := 1;
             DWIDTH : integer := 2);
    port (
        i_clk      : in STD_LOGIC ;
        i_rst      : in STD_LOGIC ;
        i_selector : in STD_LOGIC ;
        i_data_bus : in  STD_LOGIC_VECTOR((DWIDTH-1) downto 0);  
        o_alu      : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0)
        );
end accumelator ;

architecture  Behavioral of accumelator is
    constant period : integer := PER;
begin
process (i_clk, i_rst)
    -- counter for the fpga
    variable count     : integer := 0;
begin
    if (i_rst = '1') then
        o_alu <=  (OTHERS => '0');
        count := 0;
    elsif rising_edge(i_clk) then 
        count := count+1;
        if(count=period) then
            count := 0;
            if (i_selector = '1') then 
                o_alu  <= i_data_bus ; 
            end if ; 
        end if; 
    end if ;
end process ; 
end Behavioral ;