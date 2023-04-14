----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2023 09:44:10
-- Design Name: 
-- Module Name: rxByteUart - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rxByteUart is
    Generic (
        TIMEOUT_THRESHOLD : integer := 40000000 -- Timeout threshold in clock cycles
    );
    Port (
        clk: in  STD_LOGIC;
        rst: in  STD_LOGIC;
        uart_start_out: in  STD_LOGIC;
        uart_byte_out: in std_logic_vector(7 downto 0);
        si_rotate_screen_uart : out STD_LOGIC_VECTOR(1 downto 0);
        uart_vid_Data: out STD_LOGIC_VECTOR(23 downto 0):= (others => '1');
        uart_integer_rotate_speed: out integer range 0 to 255;
        uart_integer_pwm_speed: out integer range 0 to 255;
        uart_mem_offset: out integer range 0 to 4095;
        uart_on_off: out std_logic:= '0';
        timeout_flag: out std_logic
    );
end rxByteUart;

architecture Behavioral of rxByteUart is

    signal si_state_uart : integer range 0 to 7 := 0;
    signal si_uart_byte: integer range 0 to 255:= 0;
    signal pwmPin: std_logic:='0';
    signal si_value_pixel: integer range -2048 to 2047:= 0;
    signal uart_sig_sign: std_logic:='0';
    signal signal_rotation_speed: std_logic:= '0';
    signal signal_pwm_speed: std_logic:= '0';
    signal timeout_counter: integer range 0 to 40000000:= 0;
    signal uart_on_off_buffer: std_logic := '0';
    
begin

    process (clk, rst)
    begin
        if rst = '1' then

        elsif rising_edge(clk) then
            if (uart_start_out = '1') and (si_state_uart = 0) then
                si_uart_byte <= to_integer(unsigned(uart_byte_out));
                timeout_counter <= 0;
                si_state_uart <= 1;
            else
            end if;
            
            if (si_state_uart = 1) and (signal_rotation_speed = '0') and (signal_pwm_speed = '0') then
                case si_uart_byte is
                    when 16#73# =>
                        si_rotate_screen_uart <= "00";
                        signal_rotation_speed <= '1';
                        si_state_uart <= 3;
                        -- ASCII 's'
                    when 16#6C# =>
                        si_rotate_screen_uart <= "10";
                        signal_rotation_speed <= '1';
                        si_state_uart <= 3;
                        -- ASCII 'l'
                    when 16#72# =>
                        si_rotate_screen_uart <= "01";
                        signal_rotation_speed <= '1';
                        si_state_uart <= 3;
                        -- ASCII 'r'
                    when 16#42# =>
                        uart_vid_Data <= x"00FF00";
                        si_state_uart <= 2;
                        -- ASCII 'B'
                    when 16#44# => 
                        uart_vid_Data <= x"00FFFF";
                        si_state_uart <= 2;
                        -- ASCII 'D'
                    when 16#47# =>
                        uart_vid_Data <= x"0000FF";
                        si_state_uart <= 2;
                        -- ASCII 'G'
                    when 16#57# =>
                        uart_vid_Data <= (others => '1');
                        si_state_uart <= 2;
                        -- ASCII 'W'
                    when 16#53# =>
                        uart_on_off <= not uart_on_off_buffer;
                        si_state_uart <= 2;
                        -- ASCII 'S'
                    when 16#4C# =>
                        pwmPin <= pwmPin xor '1';  
                        signal_pwm_speed <= '1'; 
                        si_state_uart <= 3;
                        -- ASCII 'L'
                    when 16#31# =>
                        uart_mem_offset <= 0;
                        si_state_uart <= 2;
                        -- ASCII '1'
            --            si_value_pixel <= 0;
                    when 16#32# =>
                        uart_mem_offset <= 600;
                        si_state_uart <= 2;
                        -- ASCII '2'
            --            si_value_pixel <= 0;
                    when 16#33# =>
                        uart_mem_offset <= 1200;
                        si_value_pixel <= 0;
                        si_state_uart <= 2;
                        -- ASCII '3'
                    when 16#34# =>
                        uart_mem_offset <= 1800;
                        si_value_pixel <= 0;
                        si_state_uart <= 2;
                        -- ASCII '4'
                    when 16#2D# =>
                        uart_sig_sign <= '1';
                        si_state_uart <= 2;
                        -- ASCII '-'
                    when 16#2B# =>
                        uart_sig_sign <= '0';
                        si_state_uart <= 2;
                        -- ASCII '+'
--                    when 16#3C# =>
--                        si_state_uart <= 2;
--                        signal_rotation_speed <= '1';
--                        uart_integer_rotate_speed <= integer_rotate_speed - 1;
--                        -- ASCII '<'
--                    when 16#3E# =>
--                        si_state_uart <= 3;
--                        signal_pwm_speed <= '1';
--                        uart_integer_rotate_speed <= integer_rotate_speed + 1;
--                        -- ASCII '>'
                    when others =>
                        uart_mem_offset <= 0;
                        si_state_uart <= 2;    
                end case;
            else
            end if;
            
            if (si_state_uart = 1) and ((signal_rotation_speed = '1') or (signal_pwm_speed = '1')) then
            if signal_rotation_speed = '1' then
                    uart_integer_rotate_speed <= si_uart_byte;
                elsif signal_pwm_speed = '1' then
                    uart_integer_pwm_speed <= si_uart_byte;
                else
                end If;
                si_state_uart <= 2;
            end if;
            
            if (si_state_uart = 2) then
                si_uart_byte <= 0;
                signal_rotation_speed <= '0';
                signal_pwm_speed <= '0';
                si_state_uart <= 0;
            else
            end if;
            
            if (si_state_uart = 3) then
                si_uart_byte <= 0;
                si_state_uart <= 0;
            else
            end if;

            -- Timeout counter
--            if timeout_counter < TIMEOUT_THRESHOLD and (si_state_uart = 0) and ((signal_rotation_speed = '1') or (signal_pwm_speed = '1')) then
--                timeout_counter <= timeout_counter + 1;
--                timeout_flag <= '0';
--            elsif timeout_counter >= TIMEOUT_THRESHOLD then
--                timeout_flag <= '1';
--                signal_rotation_speed <= '0';
--                signal_pwm_speed <= '0';
--            else
--                timeout_flag <= '0';
--            end if;            
        end if;
        
    end process;
--##################################### UART Rx#################################################




end Behavioral;
