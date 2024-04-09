--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : counters_shared_bus.vhf
-- /___/   /\     Timestamp : 03/18/2024 12:06:48
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl D:/ali_maher/vhdl/ise_projects/counters_shared_bus/counters_shared_bus.vhf -w D:/ali_maher/vhdl/ise_projects/counters_shared_bus/counters_shared_bus.sch
--Design Name: counters_shared_bus
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

entity counters_shared_bus is
   port ( i_clk      : in    std_logic; 
          i_function : in    std_logic_vector (1 downto 0); 
          i_rst      : in    std_logic; 
          out_count  : out   std_logic_vector (3 downto 0));
end counters_shared_bus;

architecture BEHAVIORAL of counters_shared_bus is
   signal XLXN_1     : std_logic_vector (1 downto 0);
   signal XLXN_2     : std_logic_vector (3 downto 0);
   signal XLXN_3     : std_logic_vector (3 downto 0);
   signal XLXN_4     : std_logic_vector (3 downto 0);
   component bus_fsm
      port ( i_clk      : in    std_logic; 
             i_rst      : in    std_logic; 
             i_function : in    std_logic_vector (1 downto 0); 
             o_Sel2     : out   std_logic_vector (1 downto 0));
   end component;
   
   component johnson_counter
      port ( i_clk         : in    std_logic; 
             i_rst         : in    std_logic; 
             o_johns_count : out   std_logic_vector (3 downto 0));
   end component;
   
   component bcd_counter
      port ( i_clk : in    std_logic; 
             i_rst : in    std_logic; 
             o_bcd : out   std_logic_vector (3 downto 0));
   end component;
   
   component ring_counter
      port ( i_clk        : in    std_logic; 
             i_rst        : in    std_logic; 
             o_ring_count : out   std_logic_vector (3 downto 0));
   end component;
   
   component mux
      port ( i_johnson : in    std_logic_vector (3 downto 0); 
             i_ring    : in    std_logic_vector (3 downto 0); 
             i_bcd     : in    std_logic_vector (3 downto 0); 
             i_S2      : in    std_logic_vector (1 downto 0); 
             o_out4    : out   std_logic_vector (3 downto 0));
   end component;
   
begin
   XLXI_1 : bus_fsm
      port map (i_clk=>i_clk,
                i_function(1 downto 0)=>i_function(1 downto 0),
                i_rst=>i_rst,
                o_Sel2(1 downto 0)=>XLXN_1(1 downto 0));
   
   XLXI_2 : johnson_counter
      port map (i_clk=>i_clk,
                i_rst=>i_rst,
                o_johns_count(3 downto 0)=>XLXN_2(3 downto 0));
   
   XLXI_3 : bcd_counter
      port map (i_clk=>i_clk,
                i_rst=>i_rst,
                o_bcd(3 downto 0)=>XLXN_4(3 downto 0));
   
   XLXI_4 : ring_counter
      port map (i_clk=>i_clk,
                i_rst=>i_rst,
                o_ring_count(3 downto 0)=>XLXN_3(3 downto 0));
   
   XLXI_5 : mux
      port map (i_bcd(3 downto 0)=>XLXN_4(3 downto 0),
                i_johnson(3 downto 0)=>XLXN_2(3 downto 0),
                i_ring(3 downto 0)=>XLXN_3(3 downto 0),
                i_S2(1 downto 0)=>XLXN_1(1 downto 0),
                o_out4(3 downto 0)=>out_count(3 downto 0));
   
end BEHAVIORAL;


