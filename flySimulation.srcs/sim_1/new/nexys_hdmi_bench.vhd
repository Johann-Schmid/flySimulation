----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2018 12:30:15
-- Design Name: 
-- Module Name: nexys_hdmi_bench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nexys_hdmi_bench is
--  Port ( );
end nexys_hdmi_bench;

architecture Behavioral of nexys_hdmi_bench is

component nexys_hdmi is Port(
    CLK: in std_logic;
    hdmi_tx_clk_n: out std_logic;
    hdmi_tx_clk_p: out std_logic;
    hdmi_tx_n: out std_logic_vector (2 downto 0);
    hdmi_tx_p: out std_logic_vector (2 downto 0);
    LED: out std_logic_vector(7 downto 0);
    SW: in std_logic_vector (7 downto 0)
);
end component;

signal clk_in: std_logic:='0';

constant clk_in_half_period : time := 1 ns;

signal hdmi_clk_n, hdmi_clk_p: std_logic:= '0';

signal hdmi_n, hdmi_p: std_logic_vector (2 downto 0):= (others => '0');
signal sigLed: std_logic_vector(7 downto 0);
signal sw_in: std_logic_vector(7 downto 0):= (others => '0');

begin

uut: nexys_hdmi port map(
    clk => clk_in,
    hdmi_tx_clk_n => hdmi_clk_n,
    hdmi_tx_clk_p => hdmi_clk_p,
    hdmi_tx_n => hdmi_n,
    hdmi_tx_p => hdmi_p,
    LED => sigLed,
    SW => sw_in
);

clk_in <= not clk_in after clk_in_half_period;

sw_in <= "00001000";

end Behavioral;
