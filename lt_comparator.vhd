
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lt_comparator is
  port(x,y: in std_logic_vector (7 downto 0);
       x_lt_y : out    std_logic);
end lt_comparator ;

architecture rtl of lt_comparator is
begin
  process(x,y)
  begin
    if x < y then
	  x_lt_y <= '1';
	else
	  x_lt_y <= '0';
	end if;
  end process;
end rtl;