library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity bus_fsm is
    port (
        i_clk, i_rst  : in   std_logic;
        i_function    : in   std_logic_vector (1 downto 0);
        o_Sel2        : out  std_logic_vector (1 downto 0)
    );
end bus_fsm;


architecture behavior of bus_fsm is

   type state_type is (s_john, s_ring, s_bcd); 
   signal state, next_state : state_type; 
   signal int_selector_out  : std_logic_vector(1 downto 0):= "00";
   constant period          : integer := 1;
   
  begin

-- next state sequential transition
   SYNC_PROC: process (i_clk, i_rst)
   variable count     : integer := 0;
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst = '0') then
            count := 0;
            state <= s_john;
            o_Sel2 <= "00";
         else
            count := count+1;
            if(count=period) then
                count := 0;
                state <= next_state;
                o_Sel2  <= int_selector_out;
            end if;
         end if;        
      end if;
   end process;
 
-- output combinational logic
   OUTPUT_DECODE: process (state)
   begin
      if state = s_john then
        int_selector_out <= "00";
      elsif state = s_ring then
        int_selector_out <= "01";
      elsif state = s_bcd then
        int_selector_out <= "10";
      else -- default
        int_selector_out <= "00";
      end if;
   end process;
 
-- next state combinational logic
   NEXT_STATE_DECODE: process (state, i_function)
   begin
      next_state <= state;
      case (state) is
         when others =>
            if (i_function="00") then
                  next_state <= s_john;
            elsif (i_function="01") then
                  next_state <= s_ring;
            elsif (i_function="10") then
                  next_state <= s_bcd;
            else
                  next_state <= s_john;
            end if;
      end case;      
   end process;
   
end behavior;