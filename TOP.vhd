
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
Port (
clk: in std_logic; 
reset: in std_logic;
go_i: in std_logic;
rows    :  IN     STD_LOGIC_VECTOR(1 TO 4);            --row connections to keypad
columns :  BUFFER STD_LOGIC_VECTOR(1 TO 4) := "1111";
rows2    :  IN     STD_LOGIC_VECTOR(1 TO 4);            --row connections to keypad
columns2 :  BUFFER STD_LOGIC_VECTOR(1 TO 4) := "1111";  
digit_select: buffer std_logic;
segments: out std_logic_vector(6 downto 0));
end TOP;

architecture Behavioral of TOP is

component lcm_top
  port(clk,rst,go_i: in std_logic;
       x_i,y_i: in std_logic_vector (15 downto 0);
       rst_n: out std_logic;
       d_out: out integer);
end component;

component pmod_keypad
  GENERIC(
    clk_freq    : INTEGER := 50_000_000;  --system clock frequency in Hz
    stable_time : INTEGER := 10);         --time pressed key must remain stable in ms
  PORT(
    clk     :  IN     STD_LOGIC;                           --system clock
    reset_n :  IN     STD_LOGIC;                           --asynchornous active-low reset
    rows    :  IN     STD_LOGIC_VECTOR(1 TO 4);            --row connections to keypad
    columns :  BUFFER STD_LOGIC_VECTOR(1 TO 4) := "1111";  --column connections to keypad
    keys    :  OUT    STD_LOGIC_VECTOR(0 TO 15));          --resultant key presses
END component;

component pmod_keypad2 IS
  GENERIC(
    clk_freq    : INTEGER := 50_000_000;  --system clock frequency in Hz
    stable_time : INTEGER := 10);         --time pressed key must remain stable in ms
  PORT(
    clk     :  IN     STD_LOGIC;                           --system clock
    reset_n :  IN     STD_LOGIC;                           --asynchornous active-low reset
    rows2    :  IN     STD_LOGIC_VECTOR(1 TO 4);            --row connections to keypad
    columns2 :  BUFFER STD_LOGIC_VECTOR(1 TO 4) := "1111";  --column connections to keypad
    keys2   :  OUT    STD_LOGIC_VECTOR(0 TO 15));          --resultant key presses
END component;

component pmod_seven_segments
  GENERIC(
    clk_freq : INTEGER := 100);  --the provided system clock frequency in MHz
  PORT(
    clk          : IN      STD_LOGIC;                      --system clock
    reset_n      : IN      STD_LOGIC;                      --active low reset
    number       : IN      INTEGER;                        --number to display on the 7 segment displays
    digit_select : BUFFER  STD_LOGIC;                      --output to the pmod digit select pin
    segments     : OUT     STD_LOGIC_VECTOR(6 DOWNTO 0));  --outputs to the pmod seven segment displays
END component;
signal rst_n: std_logic;
signal d_out: integer;
signal keys, keys2: std_logic_vector(0 to 15);
begin
   input1: pmod_keypad port map(clk,rst_n, rows, columns,keys);
   input2: pmod_keypad2 port map(clk, rst_n, rows2, columns2, keys2);
   a0 : lcm_top port map (clk, reset, go_i,keys,keys2,rst_n,d_out);
   a1 : pmod_seven_segments port map(clk, reset, d_out, digit_select,segments);

end Behavioral;
