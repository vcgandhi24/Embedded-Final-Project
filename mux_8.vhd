

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_8 is
 Port ( 
a,b: in std_logic_vector(7 downto 0);
        s: in std_logic;
		    y: out std_logic_vector(7 downto 0));
end mux_8;

architecture Behavioral of mux_8 is

begin

 y <= b when s = '1' else a;
end Behavioral;