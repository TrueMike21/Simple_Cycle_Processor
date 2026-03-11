library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftLeft2_32 is
    port (
        Q     : in  std_logic_vector(31 downto 0);
        Qplus : out std_logic_vector(31 downto 0)
    );
end entity ShiftLeft2_32;

architecture rtl of ShiftLeft2_32 is
begin
    gen_value : for i in 0 to 29 generate
        Qplus(i + 2) <= Q(i);
    end generate gen_value;
end architecture rtl;