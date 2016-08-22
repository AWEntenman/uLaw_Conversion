---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : ramp_gen
-- Design      : U2L
-- Author      : Alan W. Entenman
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : d:\My_Designs\uLaw_conversion\u2l\src\ramp_gen.vhd
-- Generated   : Tue Apr 15 21:04:00 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ramp_gen} architecture {ramp_gen}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity ramp_gen is
    port(
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        Qout : out STD_LOGIC_VECTOR(7 downto 0):= x"00";
        Qout_delayed : out STD_LOGIC_VECTOR(7 downto 0):= x"00"
        );
end ramp_gen;

--}} End of automatically maintained section

architecture ramp_gen of ramp_gen is
    signal ramp : std_logic_vector(7 downto 0):= x"00";
    
begin
    Qout <= ramp;
    p1: process(clr, clk)
    begin
        if clr/='0' then
            ramp <= x"00";
            Qout_delayed <= x"00";
        elsif rising_edge(clk) then
            ramp <= ramp + 1;
            Qout_delayed <= ramp;
        end if;
    end process;
    
end ramp_gen;
