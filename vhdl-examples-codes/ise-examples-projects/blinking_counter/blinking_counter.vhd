library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity blinking_counter is
    port (
        clk, rst  : in  std_logic;
        Div_n     : out  std_logic
    );
end blinking_counter;

architecture behavior1 of blinking_counter is
    signal div_n_sig    : std_logic;
    begin
        process (clk, rst)
            variable count : integer := 0;
            constant n1    : integer := 12500000;
        begin
            if (rst='1') then
                div_n_sig <= '0';
					 count := 0;
            elsif rising_edge(clk) then
                count := count + 1;
                if (count=n1) then
                    div_n_sig <= not(div_n_sig);
                    count := 0;
                end if;
            end if;
        end process;
        Div_n <= div_n_sig;
 end behavior1;