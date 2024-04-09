library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity half_adder is  
    port (  --name     : in/out, "type" std_logic/std_logic_vector 
            A,B        : in  std_logic_vector(1 downto 0);
            SUM, CARRY : out std_logic_vector(1 downto 0)
          );
end half_adder;
-- std_logic_vector (7 downto 0) (0 to 7)


-- arch   arch_name   entity_name
architecture rtl of half_adder is
begin
  SUM   <= A xor B;
  CARRY <= A and B;
end architecture rtl;