----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2023 10:48:39
-- Design Name: 
-- Module Name: pwm - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        duty    : in  integer range 0 to 255;
        pwm_out : out STD_LOGIC
    );
end pwm;

architecture Behavioral of pwm is
    signal counter : integer range 0 to 255:= 0;
begin

    process (clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            pwm_out <= '0';
        elsif rising_edge(clk) then
            counter <= counter + 1;
            if counter < duty then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
    
end Behavioral;