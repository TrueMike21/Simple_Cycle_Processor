library ieee;
use ieee.std_logic_1164.all;

entity fullAdder32bit is
    port(
        A    : in  std_logic_vector(31 downto 0);
        B    : in  std_logic_vector(31 downto 0);
        Cin  : in  std_logic;
        Sum  : out std_logic_vector(31 downto 0);
        Cout : out std_logic
    );
end entity fullAdder32bit;

architecture structural of fullAdder32bit is

    -- Component Declaration for the 1-bit Full Adder
    component fullAdder
        port(
            A    : in  std_logic;
            B    : in  std_logic;
            Cin  : in  std_logic;
            S    : out std_logic;
            Cout : out std_logic
        );
    end component;

    -- Internal signals to connect the carry bits
    signal carry : std_logic_vector(32 downto 0);

begin

    -- Connect input carry to the first internal carry
    carry(0) <= Cin;

    -- Generate 23 instances of the fullAdder
    gen_adder: for i in 0 to 31 generate
        FA_inst : fullAdder
            port map (
                A    => A(i),
                B    => B(i),
                Cin  => carry(i),
                S    => Sum(i),
                Cout => carry(i+1)
            );
    end generate;

    -- Connect the last carry to the final Cout
    Cout <= carry(32);

end architecture structural;