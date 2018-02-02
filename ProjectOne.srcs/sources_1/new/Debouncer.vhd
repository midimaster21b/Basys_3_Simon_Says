----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/01/2018 05:53:45 PM
-- Design Name: 
-- Module Name: Debouncer - Behavioral
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

entity Debouncer is
  Port (clk: in STD_LOGIC; btn_in: in STD_LOGIC; btn_out: out STD_LOGIC := '0');
end Debouncer;

architecture Behavioral of Debouncer is
  signal status: STD_LOGIC_VECTOR (4 downto 0);
begin

  process( clk )
  begin
    if rising_edge(clk) then
      status <= status(3 downto 0) & btn_in;
    
      if status = "11111" then
        btn_out <= '1';
      else
        btn_out <= '0';
      end if;
    end if;
  end process;
end Behavioral;
