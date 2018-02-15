----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2018 06:41:27 PM
-- Design Name: 
-- Module Name: mymux_beh_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer_tb is
end Debouncer_tb;

architecture Behavioral of Debouncer_tb is

  component Debouncer
    Port (clk: in STD_LOGIC; btn_in: in STD_LOGIC; btn_out: out STD_LOGIC);
  end component;

  signal sim_clk, sim_btn_in, debounce_out: STD_LOGIC;

  PROCEDURE monitor(ExpectedValue: in STD_LOGIC) is
  variable line_out: line;
  begin
    write(line_out, NOW, right, 10, ns);
    write(line_out, string'(" Value --> Debounce Out"));

    -- Y output
    write(line_out, string'(" Expected -->"));
    write(line_out, ExpectedValue);

    -- S output
    write(line_out, string'(" Received -->"));
    write(line_out, debounce_out);

    WRITELINE(OUTPUT, line_out);
    ASSERT debounce_out = ExpectedValue REPORT "Test Failed: Incorrect debounce value detected" SEVERITY FAILURE;
  end monitor;
  
  begin
  M1: Debouncer PORT MAP ( sim_clk, sim_btn_in, debounce_out );

  stim_proc: process
  begin
    wait for 100 ns;
    REPORT "Beginning the Debouncer test" SEVERITY NOTE;

    -- Six without button press
    sim_btn_in <= '0';
    sim_clk <= '0';
    
    for i in 0 to 5 loop
      sim_clk <= '1';
      wait for 1 ns;
      sim_clk <= '0';
      wait for 1 ns;
      monitor('0');
    end loop;
    sim_clk <= '0';

--    -- Three clock cycles on
    REPORT "Starting 3 cycles on, 6 cycles off test" SEVERITY NOTE;
    sim_btn_in <= '1';
    sim_clk <= '0';

    for i in 0 to 2 loop
      sim_clk <= '1';
      wait for 1 ns;
      sim_clk <= '0';
      wait for 1 ns;
      monitor('0');
    end loop;

    sim_btn_in <= '0';

    for i in 0 to 5 loop
      sim_clk <= '1';
      wait for 1 ns;
      sim_clk <= '0';
      wait for 1 ns;
      monitor('0');
    end loop;

    REPORT "Beginning the 4 cycles on, 4 cycles off test" SEVERITY NOTE;
    sim_btn_in <= '1';
    for i in 0 to 3 loop
      sim_clk <= '1';
      wait for 1 ns;
      sim_clk <= '0';
      wait for 1 ns;
      monitor('0');
    end loop;

    sim_btn_in <= '0';
    
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    
    monitor('1'); -- Should be one 

    for i in 0 to 2 loop
      sim_clk <= '1';
      wait for 1 ns;
      sim_clk <= '0';
      wait for 1 ns;
      monitor('0');
    end loop;
    
    REPORT "Beginning the 8 cycles on" SEVERITY NOTE;
    sim_btn_in <= '1';
    for i in 0 to 3 loop
      sim_clk <= '1';
      wait for 1 ns;
      sim_clk <= '0';
      wait for 1 ns;
      monitor('0');
    end loop;
    
    sim_clk <= '1';
    wait for 1 ns;
    sim_clk <= '0';
    wait for 1 ns;
    
    monitor('1'); -- Should be one 

    for i in 0 to 2 loop
      sim_clk <= '1';
      wait for 1 ns;
      sim_clk <= '0';
      wait for 1 ns;
      monitor('0');
    end loop;
    
    

    REPORT "Debouncer test completed." SEVERITY NOTE;

    wait;
  end process;
end Behavioral;
