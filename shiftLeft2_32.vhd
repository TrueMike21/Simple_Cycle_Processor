library ieee;
use ieee.std_logic_1164.all;

entity shiftLeft2_32 is
port(
     Q: in std_logic_vector(31 downto 0);
	  Qplus: out std_logic_vector(31 downto 0));
end entity shiftLeft2_32;

architecture rtl of shiftLeft2_32 is
begin
gen_value: for i in 0 to 29 generate
Qplus(i+2)<=Q(i);
end generate gen_value;
end architecture rtl;