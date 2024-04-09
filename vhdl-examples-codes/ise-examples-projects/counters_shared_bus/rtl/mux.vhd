library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity mux is
    Port (
           -- 4 input / output buffer with one enable
           i_johnson  : in  STD_LOGIC_VECTOR (3 downto 0);
           i_ring     : in  STD_LOGIC_VECTOR (3 downto 0);
           i_bcd      : in  STD_LOGIC_VECTOR (3 downto 0);
           i_S2       : in  STD_LOGIC_VECTOR (1 downto 0);
           o_out4     : out STD_LOGIC_VECTOR (3 downto 0)
        );
end mux;

architecture Behavioral of mux is
begin
    process(i_S2, i_johnson, i_ring, i_bcd)
    begin
        case (i_S2) is
            when "00" =>
                o_out4 <= i_johnson;
            when "01" =>
                o_out4 <= i_ring;
            when "10" =>
                o_out4 <= i_bcd;
            when others =>
                o_out4 <= i_johnson;
        end case;
    end process;
end Behavioral;