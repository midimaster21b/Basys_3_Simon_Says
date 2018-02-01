----------------------------------------------------------------------------------
-- Company:
-- Engineer: Joshua Edgcombe
--
-- Create Date: 02/01/2018 04:03:00 PM
-- Design Name:
-- Module Name: SevenSegmentDecoder - Behavioral
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

entity SevenSegmentDecoder is
  Port ( Input_Char: in STD_LOGIC_VECTOR (2 downto 0); Output_Char: out STD_LOGIC_VECTOR (6 downto 0) );
end SevenSegmentDecoder;

architecture Behavioral of SevenSegmentDecoder is

begin
  process( Input_Char )
  begin
    case Input_Char is
      when "000" => Output_Char <= "0001000"; -- A
      when "001" => Output_Char <= "0000110"; -- E
      when "010" => Output_Char <= "1000000"; -- O
      when "011" => Output_Char <= "0011001"; -- Y
      when "100" => Output_Char <= "1000111"; -- L
      when "101" => Output_Char <= "0010010"; -- S
      when "110" => Output_Char <= "0010100"; -- !

      when others => Output_Char <= "1111111"; -- Nothing
    end case;
  end process;
end Behavioral;
