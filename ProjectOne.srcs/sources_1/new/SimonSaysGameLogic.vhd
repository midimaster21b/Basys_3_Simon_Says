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
    signal rst, BtnOne, BtnTwo, BtnThree, BtnFour, GameClk, LedClk, BtnClk : in STD_LOGIC; 
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

  signal sequence_size_base : Integer := 3;
  signal sequence_size : Integer := sequence_size_base;
  signal sequence_iter_lights : Integer := 0;
  signal sequence_iter_buttons : Integer := 0;

  -- Signal flags
  signal output_lights_complete, input_buttons_complete, display_status_complete : STD_LOGIC := '0';

  -- Input signals
  signal sequence_length_char, sequence_iter_btn_char : STD_LOGIC_VECTOR (2 downto 0) := "111";

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
        if input_buttons_complete = '1' then
          next_state <= display_status;
        else
          next_state <= input_buttons;
        end if;

      when display_status =>
        if display_status_complete = '1' then
          if display_state = success then
            -- sequence_size <= sequence_size + 1;
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
  
--   HandleButtonState : process(BtnOne, BtnTwo, BtnThree)
  HandleButtonState : process(BtnClk, current_state)
  begin
    if rising_edge(BtnClk) then
      if current_state = input_buttons then
        -- Exit condition
        if sequence_iter_buttons >= sequence_size then
          display_state <= success;
          input_buttons_complete <= '1';
          sequence_size <= sequence_size + 1;

        -- Normal operation
        else
          -- Handle button input
          if BtnOne = '1' then
            if game_sequence(sequence_iter_buttons) = left_led then
              sequence_iter_buttons <= sequence_iter_buttons + 1;
            else
              display_state <= failure;
              input_buttons_complete <= '1';
              sequence_size <= sequence_size_base;
            end if;

          elsif BtnTwo = '1' then
            if game_sequence(sequence_iter_buttons) = center_led then
              sequence_iter_buttons <= sequence_iter_buttons + 1;
            else
              display_state <= failure;
              input_buttons_complete <= '1';
              sequence_size <= sequence_size_base;
            end if;
    
          elsif BtnThree = '1' then
            if game_sequence(sequence_iter_buttons) = right_led then
              sequence_iter_buttons <= sequence_iter_buttons + 1;
            else
              display_state <= failure;
              input_buttons_complete <= '1';
              sequence_size <= sequence_size_base;
            end if;
          end if;
        end if;
      
      elsif current_state = display_status then
        if BtnFour = '1' then
          display_status_complete <= '1';
        end if;
      end if;
    end if;
      
    if current_state /= input_buttons then
      input_buttons_complete <= '0'; -- reset input_buttons complete flag
      sequence_iter_buttons <= 0;    -- reset sequence iterator
    end if;
    
    if current_state /= display_status then
      display_status_complete <= '0';
    end if;
    
  end process;
  
  HandleLedState : process(LedClk, current_state)
  begin
    if rising_edge(LedClk) and current_state = output_lights then
      -- Exit case
      if sequence_iter_lights >= sequence_size then
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
      
    if current_state /= output_lights then
      output_lights_complete <= '0';
      LedOne   <= '0';
      LedTwo   <= '0';
      LedThree <= '0';
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
    elsif current_state = reset then
      CharOut <= "010111111111"; -- O
    elsif current_state = output_lights then
      CharOut <= "010010111111"; -- OO
    elsif current_state = input_buttons then
      CharOut <= "010010010111"; -- OOO
    end if;
  end process;
end Behavioral;
