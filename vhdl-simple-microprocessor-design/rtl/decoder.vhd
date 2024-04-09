library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity decoder is
    Port (
           i_instruction : in  STD_LOGIC_VECTOR (7 downto 0);
           o_data        : out STD_LOGIC_VECTOR (7 downto 0)
        );
end decoder;

architecture Behavioral of decoder is
begin
    process(i_instruction)
    begin
        case i_instruction is
            when X"00" => o_data <= X"00";
            when X"01" => o_data <= X"01";
            when X"02" => o_data <= X"02"; 
            when others => o_data <= X"00"; 
        end case;
    end process;
end Behavioral;