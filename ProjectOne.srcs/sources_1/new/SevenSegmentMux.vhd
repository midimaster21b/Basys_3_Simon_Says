----------------------------------------------------------------------------------
-- Company:
-- Engineer: Joshua Edgcombe
--
-- Create Date: 02/01/2018 04:44:27 PM
-- Design Name:
-- Module Name: SevenSegmentMux - Behavioral
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

entity SevenSegmentMux is
Port (
  MuxClk: in STD_LOGIC;
  DisplayMuxIn: in STD_LOGIC_VECTOR (1 downto 0);
  CharMuxIn: in STD_LOGIC_VECTOR (11 downto 0);
  DisplayMuxOut: out STD_LOGIC_VECTOR (3 downto 0);
  CharMuxOut: out STD_LOGIC_VECTOR (2 downto 0)
);
end SevenSegmentMux;

architecture Behavioral of SevenSegmentMux is

begin

  process(MuxClk)
  begin

  case DisplayMuxIn is
    when "00" =>
      DisplayMuxOut <= "1110";
      CharMuxOut    <= CharMuxIn(2 downto 0);

    when "01" =>
      DisplayMuxOut <= "1101";
      CharMuxOut    <= CharMuxIn(5 downto 3);

    when "10" =>
      DisplayMuxOut <= "1011";
      CharMuxOut    <= CharMuxIn(8 downto 6);

    when "11" =>
      DisplayMuxOut <= "0111";
      CharMuxOut    <= CharMuxIn(11 downto 9);

    when others =>
      DisplayMuxOut <= "1111";
      CharMuxOut    <= "111";
  end case;

  end process;
end Behavioral;
