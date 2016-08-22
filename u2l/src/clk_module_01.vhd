---------------------------------------------------------------------------------------------------
--
-- Copyright (c) 2000-2005 by Cosecom Inc, All rights reserved.
--
-------------------------------------------------------------------------------
--
-- Title       : clk_module_01
-- Design      : U2L
-- Author      : Alan W. Entenman
-- Company     : Cosecom Inc
--
-------------------------------------------------------------------------------
--
-- File        : D:\My_Designs\uLaw_conversion\u2l\src\clk_module_01.vhd
-- Generated   : Thu Jan 16 08:00:00 2014
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
--{entity {clk_module_01} architecture {clk_module_01}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clk_module_01 is
    port(
        clr : out STD_LOGIC := '1';
        clk : out STD_LOGIC := '1'
        );
end clk_module_01;

--}} End of automatically maintained section

architecture clk_module_01 of clk_module_01 is
    signal mr : std_logic := '1';
    signal ck : std_logic := '1';
    constant t0 : time := 10172 ps;
    constant t1 : time := 10173 ps;
    
begin
--    ck <= not ck after 10167.37 ps; -- -0.05 % slow
    ck <= '1' after t0 when ck='0' else '0' after t1; -- 0.0 % accurate
--    ck <= '1' when clr='1' else not ck after 10.178 ns; -- +0.05 % fast
    
    clk <= ck;
    mr <= '0' after 3 ns;
    clr <= mr;
    
    
end clk_module_01;
