library ieee;
use ieee.std_logic_1164.all;

entity signExtend is
       port (
       Q: in std_logic_vector(15 downto 0);
		 Qplus: out std_logic_vector(31 downto 0));
end entity signExtend;

architecture rtl of signExtend is
begin
gen_q: for i in 0 to 15 generate
Qplus(i)<=Q(i);
Qplus(i+16)<=Q(15);
end generate gen_q;
end architecture rtl;