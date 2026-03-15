library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
    port (
        clk          : in  std_logic;
        MemWrite     : in  std_logic;
        MemRead      : in  std_logic; -- Note: In simple RTL, MemRead often just enables the Mux
        Address      : in  std_logic_vector(31 downto 0);
        Write_data   : in  std_logic_vector(31 downto 0);
        Read_data    : out std_logic_vector(31 downto 0)
    );
end DataMemory;

architecture Structural of DataMemory is
    component Register_32 is
    port (
        clk  : in  std_logic;
        load : in  std_logic;
        Qin  : in  std_logic_vector(31 downto 0);
        Qout : out std_logic_vector(31 downto 0)
    );
end component;

    -- Array of signals to connect the internal registers
    type ram_type is array (0 to 31) of std_logic_vector(31 downto 0);
    signal reg_outputs : ram_type;
    signal write_en_bus : std_logic_vector(31 downto 0);
    
    -- Address decoding (MIPS uses byte addresses, we need word index)
    signal word_index : integer range 0 to 31;

begin

    -- 1. ADDRESS DECODING
    -- We take bits 6 downto 2 to select one of 32 words (ignoring byte offsets)
    word_index <= to_integer(unsigned(Address(6 downto 2)));

    -- 2. WRITE ENABLE DECODER
    -- This generates the 'load' signal for the specific register being addressed
    gen_write_decode: for i in 0 to 31 generate
        write_en_bus(i) <= '1' when (word_index = i and MemWrite = '1') else '0';
    end generate;

    -- 3. STORAGE BANK (Registers)
    -- We instantiate 32 registers to act as our "RAM" cells
    gen_mem_cells: for i in 0 to 31 generate
        MEM_REG: Register_32 
            port map (
                clk => clk,
                load  => write_en_bus(i),
                Qin   => Write_data,
                Qout   => reg_outputs(i)
            );
    end generate;

    -- 4. READ MULTIPLEXER
    -- Selects the data based on the address. 
    -- If MemRead is '0', we output zeros (standard low-power RTL practice)
    Read_data <= reg_outputs(word_index) when (MemRead = '1') else x"00000000";

end architecture Structural;