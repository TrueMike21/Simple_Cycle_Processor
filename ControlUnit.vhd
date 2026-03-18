library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    port (
        Opcode   : in  std_logic_vector(5 downto 0);
        RegDst   : out std_logic;
        Jump     : out std_logic;
        Branch   : out std_logic;
        MemRead  : out std_logic;
        MemtoReg : out std_logic;
        ALUOp    : out std_logic_vector(1 downto 0);
        MemWrite : out std_logic;
        ALUSrc   : out std_logic;
        RegWrite : out std_logic
    );
end ControlUnit;

architecture Structural of ControlUnit is
    signal R_type, lw, sw, beq, j : std_logic;
begin
    -- 1. Identify the Instruction (Decoding the 6-bit Opcode)
    -- R-type: 000000, LW: 100011, SW: 101011, BEQ: 000100, J: 000010
    R_type <= '1' when Opcode = "000000" else '0';
    lw     <= '1' when Opcode = "100011" else '0';
    sw     <= '1' when Opcode = "101011" else '0';
    beq    <= '1' when Opcode = "000100" else '0';
    j      <= '1' when Opcode = "000010" else '0';

    -- 2. Define Output Signals based on the Instruction identified
    RegDst   <= R_type;
    ALUSrc   <= lw or sw;
    MemtoReg <= lw;
    RegWrite <= R_type or lw;
    MemRead  <= lw;
    MemWrite <= sw;
    Branch   <= beq;
    Jump     <= j;
    
    -- ALUOp: 10 for R-type, 01 for Branch, 00 for LW/SW
    ALUOp(1) <= R_type;
    ALUOp(0) <= beq;

end architecture Structural;