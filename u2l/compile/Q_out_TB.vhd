---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : u2l
-- Author      : alan
-- Company     : Cosecom
--
-------------------------------------------------------------------------------
--
<<<<<<< HEAD
-- File        : D:\My_Designs\uLaw_Conversion\u2l\compile\Q_out_TB.vhd
-- Generated   : Tue Aug 23 16:13:43 2016
-- From        : D:\My_Designs\uLaw_Conversion\u2l\src\Q_out_TB.bde
=======
-- File        : C:\temp\uLaw_Conversion\u2l\compile\Q_out_TB.vhd
-- Generated   : Tue Aug 23 10:33:33 2016
-- From        : C:\temp\uLaw_Conversion\u2l\src\Q_out_TB.bde
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


use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity Q_out_TB is
  port(
       Qout : out STD_LOGIC_VECTOR(7 downto 0);
       Qout_delayed : out STD_LOGIC_VECTOR(7 downto 0)
  );
end Q_out_TB;

architecture Q_out_TB of Q_out_TB is

---- Component declarations -----

component clk_module_01
  port (
       clk : out STD_LOGIC := '1';
       clr : out STD_LOGIC := '1'
  );
end component;
component ramp_gen
  port (
       clk : in STD_LOGIC;
       clr : in STD_LOGIC;
       Qout : out STD_LOGIC_VECTOR(7 downto 0) := x"00";
       Qout_delayed : out STD_LOGIC_VECTOR(7 downto 0) := x"00"
  );
end component;

---- Signal declarations used on the diagram ----

signal NET27 : STD_LOGIC;
signal NET31 : STD_LOGIC;

begin

----  Component instantiations  ----

U1 : ramp_gen
  port map(
       Qout => Qout,
       Qout_delayed => Qout_delayed,
       clk => NET31,
       clr => NET27
  );

U2 : clk_module_01
  port map(
       clk => NET31,
       clr => NET27
  );


end Q_out_TB;
