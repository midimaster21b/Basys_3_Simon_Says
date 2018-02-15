----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2018 12:16:34 AM
-- Design Name: 
-- Module Name: SimonSays - Behavioral
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

entity SimonSays is
  Port (
    InputClock : in STD_LOGIC;
    SevenSegmentCharacter : out STD_LOGIC_VECTOR (6 downto 0);
    SevenSegmentDisplaySelect : out STD_LOGIC_VECTOR (3 downto 0);
    rst_switch : in STD_LOGIC;
    LedOne, LedTwo, LedThree : out STD_LOGIC
  );
end SimonSays;

architecture Behavioral of SimonSays is

component Clk_Divider_250Hz
    Port ( clk_in : in STD_LOGIC; div_clk : out STD_LOGIC );
end component;

component Counter_2Bit
  Port ( clk: in STD_LOGIC; count: out STD_LOGIC_VECTOR (1 downto 0) );
end component;

component Debouncer
  Port (clk: in STD_LOGIC; btn_in: in STD_LOGIC; btn_out: out STD_LOGIC := '0');
end component;

component SevenSegmentDecoder
  Port ( Input_Char: in STD_LOGIC_VECTOR (2 downto 0); Output_Char: out STD_LOGIC_VECTOR (6 downto 0) );
end component;

component SevenSegmentMux
Port (
  DisplayMuxIn: in STD_LOGIC_VECTOR (1 downto 0); -- Select what character to mux
  CharMuxIn: in STD_LOGIC_VECTOR (11 downto 0);  -- 4 characters (3 bits a piece)
  DisplayMuxOut: out STD_LOGIC_VECTOR (3 downto 0); -- Which seven segment output to use (one hot wire)
  CharMuxOut: out STD_LOGIC_VECTOR (2 downto 0)  -- The character to be output
);
end component;

component ClkDivider
  Generic ( OutputClkFreq : Integer := 1; InputClkFreq : Integer := 100000000 );
  Port (signal InputClock : in STD_LOGIC; signal OutputClock : out STD_LOGIC := '0' );
end component;

component SimonSaysGameLogic
  Port (
    signal rst, BtnOne, BtnTwo, BtnThree, GameClk, LedClk : in STD_LOGIC; 
    signal LedOne, LedTwo, LedThree : out STD_LOGIC;
    signal CharOut : out STD_LOGIC_VECTOR (11 downto 0)
  );
end component;

-- General Signals
signal rst : STD_LOGIC := '0';

-- Inputs
signal DebounceClock : STD_LOGIC;

signal ButtonOneInput : STD_LOGIC;
signal ButtonTwoInput : STD_LOGIC;
signal ButtonThreeInput : STD_LOGIC;

signal ButtonOneDebounce : STD_LOGIC;
signal ButtonTwoDebounce : STD_LOGIC;
signal ButtonThreeDebounce : STD_LOGIC;

-- Game Logic
signal LedClock : STD_LOGIC;

-- Seven Segment
signal SevenSegmentClock : STD_LOGIC;
signal SevenSegmentCounterOut : STD_LOGIC_VECTOR (1 downto 0);       -- Counter representation of which seven segment to select
signal SevenSegmentMuxCharacters : STD_LOGIC_VECTOR (11 downto 0);   -- 4 encoded charaters supplied to mux
signal SevenSegmentCharacterSelect : STD_LOGIC_VECTOR (2 downto 0);  -- Selected encoded character to output
-- signal SevenSegmentDisplaySelect : STD_LOGIC_VECTOR (3 downto 0);    -- One hot wire selecting which seven segment display to output to
-- signal SevenSegmentCharacter : STD_LOGIC_VECTOR (6 downto 0);        -- Actual cathode control

begin

-- Inputs
DebounceClkDivider: ClkDivider GENERIC MAP (OutputClkFreq => 20)
                               PORT MAP (InputClock, DebounceClock);
BTN1: Debouncer PORT MAP (DebounceClock, ButtonOneInput, ButtonOneDebounce);
BTN2: Debouncer PORT MAP (DebounceClock, ButtonTwoInput, ButtonTwoDebounce);
BTN3: Debouncer PORT MAP (DebounceClock, ButtonThreeInput, ButtonThreeDebounce);

-- Game Logic...
LedClkDivider: ClkDivider GENERIC MAP (OutputClkFreq => 1)
                             PORT MAP (InputClock, LedClock);

GAME: SimonSaysGameLogic
  PORT MAP (
    rst, ButtonOneDebounce, ButtonTwoDebounce, ButtonThreeDebounce, InputClock, LedClock, 
    LedOne, LedTwo, LedThree,
    SevenSegmentMuxCharacters
  );


-- Seven Segment Displays
U1: CLK_DIVIDER_250Hz PORT MAP (InputClock, SevenSegmentClock);
U2: Counter_2Bit PORT MAP (SevenSegmentClock, SevenSegmentCounterOut);
U3: SevenSegmentMux PORT MAP (SevenSegmentCounterOut, SevenSegmentMuxCharacters, SevenSegmentDisplaySelect, SevenSegmentCharacterSelect);
U4: SevenSegmentDecoder PORT MAP (SevenSegmentCharacterSelect, SevenSegmentCharacter);

end Behavioral;
