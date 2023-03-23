----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.03.2023 11:05:03
-- Design Name: 
-- Module Name: clockDivider - Behavioral
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

entity clockDivider is
    Generic (
        DIV_FACTOR : integer := 25
    );
    Port (
        clk_in  : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end clockDivider;

architecture Behavioral of clockDivider is
    signal counter : integer := 0;
    signal clk_int : STD_LOGIC := '0';
begin
    process (clk_in, rst)
    begin
        if rst = '1' then
            counter <= 0;
            clk_int <= '0';
        elsif rising_edge(clk_in) then
            counter <= counter + 1;
            if counter = DIV_FACTOR - 1 then
                counter <= 0;
                clk_int <= NOT clk_int;
            end if;
        end if;
    end process;

    clk_out <= clk_int;

end Behavioral;

