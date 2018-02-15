----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2018 01:31:00 AM
-- Design Name: 
-- Module Name: SimonSaysGameLogic - Behavioral
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

entity SimonSaysGameLogic is
  Port (
    signal rst, BtnOne, BtnTwo, BtnThree, GameClk, LedClk : in STD_LOGIC; 
    signal LedOne, LedTwo, LedThree : out STD_LOGIC;
    signal CharOut : out STD_LOGIC_VECTOR (11 downto 0)
  );
end SimonSaysGameLogic;

architecture Behavioral of SimonSaysGameLogic is

  type state_type is (reset, output_lights, input_buttons, display_status);
  signal current_state, next_state : state_type;

  type led_type is (left_led, center_led, right_led);
  type led_sequence is array (5 downto 0) of led_type;
  signal game_sequence : led_sequence := (left_led, center_led, right_led, center_led, left_led, center_led);

  signal sequence_size : Integer := 0;
  signal sequence_iter : Integer := 0;

  -- Signal flags
  signal output_lights_complete, input_buttons_complete, display_status_complete : STD_LOGIC := '0';
begin

  AdvanceState : process(GameClk)
  begin
    if rst = '1' then
      current_state <= reset;
    elsif GameClk'event and GameClk = '1' then
      current_state <= next_state;
    end if;
  end process;

  ComputeNextState : process(current_state)
  begin
    case current_state is
      when reset =>
        if BtnOne = '1' then
          next_state <= output_lights;
        else
          next_state <= reset;
        end if;
        
      when output_lights =>
        if output_lights_complete = '1' then
          next_state <= input_buttons;
        else
          next_state <= output_lights;
        end if;
        
      when input_buttons =>
        next_state <= reset;
        
      when display_status =>
        if BtnOne = '1' then
          next_state <= reset;
        else
          next_state <= display_status;
        end if;
    
      when others =>
        next_state <= reset;

    end case;
  end process;
  
  HandleButtonState : process(BtnOne, BtnTwo, BtnThree)
  begin
    if current_state = input_buttons then
      -- Handle button input
      if BtnOne = '1' then
        
        
      elsif BtnTwo = '1' then
        
      elsif BtnThree = '1' then
        
      end if;
    end if;
  end process;
  
  HandleLedState : process(LedClk)
  begin
    if rising_edge(LedClk) then
      if current_state = output_lights then
        -- Exit case
        if sequence_iter = sequence_size then
          output_lights_complete <= '1';

        -- Normal case
        else
          case game_sequence(sequence_iter) is
            when left_led =>
              LedOne   <= '1';
              LedTwo   <= '0';
              LedThree <= '0';
            when center_led =>
              LedOne   <= '0';
              LedTwo   <= '1';
              LedThree <= '0';
            when right_led =>
              LedOne   <= '0';
              LedTwo   <= '0';
              LedThree <= '1';
            when others =>
              LedOne   <= '0';
              LedTwo   <= '0';
              LedThree <= '0';
          end case;

          sequence_iter <= sequence_iter + 1;
        end if;
      end if;    
    end if;  
  end process;
end Behavioral;
