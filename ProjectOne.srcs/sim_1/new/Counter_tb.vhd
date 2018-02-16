----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2018 08:27:07 PM
-- Design Name: 
-- Module Name: Counter_tb - Behavioral
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

entity Counter_tb is
end Counter_tb;

architecture Behavioral of Counter_tb is

component Counter_2Bit
  Port ( clk: in STD_LOGIC; count: out STD_LOGIC_VECTOR (1 downto 0) );
end component;

  signal sim_clk : STD_LOGIC;
  signal counter_out: STD_LOGIC_VECTOR (1 downto 0);

  PROCEDURE monitor(ExpectedValue: in STD_LOGIC_VECTOR (1 downto 0 ) ) is
  variable line_out: line;
  begin
    write(line_out, NOW, right, 10, ns);
    write(line_out, string'(" Value --> Counter Out"));

    write(line_out, string'(" Expected -->"));
    write(line_out, ExpectedValue);

    write(line_out, string'(" Received -->"));
    write(line_out, counter_out);

    WRITELINE(OUTPUT, line_out);
    ASSERT counter_out = ExpectedValue REPORT "Test Failed: Incorrect counter value detected" SEVERITY FAILURE;
  end monitor;
  
  begin
   M1: Counter_2Bit PORT MAP ( sim_clk, counter_out );

  stim_proc: process
  begin
    wait for 100 ns;
    REPORT "Beginning the Counter test" SEVERITY NOTE;

    -- Six without button press
    sim_clk <= '0';
    wait for 5 ns;

    REPORT "Expecting 1 at the output" SEVERITY NOTE;
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("01");

    REPORT "Expecting 2 at the output" SEVERITY NOTE;
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("10");

    REPORT "Expecting 3 at the output" SEVERITY NOTE;
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("11");

    REPORT "Expecting 0 at the output" SEVERITY NOTE;
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("00");

    REPORT "Expecting 1 at the output" SEVERITY NOTE;
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("01");

    REPORT "Testing finished successfully." SEVERITY NOTE;
    wait;
  end process;
end Behavioral;
