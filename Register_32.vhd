library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_32 is
    port (
        clk  : in  std_logic;
        load : in  std_logic;
        Qin  : in  std_logic_vector(31 downto 0);
        Qout : out std_logic_vector(31 downto 0)
    );
end entity Register_32;

architecture rtl of Register_32 is

    component en_dff_ms is
        port (
            D  : in  std_logic;
            en : in  std_logic;
            clk: in  std_logic;
            Q  : out std_logic;
            Qn : out std_logic
        );
    end component;

begin

    gen_regs : for i in 0 to 31 generate
        unit_register : en_dff_ms
            port map (
                D   => Qin(i),
                en  => load,
                clk => clk,
                Q   => Qout(i),
                Qn  => open
            );
    end generate gen_regs;

end architecture rtl;