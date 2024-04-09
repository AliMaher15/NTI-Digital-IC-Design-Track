library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc_instructions is
    generic (PER : integer := 1); 
    port (
        i_en   : in std_logic ;
        i_clk  : in  std_logic;
        i_rst  : in  std_logic;  
        o_controller_instruction_addr : out STD_LOGIC_VECTOR (2 downto 0)
        );
end pc_instructions;


architecture Behavioral of pc_instructions is

    signal instruction_counter : std_logic_vector(2 downto 0);
    constant period : integer := PER;
begin 

process (i_clk, i_rst)
    -- counter for the fpga
    variable count     : integer := 0;
    begin
        if (i_rst = '1') then
            instruction_counter <= "000";
            count := 0;
        elsif rising_edge(i_clk) then
            count := count+1;
            if(count=period) then
                count := 0;
                if(i_en= '1') then 
                  instruction_counter <= instruction_counter + '1' ; 
                end if ;       
            end if;
        end if;
end process;
o_controller_instruction_addr <= instruction_counter;

end Behavioral ; 