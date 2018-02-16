----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2018 06:08:12 PM
-- Design Name: 
-- Module Name: game_logic_tb - Behavioral
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

entity game_logic_tb is
end game_logic_tb;

architecture Behavioral of game_logic_tb is

component SimonSaysGameLogic
  Port (
    signal rst, BtnOne, BtnTwo, BtnThree, BtnFour, GameClk, LedClk, BtnClk : in STD_LOGIC := '0'; 
    signal LedOne, LedTwo, LedThree : out STD_LOGIC;
    signal CharOut : out STD_LOGIC_VECTOR (11 downto 0)
  );
end component;

  signal char_out: STD_LOGIC_VECTOR (11 downto 0);
  signal reset, BtnOne, BtnTwo, BtnThree, BtnFour, GameClk, LedClk, BtnClk, LedOne, LedTwo, LedThree : STD_LOGIC;

  PROCEDURE monitor(ExpectedValue: in STD_LOGIC_VECTOR (11 downto 0 ) ) is
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
   M1: SimonSaysGameLogic
    Port Map (
      rst => reset, 
      BtnOne => BtnOne, 
      BtnTwo => BtnTwo, 
      BtnThree => BtnThree, 
      BtnFour => BtnFour, 
      GameClk => GameClk, 
      LedClk => LedClk, 
      BtnClk => BtnClk, 
      LedOne => LedOne,
      LedTwo => LedTwo, 
      LedThree => LedThree,
      CharOut => char_out
    );
  stim_proc: process
  begin
    wait for 100 ns;
    REPORT "Beginning the Game Logic test" SEVERITY NOTE;

    reset <= '1';
    LedClk <= '0';
    BtnClk <= '0';
    GameClk <= '0';
    
    BtnOne <= '0';
    BtnTwo <= '0';
    BtnThree <= '0';
    BtnFour <= '0';
    
    wait for 10 ns;

    reset <= '0';

    -- Four full clock cycles loop
    for i in 0 to 7 loop
      LedClk <= not(LedClk);
      for j in 0 to 1 loop
        BtnClk <= not(BtnClk);
        for k in 0 to 3  loop
          GameClk <= not(GameClk);
          wait for 5 ns;
        end loop;
      end loop;
    end loop;

    BtnOne <= '1'; -- Press button 1

    wait for 5 ns;

    -- 8 full clock cycles loop
    for i in 0 to 15 loop
      LedClk <= not(LedClk);
      for j in 0 to 1 loop
        BtnClk <= not(BtnClk);
        for k in 0 to 3  loop
          GameClk <= not(GameClk);
          wait for 5 ns;
        end loop;
      end loop;
      BtnOne <= '0'; -- Simulates single press
    end loop;

    REPORT "Testing finished successfully." SEVERITY NOTE;
    wait;
  end process;
end Behavioral;
