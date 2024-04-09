library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity e74ls138 is  
    port (  --name     : in/out, "type" std_logic/std_logic_vector 
            mode        : in  std_logic_vector (2 downto 0);
            E           : in  std_logic_vector (2 downto 0);
            Y           : out std_logic_vector (7 downto 0)
          );
end e74ls138;
-- one entity can have multiple arhitectures

-- arch   arch_name   entity_name
architecture rtl of e74ls138 is
    signal mode_not : std_logic_vector(2 downto 0);
    signal E_and    : std_logic;
begin
    mode_not(0) <= not mode(0);
    mode_not(1) <= not mode(1);
    mode_not(2) <= not mode(2);
    E_and     <= (not E(2)) and (not E(1)) and E(0);
    Y(0)      <= not (mode_not(0)   and mode_not(1)   and mode_not(2)   and E_and);
    Y(1)      <= not (mode(0)       and mode_not(1)   and mode_not(2)   and E_and);
    Y(2)      <= not (mode_not(0)   and mode(1)       and mode_not(2)   and E_and);
    Y(3)      <= not (mode(0)       and mode(1)       and mode_not(2)   and E_and);
    Y(4)      <= not (mode_not(0)   and mode_not(1)   and mode(2)       and E_and);
    Y(5)      <= not (mode(0)       and mode_not(1)   and mode(2)       and E_and);
    Y(6)      <= not (mode_not(0)   and mode(1)       and mode(2)       and E_and);
    Y(7)      <= not (mode(0)       and mode(1)       and mode(2)       and E_and);
end architecture rtl;


