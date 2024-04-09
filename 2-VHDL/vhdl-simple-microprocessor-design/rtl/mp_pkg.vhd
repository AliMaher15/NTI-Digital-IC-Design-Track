library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

package mp_pkg is
    -- ACCUMELATOR
    component accumelator
        generic (PER : integer := 1;
                 DWIDTH : integer := 2);
        port (
            i_clk      : in STD_LOGIC ;
            i_rst      : in STD_LOGIC ;
            i_selector : in STD_LOGIC ;
            i_data_bus : in  STD_LOGIC_VECTOR((DWIDTH-1) downto 0);  
            o_alu      : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0)
            );
    end component;

    -- ALU
    component alu is
        generic (DWIDTH : integer := 2);
        Port (
               i_1      : in  STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
               i_2      : in  STD_LOGIC_VECTOR ((DWIDTH-1) downto 0);
               i_op     : in  STD_LOGIC_VECTOR (7 downto 0);
               o_1      : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0)
            );
    end component;

    -- CONTROLLER
    component controller is
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
    end component;

    -- DECODER
    component decoder is
        Port (
               i_instruction : in  STD_LOGIC_VECTOR (7 downto 0);
               o_data        : out STD_LOGIC_VECTOR (7 downto 0)
            );
    end component;

    -- INSTRUCTION MEMORY
    component instruction_memory is
        generic (PER : integer := 1);
        port (i_clk  : in  std_logic;
              i_rst  : in  std_logic;
              i_addr : in  std_logic_vector(2 downto 0);
              i_write_en : in std_logic;
              i_data_in  : in std_logic_vector(7 downto 0);
              o_data : out std_logic_vector(7 downto 0)
            );
    end component;

    -- MUX 2x1
    component mux2to1 is
        generic (DWIDTH : integer := 2);
        port (
            i_selector: in std_logic ;
            i_data    : in  std_logic_vector((DWIDTH-1) downto 0);  
            o_databus : out STD_LOGIC_VECTOR ((DWIDTH-1) downto 0)
            );
    end component;

    -- OPERAND MEMORY
    component operand_memory is
        generic (PER : integer := 1;
                 DWIDTH : integer := 2);
        port (i_clk  : in  std_logic;
              i_rst  : in  std_logic;
              i_addr : in  std_logic_vector(2 downto 0);
              i_write_en : in std_logic;
              i_data_in  : in std_logic_vector((DWIDTH-1) downto 0);
              o_data : out std_logic_vector((DWIDTH-1) downto 0)
            );
    end component;

    -- INSTRUCTION PROGRAM COUNTER
    component pc_instructions is
        generic (PER : integer := 1);
        port (i_en   : in std_logic ;
              i_clk  : in  std_logic;
              i_rst  : in  std_logic;  
              o_controller_instruction_addr : out STD_LOGIC_VECTOR (2 downto 0)
            );
    end component;

    -- OPERAND PROGRAM COUNTER
    component pc_operand is
        generic (PER : integer := 1);
        port (i_en : in std_logic ;
              i_clk  : in  std_logic;
              i_rst  : in  std_logic;  
              o_controller_operand_addr : out STD_LOGIC_VECTOR (2 downto 0)
            );
    end component;

    -- FPGA MUX
    component fpga_mux is
    port (
        i_selector        : in  STD_LOGIC;
        i_operands        : in  STD_LOGIC_VECTOR(3 downto 0);  
        i_result_op       : in  STD_LOGIC_VECTOR(3 downto 0);
        o_data            : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component ;

end mp_pkg ;