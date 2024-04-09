library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity not_gate is
    port (
        in1  : in   std_logic;
        out1 : out  std_logic
    );
end not_gate;

architecture behavior1 of not_gate is
    begin
        out1 <= not in1;
    end behavior1;