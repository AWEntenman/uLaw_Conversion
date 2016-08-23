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
<<<<<<< HEAD
-- File        : D:\My_Designs\uLaw_Conversion\u2l\compile\Extra_TB.vhd
-- Generated   : Tue Aug 23 16:13:43 2016
-- From        : D:\My_Designs\uLaw_Conversion\u2l\src\Extra_TB.bde
=======
-- File        : C:\temp\uLaw_Conversion\u2l\compile\Extra_TB.vhd
-- Generated   : Tue Aug 23 10:33:32 2016
-- From        : C:\temp\uLaw_Conversion\u2l\src\Extra_TB.bde
>>>>>>> be4079397d7f3b41c99179c103d8fbf23c310b89
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
