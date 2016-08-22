---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : u2l
-- Design      : U2L
-- Author      : alan
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : d:\My_Designs\uLaw_conversion\u2l\src\u2l.vhd
-- Generated   : Tue Apr 15 21:20:09 2014
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
--{entity {u2l} architecture {u2l}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity u2l is
    port(
        Din : in STD_LOGIC_VECTOR(7 downto 0);
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        Qout : out STD_LOGIC_VECTOR(15 downto 0) := x"0000"
        );
end u2l;

--}} End of automatically maintained section

architecture u2l of u2l is
    signal segment : std_logic_vector(2 downto 0):="000";
    signal signBit : std_logic:='0';
    signal Areg    : std_logic_vector(5 downto 0):='1'&"0000"&'1';
    
begin
    signBit <= not Din(7);
    segment <= not Din(6 downto 4);
    Areg    <= '1' & (not Din(3 downto 0)) & '1';
    
    p1: process(clk)
        variable D1  : std_logic_vector(15 downto 0);
    begin
        if rising_edge(clk) then
            case segment is
                when "000" => D1 := "0000000000" & Areg     ;
                when "001" => D1 := "000000000" & Areg & "0";
                when "010" => D1 := "00000000" & Areg & "00";
                when "011" => D1 := "0000000" & Areg & "000";
                when "100" => D1 := "000000" & Areg & "0000";
                when "101" => D1 := "00000" & Areg & "00000";
                when "110" => D1 := "0000" & Areg & "000000";
                when "111" => D1 := "000" & Areg & "0000000";
                when others => null;
            end case;
            --
            if signBit = '0' then
                Qout <= D1 - 33;
            else
                Qout <= not (D1 - 34);
            end if;
            --
        end if;
    end process p1;
    
end u2l;
