---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : Extra_TB
-- Design      : u2l
-- Author      : alan
-- Company     : Cosecom
--
-------------------------------------------------------------------------------
--
-- File        : d:\My_Designs\uLaw_Conversion\u2l\compile\Extra_TB.vhd
-- Generated   : Mon Aug 22 16:31:37 2016
-- From        : d:\My_Designs\uLaw_Conversion\u2l\src\Extra_TB.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;


entity Extra_TB is
  port(
       clk : out STD_LOGIC;
       clr : out STD_LOGIC
  );
end Extra_TB;

architecture Extra_TB of Extra_TB is

---- Component declarations -----

component clk_module_01
  port (
       clk : out STD_LOGIC := '1';
       clr : out STD_LOGIC := '1'
  );
end component;

begin

----  Component instantiations  ----

U1 : clk_module_01
  port map(
       clk => clk,
       clr => clr
  );


end Extra_TB;
