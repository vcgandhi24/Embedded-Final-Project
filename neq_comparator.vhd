

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity neq_comparator is
  port(x,y: in std_logic_vector (7 downto 0);
       x_neq_y: out std_logic);
end neq_comparator ;

architecture rtl of neq_comparator is
begin
  process(x,y)
  begin
    if (x = y) then
      x_neq_y <= '0';
    else
      x_neq_y <= '1';
    end if;
  end process;
end rtl;