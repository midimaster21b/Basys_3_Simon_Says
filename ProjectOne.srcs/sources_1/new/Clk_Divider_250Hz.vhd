----------------------------------------------------------------------------------
-- Company:
-- Engineer: Joshua Edgcombe
--
-- Create Date: 01/25/2018 04:41:31 PM
-- Design Name:
-- Module Name: Clk_Divider_250Hz - Behavioral
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

entity Clk_Divider_250Hz is
    Port ( clk_in : in STD_LOGIC; div_clk : out STD_LOGIC );
end Clk_Divider_250Hz;

architecture Behavioral of Clk_Divider_250Hz is

-- Seven segment clock divider variable
signal Counter: STD_LOGIC_VECTOR (19 downto 0) := "00000000000000000000";
signal Peak:    STD_LOGIC_VECTOR (19 downto 0) := "01100001101010000000"; -- 400,000 => 250 Hz
signal Output:  STD_LOGIC := '0';

begin
ClkDivider: process(clk_in)
  begin
    if rising_edge(clk_in) then
      Counter <= Counter + 1;

      if Counter = Peak then
        Counter <= "00000000000000000000";
        Output <= not(Output);
      end if;

      div_clk <= Output;

    end if;
  end process;
end Behavioral;
