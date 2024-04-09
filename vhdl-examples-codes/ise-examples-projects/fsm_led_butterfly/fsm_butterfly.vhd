library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

entity fsm_led is
    port (
        clk, rst  : in   std_logic;
        Q         : out  std_logic_vector (5 downto 0)
    );
end fsm_led;


architecture behavior1 of fsm_led is

   type state_type is (S0, S1, S2, S3, S4); 
   signal state, next_state : state_type; 
   signal led_out : std_logic_vector(5 downto 0):= "100001";
   constant period : integer := 10000000;
   
  begin

--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (clk, rst)
   variable count     : integer := 0;
   begin
      if (clk'event and clk = '1') then
         if (rst = '1') then
            count := 0;
            state <= S0;
            Q <= "100001";
         else
            count := count+1;
            if(count=period) then
                count := 0;
                state <= next_state;
                Q <= led_out;
            end if;
         end if;        
      end if;
   end process;
 
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      if state = S0 then
        led_out <= "100001";
      elsif state = S1 then
        led_out <= "010010";
      elsif state = S2 then
        led_out <= "001100";
      elsif state = S3 then
        led_out <= "010010";
      elsif state = S4 then
        led_out <= "100001";
      else
        led_out <= "100001";
      end if;
   end process;
 
   NEXT_STATE_DECODE: process (clk,rst, state)
   begin
      next_state <= state;
      case (state) is
         when S0 =>
               next_state <= S1;
         when S1 =>
               next_state <= S2;
         when S2 =>
                next_state <= S3;
         when S3 =>
               next_state <= S4;
        when S4 =>
               next_state <= S0;
         when others =>
            next_state <= S0;
      end case;      
   end process;
   
end behavior1;