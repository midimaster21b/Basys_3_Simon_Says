----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2018 04:04:54 PM
-- Design Name: 
-- Module Name: Mux_tb - Behavioral
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

entity Mux_tb is
end Mux_tb;

architecture Behavioral of Mux_tb is

component SevenSegmentMux
Port (
  DisplayMuxIn: in STD_LOGIC_VECTOR (1 downto 0);
  CharMuxIn: in STD_LOGIC_VECTOR (11 downto 0);
  DisplayMuxOut: out STD_LOGIC_VECTOR (3 downto 0);
  CharMuxOut: out STD_LOGIC_VECTOR (2 downto 0)
);
end component;

  signal sim_clk : STD_LOGIC;
  signal mux_output: STD_LOGIC_VECTOR (2 downto 0);
  signal mux_selector: STD_LOGIC_VECTOR (1 downto 0);
  signal char_in : STD_LOGIC_VECTOR (11 downto 0);
  signal display_out: STD_LOGIC_VECTOR (3 downto 0);

  PROCEDURE monitor(ExpectedValue: in STD_LOGIC_VECTOR (2 downto 0 ) ) is
  variable line_out: line;
  begin
    write(line_out, NOW, right, 10, ns);
    write(line_out, string'(" Value --> Mux Output"));

    write(line_out, string'(" Expected -->"));
    write(line_out, ExpectedValue);

    write(line_out, string'(" Received -->"));
    write(line_out, mux_output);

    WRITELINE(OUTPUT, line_out);
    ASSERT mux_output = ExpectedValue REPORT "Test Failed: Incorrect character selected at output" SEVERITY FAILURE;
  end monitor;
  
  begin
   M1: SevenSegmentMux PORT MAP ( mux_selector, char_in, display_out, mux_output );

  stim_proc: process
  begin
    wait for 100 ns;
    REPORT "Beginning the Mux test" SEVERITY NOTE;

    mux_selector <= "00";
    char_in <= "011101110001";

    sim_clk <= '0';
    wait for 5 ns;

    REPORT "Testing section 0" SEVERITY NOTE;
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("001");

    REPORT "Testing section 1" SEVERITY NOTE;
    mux_selector <= "01";
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("110");

    REPORT "Testing section 2" SEVERITY NOTE;
    mux_selector <= "10";
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("101");

    REPORT "Testing section 3" SEVERITY NOTE;
    mux_selector <= "11";
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    monitor("011");
    
    REPORT "Testing finished successfully." SEVERITY NOTE;

    wait;
  end process;
end Behavioral;
