----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2018 04:58:59 PM
-- Design Name: 
-- Module Name: SevenSegment_tb - Behavioral
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
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity SevenSegment_tb is
end SevenSegment_tb;

architecture Behavioral of SevenSegment_tb is

component SevenSegmentDecoder
  Port ( Input_Char: in STD_LOGIC_VECTOR (2 downto 0); Output_Char: out STD_LOGIC_VECTOR (6 downto 0) );
end component;

  signal char_in: STD_LOGIC_VECTOR (2 downto 0);
  signal char_out: STD_LOGIC_VECTOR (6 downto 0);

  PROCEDURE monitor(ExpectedValue: in STD_LOGIC_VECTOR (6 downto 0 ) ) is
  variable line_out: line;
  begin
    write(line_out, NOW, right, 10, ns);
    write(line_out, string'(" Value --> Seven Segment Output"));

    write(line_out, string'(" Expected -->"));
    write(line_out, ExpectedValue);

    write(line_out, string'(" Received -->"));
    write(line_out, char_out);

    WRITELINE(OUTPUT, line_out);
    ASSERT char_out = ExpectedValue REPORT "Test Failed: Incorrect character selected at output" SEVERITY FAILURE;
  end monitor;
  
  begin
   M1: SevenSegmentDecoder PORT MAP ( char_in, char_out );

  stim_proc: process
  begin
    wait for 100 ns;
    REPORT "Beginning the Seven Segment Decoder test" SEVERITY NOTE;

    REPORT "Testing the letter A" SEVERITY NOTE;
    char_in <= "000";
    wait for 10 ns;
    monitor("0001000"); -- A

    REPORT "Testing the letter E" SEVERITY NOTE;
    char_in <= "001";
    wait for 10 ns;
    monitor("0000110"); -- E

    REPORT "Testing the letter O" SEVERITY NOTE;
    char_in <= "010";
    wait for 10 ns;
    monitor("1000000"); -- O

    REPORT "Testing the letter Y" SEVERITY NOTE;
    char_in <= "011";
    wait for 10 ns;
    monitor("0011001"); -- Y

    REPORT "Testing the letter L" SEVERITY NOTE;
    char_in <= "100";
    wait for 10 ns;
    monitor("1000111"); -- L

    REPORT "Testing the letter S" SEVERITY NOTE;
    char_in <= "101";
    wait for 10 ns;
    monitor("0010010"); -- S

    REPORT "Testing the character !" SEVERITY NOTE;
    char_in <= "110";
    wait for 10 ns;
    monitor("0010100"); -- !

    REPORT "Testing the blank character" SEVERITY NOTE;
    char_in <= "111";
    wait for 10 ns;
    monitor("1111111"); -- Nothing

    REPORT "Testing finished successfully." SEVERITY NOTE;
    wait;
  end process;
end Behavioral;
