----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2018 06:19:47 PM
-- Design Name: 
-- Module Name: Counter_2Bit - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_2Bit is
  Port ( clk: in STD_LOGIC; count: out STD_LOGIC_VECTOR (1 downto 0) );
end Counter_2Bit;

architecture Behavioral of Counter_2Bit is
  signal counter_temp: STD_LOGIC_VECTOR (1 downto 0) := "00";
begin
  process(clk)
  begin
    if(rising_edge(clk)) then
      counter_temp <= counter_temp + 1;
    end if;
  end process;
end Behavioral;
