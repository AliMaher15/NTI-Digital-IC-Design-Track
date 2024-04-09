library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity and_gate is
    port (
        in1, in2  : in   std_logic;
        out1      : out  std_logic
    );
end and_gate;

architecture behavior1 of and_gate is
    begin
        out1 <= in1 and in2;
    end behavior1;