---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
---------------------------------------------------------------------------------------------------
--
-- Title       : ulaw_encoder
-- Design      : U2L
-- Author      : Alan W. Entenman
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : D:\My_Designs\uLaw_conversion\u2l\src\ulaw_encoder.vhd
-- Generated   : Thu Jun 26 17:37:18 2008
-- From        : interface description file
--
-------------------------------------------------------------------------------
--
-- Description : 
--
--    Convert linear 16-bit 2's complement data into uLaw audio according to CCITT G.711.
--Clipping occurs if the absolute input exceeds the virtual decision level of 8159.

--Asserting CE when Done = '1' starts a conversion which may take from 1 to 8 
--clock times to complete.
--Conversion is complete when Done = '1'.
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity uLaw_encoder is
    port(
        ce           : in STD_LOGIC;---- linear to ulaw conversion enable signal
        clk          : in STD_LOGIC;---- system clock
        Din : in STD_LOGIC_VECTOR(15 downto 0); ---- linear audio data input
        Done : out STD_LOGIC := '0'; ---- linear to ulaw conversion done
        uLaw : out STD_LOGIC_VECTOR(7 downto 0) := x"ff" ---- ulaw data output
        );
end uLaw_encoder;

architecture RTL of uLaw_Encoder is
    signal TC      : std_logic:='0';
    signal SignBit : std_logic:='1';
    signal Segment : std_logic_vector(2 downto 0):="000";
    signal Areg    : std_logic_vector(15 downto 0):=x"0000";
    
begin
    uLaw <= (not SignBit) & (not Segment) & Areg(4 downto 1);
    Done <= not TC;
    
    p1: process(clk)
    --8-clock efficient design
    begin
        if rising_edge(clk) then
            if TC='0' then
                if ce='1' then
                    TC <= '1';
                    if Din(15)='1' then
                        Areg <= Din;
                    else
                        Areg <= (not Din) + 1;
                    end if;
                    SignBit <= Din(15);
                    Segment <= "000";
                end if;
            else
                if Areg>-31 then
                    TC <= '0';
                    Areg <= Areg + x"001e";--30
                elsif Areg>-95 then
                    TC <= '0';
                    Segment <= Segment + 1;
                    Areg <= SXT(Areg(15 downto 1),16) + x"002f";--47;
                elsif Segment=6 then
                    Segment <= Segment + 1;
                    Areg <= x"0020";
                    TC <= '0';
                else
                    Segment <= Segment + 1;
                    Areg <= SXT(Areg(15 downto 1),16) + x"0011";--17
                end if;
            end if;
        end if;
    end process;
    
end RTL;
