library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dflipflop is
    port (
        clk, rst: in  std_logic;
        in1     : in  std_logic;
        out1    : out std_logic
    );
end dflipflop;

architecture behavior1 of dflipflop is
    begin
        process (clk, rst, in1)
        begin
            if falling_edge(rst) then
                out1 <= '0';
            elsif rising_edge(clk) then
                out1 <= not out1;
            end if;
        end process;
    end behavior1;