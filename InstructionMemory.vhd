library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    port (
        Read_address : in  std_logic_vector(31 downto 0);
        Instruction  : out std_logic_vector(31 downto 0)
    );
end InstructionMemory;

architecture Structural of InstructionMemory is

    -- Define the program as a series of 32-bit constants
    -- These represent MIPS machine code instructions
    constant INSTR_0 : std_logic_vector(31 downto 0) := x"01284820"; -- add $t1, $s1, $s2
    constant INSTR_1 : std_logic_vector(31 downto 0) := x"8D290000"; -- lw  $t1, 0($s1)
    constant INSTR_2 : std_logic_vector(31 downto 0) := x"00000000"; -- nop
    constant INSTR_3 : std_logic_vector(31 downto 0) := x"08000000"; -- j 0x0
    
    -- In MIPS, addresses are byte-aligned (PC+4). 
    -- We divide by 4 (shift right 2) to get the word index.
    signal word_address : integer range 0 to 1023;

begin

    -- Address Logic: Convert byte address to word index
    word_address <= to_integer(unsigned(Read_address(11 downto 2)));

    -- THE STRUCTURAL MUX (ROM Logic)
    -- This physically routes the constant bits to the output wires
    Instruction <= INSTR_0 when (word_address = 0) else
                   INSTR_1 when (word_address = 1) else
                   INSTR_2 when (word_address = 2) else
                   INSTR_3 when (word_address = 3) else
                   x"00000000"; -- Default/Empty memory

end architecture Structural;