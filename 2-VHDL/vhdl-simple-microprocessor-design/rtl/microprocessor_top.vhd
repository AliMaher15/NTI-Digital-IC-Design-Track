library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.mp_pkg.all ;

entity microprocessor_top is
    generic (PER : integer := 15000000;
             DWIDTH : integer := 2); 
    port (
            i_clk, i_rst       : in  STD_LOGIC;
            i_fpga_mux_sel     : in  STD_LOGIC;
            --o_operation        : out STD_LOGIC_VECTOR (7 downto 0);
            --o_operand_1        : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
            --o_operand_2        : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
            --o_operation_result : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
            o_valid_result     : out STD_LOGIC;
            o_fpga_mux_data    : out STD_LOGIC_VECTOR(3 downto 0)
        ) ;
end microprocessor_top;
    
architecture rtl of microprocessor_top is
    -- controller - PC
    signal sig_pc_cont_instr_en   : STD_LOGIC;
    signal sig_pc_cont_operand_en : STD_LOGIC;
    -- decoder to controller & alu
    signal  sig_dec_instr_out : STD_LOGIC_VECTOR (7 downto 0);
    -- data bus
    signal  sig_data_bus : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    -- controller - accumelator
    signal sig_cont_accum_en1 : STD_LOGIC;
    signal sig_cont_accum_en2 : STD_LOGIC;
    -- controller - multiplexers
    signal sig_alu_mux_en : STD_LOGIC;
    signal sig_mem_mux_en : STD_LOGIC;
    -- accumelator - alu
    signal sig_accum_alu_operand1 : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    signal sig_accum_alu_operand2 : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    -- alu - mux(2x1)
    signal sig_alu_data_mux : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    -- instruction memory - decoder 
    signal sig_instmem_dec : STD_LOGIC_VECTOR (7 downto 0);
    -- program counter - instruction memory
    signal sig_pc_instr_mem : STD_LOGIC_VECTOR (2 downto 0);
    -- operand memory - mux(2x1)
    signal sig_mem_data_mux : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    -- program counter - operand memory
    signal sig_pc_opera_mem : STD_LOGIC_VECTOR (2 downto 0);
    -- controller - instruction memory
    signal sig_instrmem_data_in : STD_LOGIC_VECTOR (7 downto 0);
    -- controller - operand memory
    signal sig_opermem_data_in : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    signal sig_write_enable : STD_LOGIC;
    -- FPGA MUX
    signal sig_operand_1    : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    signal sig_operand_2    : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    signal sig_result       : STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
    signal sig_operation    : STD_LOGIC_VECTOR (7 downto 0);
    -- concatanation
    signal sig_operands_concate  : STD_LOGIC_VECTOR  (3 downto 0);
    signal sig_result_op_concate : STD_LOGIC_VECTOR (3 downto 0);
