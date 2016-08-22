---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : uLaw Test
-- Design      : u2l
-- Author      : Alan W. Entenman
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : d:\My_Designs\uLaw_Conversion\u2l\compile\l2u_TB.vhd
-- Generated   : Mon Aug 22 16:24:25 2016
-- From        : d:\My_Designs\uLaw_Conversion\u2l\src\l2u_TB.bde
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

entity l2u_TB is
  port(
       Done : out STD_LOGIC;
       dv : out STD_LOGIC;
       Qout_delayed : out STD_LOGIC_VECTOR(7 downto 0);
       error : out STD_LOGIC_VECTOR(15 downto 0) := x"0000";
       u4_uLaw : out STD_LOGIC_VECTOR(7 downto 0);
       u5_uLaw : out STD_LOGIC_VECTOR(7 downto 0);
       u6_uLaw : out STD_LOGIC_VECTOR(7 downto 0)
  );
end l2u_TB;

architecture l2u_TB of l2u_TB is

---- Component declarations -----

component clk_module_01
  port (
       clk : out STD_LOGIC := '1';
       clr : out STD_LOGIC := '1'
  );
end component;
component fast_encoder
  port (
       Din : in STD_LOGIC_VECTOR(15 downto 0);
       ce : in STD_LOGIC;
       clk : in STD_LOGIC;
       dv : out STD_LOGIC := '0';
       uLaw : out STD_LOGIC_VECTOR(7 downto 0) := x"ff"
  );
end component;
component l2u
  port (
       Din : in STD_LOGIC_VECTOR(15 downto 0);
       clk : in STD_LOGIC;
       uLaw : out STD_LOGIC_VECTOR(7 downto 0) := x"ff"
  );
end component;
component MuLawDecoder
  port (
       MuLaw_Audio : in STD_LOGIC_VECTOR(7 downto 0);
       clk : in STD_LOGIC;
       clr : in STD_LOGIC;
       Linear_Audio : out STD_LOGIC_VECTOR(15 downto 0) := x"0000"
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
component u2l
  port (
       Din : in STD_LOGIC_VECTOR(7 downto 0);
       clk : in STD_LOGIC;
       clr : in STD_LOGIC;
       Qout : out STD_LOGIC_VECTOR(15 downto 0) := x"0000"
  );
end component;
component uLaw_encoder
  port (
       Din : in STD_LOGIC_VECTOR(15 downto 0);
       ce : in STD_LOGIC;
       clk : in STD_LOGIC;
       Done : out STD_LOGIC := '0';
       uLaw : out STD_LOGIC_VECTOR(7 downto 0) := x"ff"
  );
end component;

----     Constants     -----
constant VCC_CONSTANT   : STD_LOGIC := '1';

---- Signal declarations used on the diagram ----

signal clk : STD_LOGIC;
signal clr : STD_LOGIC;
signal VCC : STD_LOGIC := '1';
signal Linear_Audio : STD_LOGIC_VECTOR(15 downto 0);
signal Linear_Out : STD_LOGIC_VECTOR(15 downto 0);
signal Linear_Ramp : STD_LOGIC_VECTOR(7 downto 0) := x"00";

begin

---- User Signal Assignments ----
error<=Linear_Audio xor Linear_Out;


----  Component instantiations  ----

UUT : u2l
  port map(
       Din => Linear_Ramp,
       Qout => Linear_Out,
       clk => clk,
       clr => clr
  );

u1_clk_module : clk_module_01
  port map(
       clk => clk,
       clr => clr
  );

u2_ramp_gen : ramp_gen
  port map(
       Qout => Linear_Ramp,
       Qout_delayed => Qout_delayed,
       clk => clk,
       clr => clr
  );

u3_uLawDecoder : MuLawDecoder
  port map(
       Linear_Audio => Linear_Audio,
       MuLaw_Audio => Linear_Ramp,
       clk => clk,
       clr => clr
  );

u4_fast_encoder : fast_encoder
  port map(
       Din => Linear_Out,
       ce => VCC,
       clk => clk,
       dv => dv,
       uLaw => u4_uLaw
  );

u5_uLaw_encoder : uLaw_encoder
  port map(
       Din => Linear_Out,
       Done => Done,
       ce => VCC,
       clk => clk,
       uLaw => u5_uLaw
  );

u6_l2u : l2u
  port map(
       Din => Linear_Out,
       clk => clk,
       uLaw => u6_uLaw
  );


---- Power , ground assignment ----

VCC <= VCC_CONSTANT;

end l2u_TB;
