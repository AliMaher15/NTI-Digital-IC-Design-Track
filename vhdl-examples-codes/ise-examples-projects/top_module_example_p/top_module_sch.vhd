--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : top_module_sch.vhf
-- /___/   /\     Timestamp : 03/18/2024 10:57:48
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl D:/ali_maher/vhdl/ise_projects/top_module_example_p/top_module_sch.vhf -w D:/ali_maher/vhdl/ise_projects/top_module_example_p/top_module_sch.sch
--Design Name: top_module_sch
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity top_module_sch is
   port ( in1  : in    std_logic; 
          in2  : in    std_logic; 
          out1 : out   std_logic);
end top_module_sch;

architecture BEHAVIORAL of top_module_sch is
   signal not_and_wire : std_logic;
   component and_gate
      port ( in1  : in    std_logic; 
             in2  : in    std_logic; 
             out1 : out   std_logic);
   end component;
   
   component not_gate
      port ( in1  : in    std_logic; 
             out1 : out   std_logic);
   end component;
   
begin
   XLXI_1 : and_gate
      port map (in1=>not_and_wire,
                in2=>in2,
                out1=>out1);
   
   XLXI_2 : not_gate
      port map (in1=>in1,
                out1=>not_and_wire);
   
end BEHAVIORAL;


