library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity leds_left_right is
    port (
        clk, rst  : in  std_logic;
        Q         : out  std_logic_vector (3 downto 0)
    );
end leds_left_right;

architecture behavior1 of leds_left_right is
    signal D: std_logic_vector(3 downto 0):= "0001";
    constant period : integer := 10000000;
begin
    process(clk,rst)
        variable count     : integer := 0;
        variable direction : integer := 1;
        begin
        if (rst = '1') then
            D <= "0001";
            count := 0;
            direction := 0;
        elsif Rising_edge(clk) then
            count := count+1;    
				if(count=period) then
					direction := direction+1; 
				end if; 
            if(count=period) and (direction >= 1) and (direction < 4) then
                D(1) <= D(0);
                D(2) <= D(1);
                D(3) <= D(2);
                D(0) <= D(3);
                count := 0;
            elsif(count=period) and (direction >= 4) and (direction < 7) then
                D(2) <= D(3);
                D(1) <= D(2);
                D(0) <= D(1);
                D(3) <= D(0);
                count := 0;
            end if; 
            if (count=period) and (direction = 7) then
                direction := 0;
                count := 0;
                D <= "0001";
            end if;
        end if;
    end process;
Q <= D;

end behavior1;