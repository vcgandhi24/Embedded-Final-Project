library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned architecture
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lcm_top is
  port(clk,rst,go_i: in std_logic;
       x_i,y_i: in std_logic_vector (15 downto 0);
       rst_n : out std_logic;
       d_out: out integer);
end lcm_top;

architecture struct of lcm_top is
  signal x_in, y_in : std_logic_vector(7 downto 0);
  signal temp1, temp2: integer;
  signal d_ld, x_ld, x_lt_y, x_neq_y, x_sel, y_ld, y_sel: std_logic;
  signal d_o : std_logic_vector(7 downto 0);
  component controller
  port (clk,rst,go_i,x_lt_y,x_neq_y: in std_logic ;
    x_sel,x_ld,y_sel,y_ld,d_ld: out std_logic);
  end component;
  component datapath
  port (clk,rst,x_sel,x_ld,y_sel,y_ld,d_ld: in std_logic;
    x_i,y_i: in std_logic_vector (7 downto 0);
    x_lt_y,x_neq_y: out std_logic; 
    d_o: out std_logic_vector (7 downto 0));
  end component;
begin
  temp1 <= to_integer(unsigned(x_i));
  x_in <= std_logic_vector(to_unsigned(temp1, x_in'length));
  temp2 <= to_integer(unsigned(y_i));
  y_in <= std_logic_vector(to_unsigned(temp2, y_in'length));
  u0 : controller port map (clk,rst,go_i,x_lt_y,x_neq_y,x_sel,x_ld,y_sel,y_ld,d_ld);
  u1 : datapath port map (clk,rst,x_sel,x_ld,y_sel,y_ld,d_ld,x_in,y_in,x_lt_y,x_neq_y,d_o); 
  d_out <= to_integer(unsigned(d_o));
  rst_n <= '1';
end struct;