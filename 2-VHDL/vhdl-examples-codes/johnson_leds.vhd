library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity johnson_leds is
    port (
        clk, rst  : in  std_logic;
        Q         : out  std_logic_vector (3 downto 0)
    );
end johnson_leds;

architecture behavior1 of johnson_leds is
    signal D: std_logic_vector(3 downto 0):= "0001";
    constant period : integer := 1;
begin
    process(clk,rst)
        variable count : integer := 0;
        begin
        if (rst = '1') then
            D <= "0001";
            count := 0;
        elsif Rising_edge(clk) then
            count := count+1;
            if(count=period) then
                D(1) <= D(0);
                D(2) <= D(1);
                D(3) <= D(2);
                D(0) <= D(3);
                count := 0;
            end if;     
        end if;
    end process;
Q <= D;

end behavior1;