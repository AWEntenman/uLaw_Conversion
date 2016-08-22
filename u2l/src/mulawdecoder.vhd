---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
---------------------------------------------------------------------------------------------------
--
-- Title       : MuLawDecoder
-- Design      : U2L
-- Author      : Alan W. Entenman
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : D:\My_Designs\uLaw_conversion\u2l\src\MuLawDecoder.vhd
-- Generated   : Thu Jun 26 17:37:18 2008
-- From        : interface description file
--
-------------------------------------------------------------------------------
--
-- Description : 
--    Input G.711 uLaw signal and output 16-bit linear 2's complement data.
--Data is pipelined for 1 clock delay (i.e. latency is 1 clock.)
--

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity MuLawDecoder is
    port (
        clr                : in std_logic;
        clk            : in std_logic;-- 24.576 Mhz
        MuLaw_Audio        : in std_logic_vector(7 downto 0);  ---- ulaw audio input
        Linear_Audio    : out std_logic_vector(15 downto 0):=x"0000"  ---- linear audio output
        );
end MuLawDecoder;  -- entity

Architecture RTL of MuLawDecoder is
begin
    Decoder : process (Clr, clk)
        variable Segment: std_logic_vector(2 downto 0);
        variable Step: std_logic_vector(3 downto 0);
        variable SignBit    : std_logic;
        variable InA    : std_logic_vector(15 downto 0);
    begin
        if (Clr /= '0') then
            Linear_Audio <= (others => '0');
        elsif Rising_Edge(clk) then
            --partition MuLaw_Audio into G.711 defined parts
            Step := not MuLaw_Audio(3 downto 0);
            Segment := not MuLAW_AUDIO(6 downto 4);
            SignBit := not MuLaw_Audio(7);
            --convert the uLaw input to absolute value linear code
            case Segment is
            when "000" => InA := (b"0000_0000_000"& Step &  b"0");
            when "001" => InA := (b"0000_0000_00"& Step &  b"00") + 33;
            when "010" => InA := (b"0000_0000_0"& Step &  b"000") + 99;
            when "011" => InA := (b"0000_0000" & Step &  b"0000") + 231;
            when "100" => InA := (b"0000_000" & Step & b"0_0000") + 495;
            when "101" => InA := (b"0000_00" & Step & b"00_0000") + 1023;
            when "110" => InA := (b"0000_0" & Step & b"000_0000") + 2079;
            when others=> InA := (b"0000"  & Step & b"0000_0000") + 4191;
            end case;
            --set the sign
            if SignBit='1' then
                --neg number, 2's complement
                Linear_Audio <= (not InA) + 1;
            else
                Linear_Audio <= InA;
            end if;
        end if;
    end process Decoder;
    
end RTL;
