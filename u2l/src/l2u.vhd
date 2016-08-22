---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : l2u
-- Design      : U2L
-- Author      : alan
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : D:\My_Designs\uLaw_conversion\u2l\src\l2u.vhd
-- Generated   : Sun Mar 30 11:58:29 2014
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
--{entity {l2u} architecture {l2u}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity l2u is
    port(
        Din : in std_logic_vector(15 downto 0);
        clk : in STD_LOGIC;
        uLaw : out std_logic_vector(7 downto 0) := x"ff"
        );
end l2u;

--}} End of automatically maintained section

architecture l2u of l2u is
    signal Segment : std_logic_vector(2 downto 0):="000";
    signal SignBit : std_logic:='0';
    signal nDin    : std_logic_vector(15 downto 0):=(others => '0');
    signal D1, D2  : std_logic_vector(15 downto 0):=(others => '0');
    signal Areg    : std_logic_vector(3 downto 0):="0000";
    
begin
    uLaw <= SignBit & Segment & Areg;
    -- round 16 bit audio down to 14 bits, toward zero
    D1 <= (Din + "10") when Din(15)='1' else (Din + "01");
    D2 <= SXT(D1(15 downto 2),16);
    nDin <= D2 - 34 when D2(15)='1' else (not D2) - 33;
    
    p1: process(clk)
    begin
        if rising_edge(clk) then
            SignBit <= not Din(15);
            if nDin(15 downto 13)/="111" then
                Segment <= "000";
                Areg <= "0000";
            elsif nDin(12)='0' then
                Segment <= "000";
                Areg <= nDin(11 downto 8);
            elsif nDin(11)='0' then
                Segment <= "001";
                Areg <= nDin(10 downto 7);
            elsif nDin(10)='0' then
                Segment <= "010";
                Areg <= nDin( 9 downto 6);
            elsif nDin( 9)='0' then
                Segment <= "011";
                Areg <= nDin( 8 downto 5);
            elsif nDin( 8)='0' then
                Segment <= "100";
                Areg <= nDin( 7 downto 4);
            elsif nDin( 7)='0' then
                Segment <= "101";
                Areg <= nDin( 6 downto 3);
            elsif nDin( 6)='0' then
                Segment <= "110";
                Areg <= nDin( 5 downto 2);
            else
                Segment <= "111";
                Areg <= nDin( 4 downto 1);
            end if;
        end if;
    end process p1;
    
end l2u;