begin

    process(sig_operand_1, sig_operand_2, sig_result, sig_operation)
    begin
      sig_operands_concate <=  (sig_operand_1 & sig_operand_2);
      sig_result_op_concate <= (sig_result   & sig_operation(1 downto 0)); 
    end process;

    -- CONTROLLER
    CONT0: controller
     GENERIC MAP (PER => PER,
                  DWIDTH => DWIDTH)
     PORT MAP (
        -- top
        i_clk => i_clk,
        i_rst => i_rst,
        -- Output Data
        o_operation        => sig_operation,
        o_operand_1        => sig_operand_1,
        o_operand_2        => sig_operand_2,
        o_operation_result => sig_result,
        o_valid_result     => o_valid_result,
        -- Program Counters (instruction and Operand)
        o_pc_instr_en   => sig_pc_cont_instr_en,
        o_pc_operand_en => sig_pc_cont_operand_en,
        -- instruction memory
        o_instrmem_data_in => sig_instrmem_data_in,
        -- operand memory
        o_opermem_data_in => sig_opermem_data_in,
        o_write_enable => sig_write_enable,
        -- Decoder
        i_decoder_instruction => sig_dec_instr_out,
        -- Data Bus
        i_data_bus => sig_data_bus,
        -- Accumelator
        o_accum_en1 => sig_cont_accum_en1,
        o_accum_en2 => sig_cont_accum_en2,
        -- data bus multiplexers
        o_enable_alu         => sig_alu_mux_en,
        o_operand_mem_enable => sig_mem_mux_en
      );
    
    -- ACCUMELATOR
    ACC1: accumelator 
      GENERIC MAP (PER => PER,
                   DWIDTH => DWIDTH)
      PORT MAP (
        i_clk      => i_clk,
        i_rst      => i_rst,
        i_selector => sig_cont_accum_en1,
        i_data_bus => sig_data_bus,
        o_alu      => sig_accum_alu_operand1
    );
    ACC2: accumelator 
      GENERIC MAP (PER => PER,
                   DWIDTH => DWIDTH)
      PORT MAP (
        i_clk      => i_clk,
        i_rst      => i_rst,
        i_selector => sig_cont_accum_en2,
        i_data_bus => sig_data_bus,
        o_alu      => sig_accum_alu_operand2
    );

    -- ALU
    ALU0: alu
      GENERIC MAP (DWIDTH => DWIDTH) 
      PORT MAP (
          i_1  => sig_accum_alu_operand1,
          i_2  => sig_accum_alu_operand2,
          i_op => sig_dec_instr_out,
          o_1  => sig_alu_data_mux
      );

    -- DECODER
    DEC0: decoder PORT MAP (
        i_instruction => sig_instmem_dec,
        o_data        => sig_dec_instr_out
    );

    -- INSTRUCTION MEMORY
    INS0: instruction_memory 
      GENERIC MAP (PER => PER)
      PORT MAP (
        i_clk  => i_clk,
        i_rst  => i_rst,
        i_addr => sig_pc_instr_mem,
        i_write_en => sig_write_enable,
        i_data_in =>  sig_instrmem_data_in,
        o_data => sig_instmem_dec
    );

    -- MUX (ALU)
    MUX0: mux2to1 
      GENERIC MAP (DWIDTH => DWIDTH)
      PORT MAP (
          i_selector => sig_alu_mux_en,
          i_data     => sig_alu_data_mux,  
          o_databus  => sig_data_bus
      );
    -- MUX (OPERAND MEMORY)
    MUX1: mux2to1 
      GENERIC MAP (DWIDTH => DWIDTH)
      PORT MAP (
          i_selector => sig_mem_mux_en,
          i_data     => sig_mem_data_mux,  
          o_databus  => sig_data_bus
      );

    -- OPERAND MEMORY
    OPER0: operand_memory
      GENERIC MAP (PER => PER,
                   DWIDTH => DWIDTH)
      PORT MAP (
        i_clk  => i_clk,
        i_rst  => i_rst,
        i_addr => sig_pc_opera_mem,
        i_write_en => sig_write_enable,
        i_data_in =>  sig_opermem_data_in,
        o_data => sig_mem_data_mux
    );

    -- PROGRAM COUNTER (INSTRUCTION)
    PC_INST0: pc_instructions
      GENERIC MAP (PER => PER)
      PORT MAP (
        i_clk  => i_clk,
        i_rst  => i_rst,    
        i_en   => sig_pc_cont_instr_en,
        o_controller_instruction_addr => sig_pc_instr_mem
    );

    -- PROGRAM COUNTER (OPERAND)
    PC_OPER0: pc_operand 
      GENERIC MAP (PER => PER)
      PORT MAP (
        i_clk  => i_clk,
        i_rst  => i_rst,    
        i_en   => sig_pc_cont_operand_en,
        o_controller_operand_addr => sig_pc_opera_mem
    );

    -- FPGA MUX
    FPGA_MUX0: fpga_mux
      PORT MAP (
        i_selector  => i_fpga_mux_sel,
        i_operands  => sig_operands_concate,
        i_result_op => sig_result_op_concate,
        o_data      => o_fpga_mux_data
      );
end rtl ;