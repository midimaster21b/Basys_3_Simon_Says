----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Joshua Edgcombe
-- 
-- Create Date: 01/18/2018 07:22:49 PM
-- Design Name: 
-- Module Name: SevenSegmentDriver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SevenSegmentDriver is
    Port ( SevenSegmentOut : out STD_LOGIC_VECTOR (6 downto 0);
           SevenSegmentSelector : out STD_LOGIC_VECTOR (3 downto 0);
           SevenSegmentClk : in STD_LOGIC;
           SevenSegmentState : in STD_LOGIC);
end SevenSegmentDriver;

architecture Behavioral of SevenSegmentDriver is

-- Seven segment clock divider variable
signal SevenSegmentDiv: STD_LOGIC_VECTOR (19 downto 0)     := "00000000000000000000";
signal SevenSegmentDivPeak: STD_LOGIC_VECTOR (19 downto 0) := "01100001101010000000"; -- 400,000 => 250 Hz

-- Seven segment mode (Yay or Lose)
signal SevenSegmentSwitch: STD_LOGIC;

-- Seven segment selector
signal SevenSegmentMuxValue: STD_LOGIC_VECTOR (3 downto 0) := "1110"; -- Initialize to 1

begin
  

  ClkDivider: process(SevenSegmentClk)
  begin
    if rising_edge(SevenSegmentClk) then
      SevenSegmentDiv <= SevenSegmentDiv + 1;
      
      if SevenSegmentDiv = SevenSegmentDivPeak then
            SevenSegmentDiv <= "00000000000000000000";
            
            SevenSegmentOut <= "1111111"; -- Clear output pins
            
            -- Extremely inefficient attempt to logically rotate mux bits...
            if SevenSegmentMuxValue = "1110" then
              SevenSegmentMuxValue <= "1101";
            elsif SevenSegmentMuxValue = "1101" then
              SevenSegmentMuxValue <= "1011";
            elsif SevenSegmentMuxValue = "1011" then
              SevenSegmentMuxValue <= "0111";
            elsif SevenSegmentMuxValue = "0111" then
              SevenSegmentMuxValue <= "1110";
            else
              SevenSegmentMuxValue <= "1110";
            end if;
            
            SevenSegmentSelector <= SevenSegmentMuxValue;
            
            if SevenSegmentState = '1' then
              -- SevenSegmentOut <= "1111001"; -- One
              if SevenSegmentMuxValue = "0111" then
                SevenSegmentOut <= "0011001"; -- Y
              elsif SevenSegmentMuxValue = "1011" then
                SevenSegmentOut <= "0001000"; -- A
              elsif SevenSegmentMuxValue = "1101" then
                SevenSegmentOut <= "0011001"; -- Y
              elsif SevenSegmentMuxValue = "1110" then
                SevenSegmentOut <= "0010100"; -- !
              else
                SevenSegmentOut <= "1111111"; -- nothing
              end if;
            else
              -- SevenSegmentOut <= "1000000"; -- Zero
              if SevenSegmentMuxValue = "0111" then
                SevenSegmentOut <= "1000111"; -- L
              elsif SevenSegmentMuxValue = "1011" then
                SevenSegmentOut <= "1000000"; -- O
              elsif SevenSegmentMuxValue = "1101" then
                SevenSegmentOut <= "0010010"; -- S
              elsif SevenSegmentMuxValue = "1110" then
                SevenSegmentOut <= "0000110"; -- E
              else
                SevenSegmentOut <= "1111111"; -- nothing
              end if;
            end if;
            
            
          end if;
    end if;
  end process;
  
--  Counter: process(SevenSegmentDiv)
--  begin
--    if SevenSegmentDiv = SevenSegmentDivPeak then
--      SevenSegmentDiv <= "00000000000000000000";
      
--      if SevenSegmentMuxValue = "1000" then
--        SevenSegmentMuxValue <= "0001";
--      else
--        SevenSegmentMuxValue <= SevenSegmentMuxValue + SevenSegmentMuxValue; -- Double/Shift to left...
--      end if;
      
--      if SevenSegmentState = '1' then
--        SevenSegmentOut <= "1111001"; -- One
--      else
--        SevenSegmentOut <= "1000000"; -- Zero
--      end if;
      
--      SevenSegmentSelector <= SevenSegmentMuxValue;
--    end if;
--  end process;
end Behavioral;
