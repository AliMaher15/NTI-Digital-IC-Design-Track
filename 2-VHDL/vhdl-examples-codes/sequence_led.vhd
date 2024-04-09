library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity sequence_led is
    port (
        clk, rst  : in  std_logic;
        led_out   : out  std_logic_vector (2 downto 0)
    );
end sequence_led;

architecture behavior1 of sequence_led is
    signal led_out_sig  : std_logic_vector (2 downto 0);
    begin
        process (clk, rst)
            variable count : integer := 0;
            constant n1 : integer := 3300000;
            constant n2 : integer := 6600000;
            constant n3 : integer := 9900000;
        begin
            if (rst='1') then
                led_out_sig <= '0';
                count := 0;
            elsif rising_edge(clk) then
                count := count+1;
                if count=n1 then
                    led_out_sig(2) <= not (led_out_sig);
                end if;
                if count=n2 then
                    led_out_sig(1) <= not (led_out_sig);
                end if;
                if count=n3 then
                    led_out_sig(0) <= not (led_out_sig);
                end if;
            end if;
        end process;
        led_out <= led_out_sig;
    end behavior1;