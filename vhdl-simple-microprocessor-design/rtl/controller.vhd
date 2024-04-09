library IEEE;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controller is
   generic (PER : integer := 1;
            DWIDTH : integer := 2);
   port (
      i_clk, i_rst  : in   std_logic;

      -- Program Counter (instruction and Operand)
      o_pc_instr_en         : out STD_LOGIC;
      o_pc_operand_en       : out STD_LOGIC;

      -- instruction memory
      o_instrmem_data_in    : out STD_LOGIC_VECTOR (7 downto 0);
      -- operand memory
      o_opermem_data_in    : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
      o_write_enable       : out STD_LOGIC;

      -- Decoder
      i_decoder_instruction : in  STD_LOGIC_VECTOR (7 downto 0);
      
      -- Output Data
      o_operation        : out STD_LOGIC_VECTOR (7 downto 0);
      o_operand_1        : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
      o_operand_2        : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
      o_operation_result : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
      o_valid_result     : out STD_LOGIC;

      -- Data Bus
      i_data_bus : in STD_LOGIC_VECTOR  ((DWIDTH-1) downto 0);

      -- Accumelator
      o_accum_en1 : out STD_LOGIC;
      o_accum_en2 : out STD_LOGIC;

      -- data bus multiplexers
      o_enable_alu         : out STD_LOGIC;
      o_operand_mem_enable : out STD_LOGIC
   );
end controller;


architecture behavior of controller is

   type state_type is (s_initial, s_fetch_instruction, s_decode, s_check_instruction, s_fetch1, s_fetch2, s_execution); 
   signal state, next_state : state_type; 

   -- Program Counter (instruction and Operand)
   signal sig_pc_instr_en    : STD_LOGIC;
   signal sig_pc_operand_en  : STD_LOGIC;

   -- decoder internal signal to store number of operands
   signal sig_o_op_en  : STD_LOGIC;

   -- data bus multiplexers
   signal sig_operand_mem_enable : STD_LOGIC;
   signal sig_enable_alu         : STD_LOGIC;

   -- Output Data
   signal sig_op1_en        : STD_LOGIC;
   signal sig_op2_en        : STD_LOGIC;
   signal sig_o_operation_result : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
   signal sig_valid              : STD_LOGIC;

   -- Accumelator
   signal sig_accum_en1 : STD_LOGIC;
   signal sig_accum_en2 : STD_LOGIC;

   -- Memories
   signal sig_instrmem_data_in : STD_LOGIC_VECTOR (7 downto 0);
   signal sig_opermem_data_in  : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
   signal sig_write_enable     : STD_LOGIC;
   signal sig_address_counter  : std_logic_vector(2 downto 0); -- from 0 to 7

   constant period  : integer := PER;
   
  begin

-- next state sequential transition, registered output
   SYNC_PROC: process (i_clk, i_rst)
   variable count     : integer := 0;
   begin
      if (i_rst = '1') then
         count := 0;
         state <= s_initial;
         o_operand_1 <= (others=>'0');
         o_operand_2 <= (others=>'0');
         o_operation <= X"00";
         sig_instrmem_data_in    <= X"00";
         sig_opermem_data_in     <= (others=>'0');
         sig_address_counter     <= "000";
      elsif rising_edge(i_clk) then
         count := count+1;
         if(count=period) then
               count := 0;
               state <= next_state;
               if(sig_op1_en = '1') then
                  o_operand_1 <= i_data_bus;
               end if;
               if(sig_op2_en = '1') then
                  o_operand_2 <= i_data_bus;
               end if;
               if(sig_o_op_en = '1') then
                  o_operation <= i_decoder_instruction;
               end if;
               sig_address_counter  <= sig_address_counter + '1'; -- exit when 7
               if(sig_instrmem_data_in = X"02") then
                  sig_instrmem_data_in <= X"00";
               else 
                  sig_instrmem_data_in <= sig_instrmem_data_in + X"01";
               end if;
               sig_opermem_data_in  <= sig_opermem_data_in + '1';
         end if;
      end if;        
   end process;
 
