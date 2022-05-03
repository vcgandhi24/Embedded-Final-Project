library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
  port(
    x,y: in std_logic_vector (7 downto 0);
    z: out std_logic_vector (7 downto 0));
end adder ;

architecture rtl of adder is
  signal z_int : unsigned(7 downto 0);
begin
  z_int <= unsigned(x) + unsigned(y);
  z <= std_logic_vector(z_int);
end rtl;