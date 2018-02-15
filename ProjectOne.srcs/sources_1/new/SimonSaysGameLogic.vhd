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

  -- State definitions
  type state_type is (reset, output_lights, input_buttons, display_status);
  signal current_state, next_state : state_type;

  type display_type is (success, failure);
  signal display_state : display_type := success;

  -- Led and sequence definitions
  type led_type is (left_led, center_led, right_led);
  type led_sequence is array (5 downto 0) of led_type;
  signal game_sequence : led_sequence := (left_led, center_led, right_led, center_led, left_led, center_led);

  signal sequence_size : Integer := 3;
  signal sequence_iter_lights : Integer := 0;
  signal sequence_iter_buttons : Integer := 0;

  -- Signal flags
  signal output_lights_complete, input_buttons_complete : STD_LOGIC := '0';
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
          -- Reset sequence size and iterator
          sequence_size <= 0;
          next_state <= output_lights;
        else
          next_state <= reset;
        end if;
        
      when output_lights =>
        if output_lights_complete = '1' then
          next_state <= input_buttons;
          -- output_lights_complete <= '0';
        else
          next_state <= output_lights;
        end if;
        
      when input_buttons =>
        if input_buttons_complete = '1' then
          next_state <= display_status;
          -- input_buttons_complete <= '0';
        else
          next_state <= input_buttons;
        end if;

      when display_status =>
        -- Wait for Button 1 to be pressed
        if BtnOne = '1' then
          if display_state = success then
            next_state <= output_lights;
          else
            next_state <= reset;
          end if;

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
        if game_sequence(sequence_iter_buttons) = left_led then
          sequence_iter_buttons <= sequence_iter_buttons + 1;
        else
          display_state <= failure;
          input_buttons_complete <= '1';
        end if;
      
      elsif BtnTwo = '1' then
        if game_sequence(sequence_iter_buttons) = center_led then
          sequence_iter_buttons <= sequence_iter_buttons + 1;
        else
          display_state <= failure;
          input_buttons_complete <= '1';
        end if;

      elsif BtnThree = '1' then
        if game_sequence(sequence_iter_buttons) = right_led then
          sequence_iter_buttons <= sequence_iter_buttons + 1;
        else
          display_state <= failure;
          input_buttons_complete <= '1';
          sequence_iter_buttons <= 0;
        end if;
      end if;
    end if;
  end process;
  
  HandleLedState : process(LedClk)
  begin
    if rising_edge(LedClk) then
      if current_state = output_lights then
        -- Exit case
        if sequence_iter_lights = sequence_size then
          output_lights_complete <= '1';
          sequence_iter_lights <= 0;

        -- Normal case
        else
          case game_sequence(sequence_iter_lights) is
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

          sequence_iter_lights <= sequence_iter_lights + 1;
        end if;
      end if;    
    end if;  
  end process;
  
  HandleDisplayState : process(GameClk)
  begin
    if current_state = display_status then
      if display_state = success then
        CharOut <= "011000011110"; -- Print YAY!
      else
        CharOut <= "100010101001"; -- Print LOSE
      end if;
    else
      CharOut <= "111111111111"; -- Display nothing on the screen
    end if;
  end process;
end Behavioral;
