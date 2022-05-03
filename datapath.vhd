
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
port (clk,rst,x_sel,x_ld,y_sel,y_ld,d_ld: in std_logic;
      x_i,y_i: in std_logic_vector (7 downto 0);
      x_lt_y,x_neq_y: out std_logic; 
      d_o: out std_logic_vector (7 downto 0));
end datapath ;

architecture struct of datapath is
  signal x,x_int,x_sub,y,y_int,y_sub : std_logic_vector(7 downto 0);
  component lt_comparator
  port (x,y: in std_logic_vector (7 downto 0);
        x_lt_y : out std_logic);
  end component;
  component neq_comparator
  port (x,y: in std_logic_vector (7 downto 0);
        x_neq_y: out std_logic);
  end component;
  component mux_8
  port (a,b : in std_logic_vector (7 downto 0);
        s : in std_logic ;
        y : out std_logic_vector (7 downto 0));
  end component;
  component reg_8
  port (clk,rst,load: in std_logic;
        d: in std_logic_vector (7 downto 0);
        q: out std_logic_vector (7 downto 0));
  end component;
  component adder
  port (x,y: in std_logic_vector (7 downto 0);
        z: out std_logic_vector (7 downto 0));
  end component;
  
begin
  u0 : lt_comparator port map (x,y,x_lt_y);
  u1 : neq_comparator port map (x,y,x_neq_y);
  u2 : mux_8 port map (x_i,x_sub,x_sel,x_int);
  u3 : mux_8 port map (y_i,y_sub,y_sel,y_int);
  u4 : reg_8 port map (clk,rst,x_ld,x_int,x);
  u5 : reg_8 port map (clk,rst,y_ld,y_int,y);
  u6 : reg_8 port map (clk,rst,d_ld,y,d_o);
  u7 : adder port map (x,x_i,x_sub);
  u8 : adder port map (y,y_i,y_sub);
end struct;