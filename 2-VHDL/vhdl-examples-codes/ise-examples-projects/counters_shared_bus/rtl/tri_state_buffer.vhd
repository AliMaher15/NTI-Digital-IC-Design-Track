library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tri_state_buffer is
    Port ( A    : in  STD_LOGIC;    -- single buffer input
           EN   : in  STD_LOGIC;    -- single buffer enable
           Y    : out STD_LOGIC;    -- single buffer output
           -- 4 input / output buffer with one enable
           IN4  : in  STD_LOGIC_VECTOR (3 downto 0);
           EN4  : in  STD_LOGIC;
           OUT4 : out STD_LOGIC_VECTOR (3 downto 0));
end tri_state_buffer;

architecture Behavioral of tri_state_buffer is

begin

    -- single active low enabled tri-state buffer
    Y <= A when (EN = '0') else 'Z';
    
    -- 4 input/output active low enabled tri-state buffer
    OUT4 <= IN4 when (EN4 = '0') else "ZZZZ";

end Behavioral;