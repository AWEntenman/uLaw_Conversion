---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : fast_encoder
-- Design      : U2L
-- Author      : alan
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : D:\My_Designs\uLaw_conversion\u2l\src\fast_encoder.vhd
-- Generated   : Fri Mar 28 12:53:18 2014
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
--{entity {fast_encoder} architecture {fast_encoder}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity fast_encoder is
    port(
        Din : in std_logic_vector(15 downto 0);
        ce : in std_logic;
        clk : in STD_LOGIC;
        uLaw : out std_logic_vector(7 downto 0) := x"ff";
        dv : out std_logic := '0'
        );
end fast_encoder;

--}} End of automatically maintained section

architecture fast_encoder of fast_encoder is
    signal f0,f1,f2,f3,f4,f5,f6,f7 : integer range 0 to 1 := 0;
    signal sum_f : integer := 0;
    signal Segment : std_logic_vector(2 downto 0):="000";
    signal SignBit : std_logic:='1';
    signal nDin    : std_logic_vector(15 downto 0):=x"0000";
    signal Areg    : std_logic_vector(15 downto 0):=x"0000";
    
begin
    uLaw <= (not SignBit) & (not Segment) & Areg(4 downto 1);
    
    nDin <= Din when Din(15)='1' else (not Din) + 1;
    f0 <= 1 when nDin < -8158 else 0;
    f1 <= 1 when nDin < -4062 else 0;
    f2 <= 1 when nDin < -2014 else 0;
    f3 <= 1 when nDin <  -990 else 0;
    f4 <= 1 when nDin <  -478 else 0;
    f5 <= 1 when nDin <  -222 else 0;
    f6 <= 1 when nDin <   -94 else 0;
    f7 <= 1 when nDin <   -30 else 0;
    sum_f <= f0+f1+f2+f3+f4+f5+f6+f7;
    
    p1: process(clk)
        variable Bregv : std_logic_vector(15 downto 0);
    begin
        if rising_edge(clk) then
            dv <= '0';
            if ce='1' then
                SignBit <= Din(15);
                dv <= '1';
                case sum_f is
                    when 0 =>
                        Segment <= "000";
                        Areg <= nDin + 30;
                    --
                    when 1 =>
                        Segment <= "001";
                        Bregv := nDin+ 94;
                        Areg <= SXT(Bregv(15 downto 1),16);
                    --
                    when 2 =>
                        Segment <= "010";
                        Bregv := nDin+ 222;
                        Areg <= SXT(Bregv(15 downto 2),16);
                    --
                    when 3 =>
                        Segment <= "011";
                        Bregv := nDin+ 478;
                        Areg <= SXT(Bregv(15 downto 3),16);
                    --
                    when 4 =>
                        Segment <= "100";
                        Bregv := nDin+ 990;
                        Areg <= SXT(Bregv(15 downto 4),16);
                    --
                    when 5 =>
                        Segment <= "101";
                        Bregv := nDin+ 2014;
                        Areg <= SXT(Bregv(15 downto 5),16);
                    --
                    when 6 =>
                        Segment <= "110";
                        Bregv := nDin+ 4062;
                        Areg <= SXT(Bregv(15 downto 6),16);
                    --
                    when 7 =>
                        Segment <= "111";
                        Bregv := nDin+ 8158;
                        Areg <= SXT(Bregv(15 downto 7),16);
                    --
                    when 8 =>
                        Segment <= "111";
                        Areg <= x"0000";
                    --
                    when others => null;
                end case;
            end if;
        end if;
    end process p1;
    
end fast_encoder;
