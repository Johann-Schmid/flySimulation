-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Mon Mar 13 13:52:24 2023
-- Host        : PC1012002888 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/flyHDMI/flyHDMI2v4/flyHDMI2v4.runs/xadc_wiz_0_synth_1/xadc_wiz_0_stub.vhdl
-- Design      : xadc_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tsbg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xadc_wiz_0 is
  Port ( 
    daddr_in : in STD_LOGIC_VECTOR ( 6 downto 0 );
    dclk_in : in STD_LOGIC;
    den_in : in STD_LOGIC;
    di_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    dwe_in : in STD_LOGIC;
    reset_in : in STD_LOGIC;
    vauxp1 : in STD_LOGIC;
    vauxn1 : in STD_LOGIC;
    busy_out : out STD_LOGIC;
    channel_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    do_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drdy_out : out STD_LOGIC;
    eoc_out : out STD_LOGIC;
    eos_out : out STD_LOGIC;
    alarm_out : out STD_LOGIC;
    vp_in : in STD_LOGIC;
    vn_in : in STD_LOGIC
  );

end xadc_wiz_0;

architecture stub of xadc_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "daddr_in[6:0],dclk_in,den_in,di_in[15:0],dwe_in,reset_in,vauxp1,vauxn1,busy_out,channel_out[4:0],do_out[15:0],drdy_out,eoc_out,eos_out,alarm_out,vp_in,vn_in";
begin
end;
