library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity johnson_counter is
    port (
        i_clk, i_rst  : in  std_logic;
        o_johns_count : out  std_logic_vector (3 downto 0)
    );
end johnson_counter;

architecture behavior1 of johnson_counter is
    signal D: std_logic_vector(3 downto 0):= "0001";
    constant period : integer := 1;
begin
    process(i_clk,i_rst)
        variable count : integer := 0;
        begin
        if (i_rst = '0') then
            D <= "0000";
            count := 0;
        elsif Rising_edge(i_clk) then
            count := count+1;
            if(count=period) then
                D(1) <= D(0);
                D(2) <= D(1);
                D(3) <= D(2);
                D(0) <= not D(3);
                count := 0;
            end if;     
        end if;
    end process;
o_johns_count <= D;

end behavior1;