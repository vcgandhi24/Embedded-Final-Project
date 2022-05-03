
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_8 is
   port(
      clk,rst,load : in std_logic;
      d: in std_logic_vector (7 downto 0);
      q: out std_logic_vector (7 downto 0));
end reg_8 ;

architecture rtl of reg_8 is
begin
  process(clk,rst)
  begin
    if (rst = '1') then
      q <= (others=>'0');
    elsif (rising_edge(clk)) then
      if (load = '1') then 
	      q <= d;
      end if;
    end if;
  end process;
end rtl;