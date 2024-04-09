library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity operand_memory is
    generic (PER : integer := 1;
             DWIDTH : integer := 2); 
    port (
        i_clk  : in  std_logic;
        i_rst  : in  std_logic;
        i_addr : in  std_logic_vector(2 downto 0);
        i_write_en : in std_logic;
        i_data_in  : in std_logic_vector((DWIDTH-1) downto 0);
        o_data : out std_logic_vector((DWIDTH-1) downto 0)
        );
end operand_memory;

architecture syn of operand_memory is
    type ram_type is array (0 to 7) of std_logic_vector ((DWIDTH-1) downto 0);             
    signal RAM : ram_type;                       

    constant period : integer := PER;
begin

    process (i_clk, i_rst)
    -- counter for the fpga
    variable count     : integer := 0;
    begin
        if (i_rst = '1') then
            count := 0;
        elsif rising_edge(i_clk) then
            count := count+1;
            if(count=period) then
                if(i_write_en = '1') then
                    count := 0;
                    RAM(conv_integer(i_addr)) <= i_data_in;
                end if;
            end if;
        end if;
    end process;

    o_data <= RAM(conv_integer(i_addr));

end syn;

				