-- output combinational logic
   OUTPUT_DECODE: process (state, i_data_bus)
   begin
   sig_enable_alu          <= '0';
   sig_o_operation_result  <= (others=>'0');
   sig_operand_mem_enable  <= '0';
   sig_pc_instr_en         <= '0';
   sig_pc_operand_en       <= '0';
   sig_o_op_en             <= '0';
   sig_accum_en1           <= '0';
   sig_accum_en2           <= '0';
   sig_valid               <= '0';
   sig_op1_en              <= '0';
   sig_op2_en              <= '0';
   sig_write_enable        <= '0';
   case (state) is
            -- STATE: INITIAL
            when s_initial =>
               sig_write_enable <= '1';
               sig_pc_instr_en <= '1';
               sig_pc_operand_en <= '1';
               

            -- STATE: FETCH INSTRUCTION
            when s_fetch_instruction =>
                sig_pc_instr_en <= '1';

            -- STATE: DECODE
            when s_decode =>   
               sig_o_op_en  <= '1';

            -- STATE: CHECK INSTRUCTION
            when s_check_instruction =>
               sig_o_op_en  <= '1';

            -- STATE: FETCH FIRST OPERAND
            when s_fetch1 =>
                sig_op1_en <= '1';
                sig_enable_alu  <= '0';
                sig_operand_mem_enable <= '1';
                sig_pc_operand_en <= '1';
                sig_accum_en1 <= '1';

            -- STATE: FETCH SECOND OPERAND
            when s_fetch2 =>
               sig_op2_en <= '1';
               sig_enable_alu  <= '0';
               sig_operand_mem_enable <= '1';
               sig_pc_operand_en <= '1';
               sig_accum_en2 <= '1';

            -- STATE: EXECUTE OPERATION
            when s_execution =>
               sig_enable_alu <= '1';
               sig_operand_mem_enable <= '0';
               sig_o_operation_result <= i_data_bus;
               sig_valid <= '1';
               
end case;
end process;
 
-- next state transition combinational logic
NEXT_STATE_DECODE: process (state, i_decoder_instruction, sig_address_counter)
begin
   next_state <= state;
   case (state) is
      -- STATE: INITIAL
      when s_initial =>
         if (sig_address_counter = "111") then
            next_state <= s_fetch_instruction;
         else
            next_state <= s_initial;
         end if;
         

      -- STATE: FETCH INSTRUCTION
      when s_fetch_instruction =>
         next_state <= s_decode;

      -- STATE: DECODE
      when s_decode =>
         next_state <= s_check_instruction;
      
      when s_check_instruction =>
         if(i_decoder_instruction = X"00") then -- NOP
            next_state <= s_execution;
         else
            next_state <= s_fetch1;
         end if;

      -- STATE: FETCH FIRST OPERAND
      when s_fetch1 =>
         if(i_decoder_instruction = X"02") then -- ADD
            next_state <= s_fetch2;
         else
            next_state <= s_execution;
         end if;

      -- STATE: FETCH SECOND OPERAND
      when s_fetch2 =>
         next_state <= s_execution;


      -- STATE: EXECUTE OPERATION
      when s_execution =>
         next_state <= s_fetch_instruction;

      when others =>
         next_state <= s_fetch_instruction;
end case;     
end process;

-- program counter
o_pc_instr_en   <= sig_pc_instr_en;
o_pc_operand_en <= sig_pc_operand_en;
-- output data
o_operation_result  <= sig_o_operation_result;
o_valid_result <= sig_valid;
-- multiplexers
o_operand_mem_enable <= sig_operand_mem_enable;
o_enable_alu         <= sig_enable_alu; 
-- accumelators
o_accum_en1 <= sig_accum_en1;
o_accum_en2 <= sig_accum_en2;
-- memories
o_write_enable <= sig_write_enable;
o_instrmem_data_in <= sig_instrmem_data_in;
o_opermem_data_in <= sig_opermem_data_in;


end behavior;