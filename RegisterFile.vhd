library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    port (
        clk           : in  std_logic;
        RegWrite      : in  std_logic;
        Read_reg_1    : in  std_logic_vector(4 downto 0);
        Read_reg_2    : in  std_logic_vector(4 downto 0);
        Write_reg     : in  std_logic_vector(4 downto 0);
        Write_data    : in  std_logic_vector(31 downto 0);
        Read_data_1   : out std_logic_vector(31 downto 0);
        Read_data_2   : out std_logic_vector(31 downto 0)
    );
end RegisterFile;

architecture Structural of RegisterFile is

   component Register_32 is
	port (
        clk  : in  std_logic;
        load : in  std_logic;
        Qin  : in  std_logic_vector(31 downto 0);
        Qout : out std_logic_vector(31 downto 0)
    );
	 end component;
	 
    -- Array to hold the output of each individual register
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal reg_outputs : reg_array;
    signal write_en_bus : std_logic_vector(31 downto 0);

begin

    -- 1. DECODER for Write Enable
    -- Generate a 32-bit bus where only the bit at index 'Write_reg' is high
    gen_decoder: for i in 0 to 31 generate
        write_en_bus(i) <= '1' when (Write_reg = std_logic_vector(to_unsigned(i, 5)) and RegWrite = '1') 
                           else '0';
    end generate;

    -- 2. REGISTER INSTANTIATION
    -- Register 0 is hardwired to 0 in MIPS
    reg_outputs(0) <= (others => '0');
    
    -- Instantiate 31 more registers
    gen_regs: for i in 1 to 31 generate
        REG_I: Register_32 
            port map (
                clk => clk,
                load  => write_en_bus(i),
                Qin   => Write_data,
                Qout  => reg_outputs(i)
            );
    end generate;

    -- 3. MULTIPLEXERS for Reading
    -- These concurrent signal assignments act as 32-to-1 Muxes
    Read_data_1 <= reg_outputs(to_integer(unsigned(Read_reg_1)));
    Read_data_2 <= reg_outputs(to_integer(unsigned(Read_reg_2)));

end architecture Structural;