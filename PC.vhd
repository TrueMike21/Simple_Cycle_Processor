library ieee;
use ieee.std_logic_1164.all;

entity PC is
port(
     Qin: in std_logic_vector(31 downto 0);
	  load: in std_logic;
	  clk: in std_logic;
	  Qout: out std_logic_vector(31 downto 0));
end entity PC;

architecture rtl of PC is

component en_dff_ms is
  port(
    D : in  std_logic;
	 en: in std_logic;
    clk : in  std_logic;
    Q : out std_logic;
	 Qn: out std_logic
  );
end component;

begin

gen_units: for i in 0 to 31 generate
unit : en_dff_ms port map(D=>Qin(i), en=>load, clk=>clk, Q=>Qout(i), Qn=>open);
end generate gen_units;

end architecture rtl;